pub const ReloadOptionValue = enum {
    data_reload,
    validate_only,

    pub const json_field_names = .{
        .data_reload = "DATA_RELOAD",
        .validate_only = "VALIDATE_ONLY",
    };
};
