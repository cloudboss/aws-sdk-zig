const ConnectorConfigProvider = @import("connector_config_provider.zig").ConnectorConfigProvider;

/// The configuration sent to a cluster for configuration.
pub const ConnectorConfigRequest = struct {
    /// The cloud provider for the target cluster to connect.
    provider: ConnectorConfigProvider,

    /// The Amazon Resource Name (ARN) of the role that is authorized to request the
    /// connector
    /// configuration.
    role_arn: []const u8,

    pub const json_field_names = .{
        .provider = "provider",
        .role_arn = "roleArn",
    };
};
