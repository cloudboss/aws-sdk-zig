pub const FederationProtocol = enum {
    saml,
    oauth,

    pub const json_field_names = .{
        .saml = "SAML",
        .oauth = "OAUTH",
    };
};
