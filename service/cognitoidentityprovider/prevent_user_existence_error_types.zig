pub const PreventUserExistenceErrorTypes = enum {
    legacy,
    enabled,

    pub const json_field_names = .{
        .legacy = "LEGACY",
        .enabled = "ENABLED",
    };
};
