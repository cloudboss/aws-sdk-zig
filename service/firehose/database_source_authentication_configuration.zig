const SecretsManagerConfiguration = @import("secrets_manager_configuration.zig").SecretsManagerConfiguration;

/// The structure to configure the authentication methods for Firehose to
/// connect to source database endpoint.
///
/// Amazon Data Firehose is in preview release and is subject to change.
pub const DatabaseSourceAuthenticationConfiguration = struct {
    secrets_manager_configuration: SecretsManagerConfiguration,

    pub const json_field_names = .{
        .secrets_manager_configuration = "SecretsManagerConfiguration",
    };
};
