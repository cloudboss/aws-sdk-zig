pub const DiskRedundancy = enum {
    high,
    normal,

    pub const json_field_names = .{
        .high = "HIGH",
        .normal = "NORMAL",
    };
};
