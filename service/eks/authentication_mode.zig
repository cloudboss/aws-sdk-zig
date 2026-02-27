pub const AuthenticationMode = enum {
    api,
    api_and_config_map,
    config_map,

    pub const json_field_names = .{
        .api = "API",
        .api_and_config_map = "API_AND_CONFIG_MAP",
        .config_map = "CONFIG_MAP",
    };
};
