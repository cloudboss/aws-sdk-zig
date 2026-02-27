pub const OrcFormatVersion = enum {
    v0_11,
    v0_12,

    pub const json_field_names = .{
        .v0_11 = "V0_11",
        .v0_12 = "V0_12",
    };
};
