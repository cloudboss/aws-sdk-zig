const SamlConfiguration = @import("saml_configuration.zig").SamlConfiguration;
const SamlConfigurationStatus = @import("saml_configuration_status.zig").SamlConfigurationStatus;

/// A structure containing information about how this workspace works with SAML.
pub const SamlAuthentication = struct {
    /// A structure containing details about how this workspace works with SAML.
    configuration: ?SamlConfiguration,

    /// Specifies whether the workspace's SAML configuration is complete.
    status: SamlConfigurationStatus,

    pub const json_field_names = .{
        .configuration = "configuration",
        .status = "status",
    };
};
