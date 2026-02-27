pub const TrustedTokenIssuerType = enum {
    oidc_jwt,

    pub const json_field_names = .{
        .oidc_jwt = "OIDC_JWT",
    };
};
