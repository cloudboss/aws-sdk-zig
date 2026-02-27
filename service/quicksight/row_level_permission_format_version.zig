pub const RowLevelPermissionFormatVersion = enum {
    version_1,
    version_2,

    pub const json_field_names = .{
        .version_1 = "VERSION_1",
        .version_2 = "VERSION_2",
    };
};
