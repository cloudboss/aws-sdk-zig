const ConnectorHealthStatus = @import("connector_health_status.zig").ConnectorHealthStatus;

/// The health and connectivity status of a connector, including the last time
/// the status was checked and any diagnostic message. Returned as part of the
/// `Connector` structure.
pub const ConnectorHealth = struct {
    /// The health status of the connector.
    connector_status: ConnectorHealthStatus,

    /// The date and time when the connector health was last checked.
    last_checked_at: i64,

    /// A message providing additional details about the connector health status.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_status = "connectorStatus",
        .last_checked_at = "lastCheckedAt",
        .message = "message",
    };
};
