const ConnectorConfiguration = @import("connector_configuration.zig").ConnectorConfiguration;
const ConnectorSource = @import("connector_source.zig").ConnectorSource;

/// Configuration for a connector integration target. Connectors provide
/// pre-built integrations with Amazon Web Services services and third-party
/// tools.
pub const ConnectorTargetConfiguration = struct {
    /// A list of per-tool configurations for the connector.
    configurations: ?[]const ConnectorConfiguration = null,

    /// A list of tool names to enable from this connector. If absent, all tools
    /// provided by the connector are enabled.
    enabled: ?[]const []const u8 = null,

    /// The source configuration identifying which connector to use.
    source: ConnectorSource,

    pub const json_field_names = .{
        .configurations = "configurations",
        .enabled = "enabled",
        .source = "source",
    };
};
