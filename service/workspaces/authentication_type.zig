pub const AuthenticationType = enum {
    saml,

    pub const json_field_names = .{
        .saml = "SAML",
    };
};
