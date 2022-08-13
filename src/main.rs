use std::{env::args, time::Duration};

use print_bytes::print_bytes;

fn main() {
    let argz = args().collect::<Vec<_>>();

    // 1356, 2508
    let vendor_id: u16 = argz[1].parse().unwrap();
    let product_id: u16 = argz[2].parse().unwrap();

    let mut device = hid::init()
        .unwrap()
        .devices()
        .find(|device| device.vendor_id() == vendor_id && device.product_id() == product_id)
        .unwrap()
        .open()
        .unwrap();

    loop {
        let mut d = device.data();

        // 64 bytes
        let mut arr = [0u8; 64];

        d.read(&mut arr, Duration::from_secs(5)).unwrap();
        print_bytes(&arr)
    }
}
