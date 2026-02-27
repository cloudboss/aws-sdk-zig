pub const KeySpec = enum {
    key_exchange,
    signature,

    pub const json_field_names = .{
        .key_exchange = "KEY_EXCHANGE",
        .signature = "SIGNATURE",
    };
};
