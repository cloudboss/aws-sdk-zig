/// The source identifying the connector integration.
pub const ConnectorSource = struct {
    /// The identifier for the connector integration (for example,
    /// `bedrock-knowledge-bases`).
    connector_id: []const u8,

    /// The version of the connector to use (for example, `1.1.0`). If you don't
    /// specify a version, the service uses the latest available version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_id = "connectorId",
        .version = "version",
    };
};
