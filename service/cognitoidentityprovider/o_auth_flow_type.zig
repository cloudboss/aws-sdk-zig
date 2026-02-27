pub const OAuthFlowType = enum {
    code,
    implicit,
    client_credentials,

    pub const json_field_names = .{
        .code = "code",
        .implicit = "implicit",
        .client_credentials = "client_credentials",
    };
};
