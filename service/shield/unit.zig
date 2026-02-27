pub const Unit = enum {
    bits,
    bytes,
    packets,
    requests,

    pub const json_field_names = .{
        .bits = "BITS",
        .bytes = "BYTES",
        .packets = "PACKETS",
        .requests = "REQUESTS",
    };
};
