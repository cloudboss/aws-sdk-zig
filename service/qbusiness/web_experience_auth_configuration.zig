const SamlConfiguration = @import("saml_configuration.zig").SamlConfiguration;

/// Provides the authorization configuration information needed to deploy a
/// Amazon Q Business web experience to end users.
pub const WebExperienceAuthConfiguration = union(enum) {
    saml_configuration: ?SamlConfiguration,

    pub const json_field_names = .{
        .saml_configuration = "samlConfiguration",
    };
};
