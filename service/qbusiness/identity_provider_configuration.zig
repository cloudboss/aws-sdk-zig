const OpenIDConnectProviderConfiguration = @import("open_id_connect_provider_configuration.zig").OpenIDConnectProviderConfiguration;
const SamlProviderConfiguration = @import("saml_provider_configuration.zig").SamlProviderConfiguration;

/// Provides information about the identity provider (IdP) used to authenticate
/// end users of an Amazon Q Business web experience.
pub const IdentityProviderConfiguration = union(enum) {
    open_id_connect_configuration: ?OpenIDConnectProviderConfiguration,
    saml_configuration: ?SamlProviderConfiguration,

    pub const json_field_names = .{
        .open_id_connect_configuration = "openIDConnectConfiguration",
        .saml_configuration = "samlConfiguration",
    };
};
