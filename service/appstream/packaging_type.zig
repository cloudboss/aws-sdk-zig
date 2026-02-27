pub const PackagingType = enum {
    custom,
    appstream2,

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .appstream2 = "APPSTREAM2",
    };
};
