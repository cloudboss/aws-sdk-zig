pub const Operation = enum {
    enable_scanning,
    disable_scanning,
    enable_repository,
    disable_repository,

    pub const json_field_names = .{
        .enable_scanning = "ENABLE_SCANNING",
        .disable_scanning = "DISABLE_SCANNING",
        .enable_repository = "ENABLE_REPOSITORY",
        .disable_repository = "DISABLE_REPOSITORY",
    };
};
