pub const KeyLocation = enum {
    url,
    secret_manager,

    pub const json_field_names = .{
        .url = "URL",
        .secret_manager = "SECRET_MANAGER",
    };
};
