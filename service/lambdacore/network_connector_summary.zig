const NetworkConnectorState = @import("network_connector_state.zig").NetworkConnectorState;
const NetworkConnectorType = @import("network_connector_type.zig").NetworkConnectorType;

/// Summary information about a network connector returned by
/// `ListNetworkConnectors`. Contains identifying fields and current state. To
/// retrieve full configuration details, use `GetNetworkConnector`.
pub const NetworkConnectorSummary = struct {
    /// The ARN of the network connector.
    arn: []const u8,

    /// The unique identifier of the network connector.
    id: []const u8,

    /// The date and time when the connector was last modified.
    last_modified: ?i64 = null,

    /// The version number of the connector's latest version. Each configuration
    /// update creates a new immutable version; this attribute exposes the most
    /// recent one.
    latest_version: ?i64 = null,

    /// The qualified ARN of the connector's latest version, including the immutable
    /// version suffix.
    latest_version_arn: ?[]const u8 = null,

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
        .latest_version = "LatestVersion",
        .latest_version_arn = "LatestVersionArn",
        .name = "Name",
        .state = "State",
        .type = "Type",
    };
};
