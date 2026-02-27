const Connector = @import("connector.zig").Connector;

/// Information about the connector definition version, which is a container for
/// connectors.
pub const ConnectorDefinitionVersion = struct {
    /// A list of references to connectors in this version, with their corresponding
    /// configuration settings.
    connectors: ?[]const Connector,

    pub const json_field_names = .{
        .connectors = "Connectors",
    };
};
