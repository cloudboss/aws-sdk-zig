pub const WebCrawlerAuthType = enum {
    no_auth,
    basic_auth,
    form,
    saml,

    pub const json_field_names = .{
        .no_auth = "NO_AUTH",
        .basic_auth = "BASIC_AUTH",
        .form = "FORM",
        .saml = "SAML",
    };
};
