const ConnectorType = @import("connector_type.zig").ConnectorType;
const DestinationConnectorProperties = @import("destination_connector_properties.zig").DestinationConnectorProperties;

/// Contains information about the configuration of destination connectors
/// present in the
/// flow.
pub const DestinationFlowConfig = struct {
    /// The API version that the destination connector uses.
    api_version: ?[]const u8 = null,

    /// The name of the connector profile. This name must be unique for each
    /// connector profile in
    /// the Amazon Web Services account.
    connector_profile_name: ?[]const u8 = null,

    /// The type of connector, such as Salesforce, Amplitude, and so on.
    connector_type: ConnectorType,

    /// This stores the information that is required to query a particular
    /// connector.
    destination_connector_properties: DestinationConnectorProperties,

    pub const json_field_names = .{
        .api_version = "apiVersion",
        .connector_profile_name = "connectorProfileName",
        .connector_type = "connectorType",
        .destination_connector_properties = "destinationConnectorProperties",
    };
};
