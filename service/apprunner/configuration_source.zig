pub const ConfigurationSource = enum {
    repository,
    api,

    pub const json_field_names = .{
        .repository = "REPOSITORY",
        .api = "API",
    };
};
