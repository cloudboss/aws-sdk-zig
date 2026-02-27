pub const BuildType = enum {
    user_initiated,
    scheduled,
    import,
    import_iso,

    pub const json_field_names = .{
        .user_initiated = "USER_INITIATED",
        .scheduled = "SCHEDULED",
        .import = "IMPORT",
        .import_iso = "IMPORT_ISO",
    };
};
