const aws = @import("aws");

/// Information about a connector. Connectors run on the Greengrass core and
/// contain built-in integration with local infrastructure, device protocols,
/// AWS, and other cloud services.
pub const Connector = struct {
    /// The ARN of the connector.
    connector_arn: []const u8,

    /// A descriptive or arbitrary ID for the connector. This value must be unique
    /// within the connector definition version. Max length is 128 characters with
    /// pattern [a-zA-Z0-9:_-]+.
    id: []const u8,

    /// The parameters or configuration that the connector uses.
    parameters: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .connector_arn = "ConnectorArn",
        .id = "Id",
        .parameters = "Parameters",
    };
};
