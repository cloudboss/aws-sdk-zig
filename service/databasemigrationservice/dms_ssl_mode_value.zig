pub const DmsSslModeValue = enum {
    none,
    require,
    verify_ca,
    verify_full,

    pub const json_field_names = .{
        .none = "NONE",
        .require = "REQUIRE",
        .verify_ca = "VERIFY_CA",
        .verify_full = "VERIFY_FULL",
    };
};
