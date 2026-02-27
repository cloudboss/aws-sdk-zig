pub const SourceAuthType = enum {
    oauth,
    codeconnections,
    secrets_manager,

    pub const json_field_names = .{
        .oauth = "OAUTH",
        .codeconnections = "CODECONNECTIONS",
        .secrets_manager = "SECRETS_MANAGER",
    };
};
