/// Information about the SAML 2.0-compliant identity provider (IdP) used to
/// authenticate end users of an Amazon Q Business web experience.
pub const SamlProviderConfiguration = struct {
    /// The URL where Amazon Q Business end users will be redirected for
    /// authentication.
    authentication_url: []const u8,

    pub const json_field_names = .{
        .authentication_url = "authenticationUrl",
    };
};
