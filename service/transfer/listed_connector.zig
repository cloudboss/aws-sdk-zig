/// Returns details of the connector that is specified.
pub const ListedConnector = struct {
    /// The Amazon Resource Name (ARN) of the specified connector.
    arn: ?[]const u8 = null,

    /// The unique identifier for the connector.
    connector_id: ?[]const u8 = null,

    /// The URL of the partner's AS2 or SFTP endpoint.
    ///
    /// When creating AS2 connectors or service-managed SFTP connectors (connectors
    /// without egress configuration), you must provide a URL to specify the remote
    /// server endpoint. For VPC Lattice type connectors, the URL must be null.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .connector_id = "ConnectorId",
        .url = "Url",
    };
};
