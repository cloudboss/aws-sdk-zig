pub const AuthType = enum {
    oauth,
    basic_auth,
    personal_access_token,
    codeconnections,
    secrets_manager,

    pub const json_field_names = .{
        .oauth = "OAUTH",
        .basic_auth = "BASIC_AUTH",
        .personal_access_token = "PERSONAL_ACCESS_TOKEN",
        .codeconnections = "CODECONNECTIONS",
        .secrets_manager = "SECRETS_MANAGER",
    };
};
