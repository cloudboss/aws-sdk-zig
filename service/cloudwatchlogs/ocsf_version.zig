pub const OCSFVersion = enum {
    v1_1,
    v1_5,

    pub const json_field_names = .{
        .v1_1 = "V1_1",
        .v1_5 = "V1_5",
    };
};
