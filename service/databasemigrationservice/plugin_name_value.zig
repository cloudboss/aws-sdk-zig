pub const PluginNameValue = enum {
    no_preference,
    test_decoding,
    pglogical,

    pub const json_field_names = .{
        .no_preference = "NO_PREFERENCE",
        .test_decoding = "TEST_DECODING",
        .pglogical = "PGLOGICAL",
    };
};
