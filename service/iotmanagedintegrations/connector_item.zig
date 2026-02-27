const EndpointConfig = @import("endpoint_config.zig").EndpointConfig;
const EndpointType = @import("endpoint_type.zig").EndpointType;
const CloudConnectorType = @import("cloud_connector_type.zig").CloudConnectorType;

/// Structure describing a connector.
pub const ConnectorItem = struct {
    /// A description of the C2C connector.
    description: ?[]const u8,

    /// The configuration details for the cloud connector endpoint, including
    /// connection parameters and authentication requirements.
    endpoint_config: EndpointConfig,

    /// The type of endpoint used for the C2C connector.
    endpoint_type: ?EndpointType,

    /// The identifier of the C2C connector.
    id: ?[]const u8,

    /// The display name of the C2C connector.
    name: []const u8,

    /// The type of cloud connector created.
    type: ?CloudConnectorType,

    pub const json_field_names = .{
        .description = "Description",
        .endpoint_config = "EndpointConfig",
        .endpoint_type = "EndpointType",
        .id = "Id",
        .name = "Name",
        .type = "Type",
    };
};
