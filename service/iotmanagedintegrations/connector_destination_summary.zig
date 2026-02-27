/// Structure containing summary information about a connector destination,
/// which defines how a cloud-to-cloud connector connects to a customer's AWS
/// account.
pub const ConnectorDestinationSummary = struct {
    /// The identifier of the cloud connector associated with this connector
    /// destination.
    cloud_connector_id: ?[]const u8,

    /// A description of the connector destination.
    description: ?[]const u8,

    /// The unique identifier of the connector destination.
    id: ?[]const u8,

    /// The display name of the connector destination.
    name: ?[]const u8,

    pub const json_field_names = .{
        .cloud_connector_id = "CloudConnectorId",
        .description = "Description",
        .id = "Id",
        .name = "Name",
    };
};
