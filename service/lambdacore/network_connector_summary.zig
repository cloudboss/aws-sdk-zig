const NetworkConnectorState = @import("network_connector_state.zig").NetworkConnectorState;
const NetworkConnectorType = @import("network_connector_type.zig").NetworkConnectorType;

/// Summary information about a network connector returned by
/// `ListNetworkConnectors`. Contains identifying fields and current state. To
/// retrieve full configuration details, use `GetNetworkConnector`.
pub const NetworkConnectorSummary = struct {
    /// The ARN of the network connector.
    arn: []const u8,

    id: []const u8,

    /// The date and time when the connector was last modified.
    last_modified: ?i64 = null,

    /// The name of the network connector.
    name: []const u8,

    /// The current state of the network connector.
    state: ?NetworkConnectorState = null,

    /// The type of the network connector (`VPC_EGRESS`).
    type: NetworkConnectorType,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .last_modified = "LastModified",
        .name = "Name",
        .state = "State",
        .type = "Type",
    };
};
