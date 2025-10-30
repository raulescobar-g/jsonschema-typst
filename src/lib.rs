use wasm_minimal_protocol::*;

initiate_protocol!();

#[wasm_func]
pub fn validate(schema: &[u8], json: &[u8]) -> Result<Vec<u8>, String> {
    let schema_str = std::str::from_utf8(schema)
        .map_err(|op| format!("Invalid UTF-8 in schema: {}", op))?;
    let json_str = std::str::from_utf8(json)
        .map_err(|op| format!("Invalid UTF-8 in json: {}", op))?;

    let schema = serde_json::from_str(schema_str)
        .map_err(|op| format!("Invalid JSON in schema: {}", op))?;
    let json = serde_json::from_str(json_str)
        .map_err(|op| format!("Invalid JSON in json: {}", op))?;

    let validator = jsonschema::validator_for(&schema).map_err(|e| {
        return format!("Invalid schema: {}", e);
    })?;

    if !validator.is_valid(&json) {
        let errors = validator.iter_errors(&json);
        let collected_errors = errors.map(|e| {
            format!("\nAccepts:   {:?}\nGot:       {}\nLocation:  {}\n", e.kind, e.instance, e.instance_path)
        }).collect::<Vec<String>>().join("");

        return Err(collected_errors);
    } else {
        Ok(json_str.as_bytes().to_vec())
    }
}


// ---------------------------------
// custom random entry source
// ---------------------------------
use core::num::Wrapping;
use getrandom::Error;

/// custom random entry source (ripped from chatgpt lmao)
/// 
/// Not cryptographically secure, but good enough for hash seeding (i think).
fn my_entropy_source(buf: &mut [u8]) -> Result<(), getrandom::Error> {
    let t = core::time::Duration::from_nanos(
        (buf.as_ptr() as usize as u64).wrapping_mul(0x9E3779B97F4A7C15),
    )
    .as_nanos() as u64;

    let stack_jitter = {
        let x = 0u64;
        &x as *const u64 as usize as u64
    };

    let mut s = Wrapping(
        0xA076_1D64_78BD_642Fu64
            ^ t.rotate_left(17)
            ^ (stack_jitter.wrapping_mul(0x9E37_79B9_7F4A_7C15))
            ^ (buf.len() as u64).wrapping_mul(0xBF58_476D_1CE4_E5B9),
    );

    if s.0 == 0 {
        s = Wrapping(0x2545_F491_4F6C_DD1D);
    }

    #[inline]
    fn next(state: &mut Wrapping<u64>) -> u64 {
        let mut x = state.0;
        x ^= x >> 12;
        x ^= x << 25;
        x ^= x >> 27;
        *state = Wrapping(x);
        x.wrapping_mul(0x2545F4914F6CDD1D)
    }

    let mut i = 0;
    while i + 8 <= buf.len() {
        let r = next(&mut s).to_le_bytes();
        buf[i..i + 8].copy_from_slice(&r);
        i += 8;
    }
    if i < buf.len() {
        let r = next(&mut s).to_le_bytes();
        let rem = &mut buf[i..];
        rem.copy_from_slice(&r[..rem.len()]);
    }

    Ok(())
}

/// from getrandom crate docs on custom backend
#[no_mangle]
unsafe extern "Rust" fn __getrandom_v03_custom(
    dest: *mut u8,
    len: usize,
) -> Result<(), Error> {
    let buf = unsafe {
        core::ptr::write_bytes(dest, 0, len);
        core::slice::from_raw_parts_mut(dest, len)
    };
    my_entropy_source(buf)
}
