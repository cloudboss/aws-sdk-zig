pub const RegionType = enum {
    primary,
    additional,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .additional = "ADDITIONAL",
    };
};
