pub const AuthType = enum {
    oauth2,
    api_key,

    pub const json_field_names = .{
        .oauth2 = "OAUTH2",
        .api_key = "API_KEY",
    };
};
