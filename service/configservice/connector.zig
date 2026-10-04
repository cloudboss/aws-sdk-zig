const ConnectorConfiguration = @import("connector_configuration.zig").ConnectorConfiguration;

/// The details of the connector, including the connector configuration and
/// connector ARN.
pub const Connector = struct {
    /// The Amazon Resource Name (ARN) of the connector.
    arn: []const u8,

    /// The provider-specific configuration for connecting to the third-party cloud
    /// service provider.
    connector_configuration: ConnectorConfiguration,

    /// The date and time that the connector was created.
    created_time: i64,

    /// The name of the connector.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .connector_configuration = "connectorConfiguration",
        .created_time = "createdTime",
        .name = "name",
    };
};
