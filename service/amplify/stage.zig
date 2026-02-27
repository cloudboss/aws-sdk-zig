pub const Stage = enum {
    production,
    beta,
    development,
    experimental,
    pull_request,

    pub const json_field_names = .{
        .production = "PRODUCTION",
        .beta = "BETA",
        .development = "DEVELOPMENT",
        .experimental = "EXPERIMENTAL",
        .pull_request = "PULL_REQUEST",
    };
};
