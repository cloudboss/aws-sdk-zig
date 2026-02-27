const ConnectorStatus = @import("connector_status.zig").ConnectorStatus;

/// Information about the operational status and health of a connectorV2.
pub const HealthCheck = struct {
    /// The status of the connectorV2.
    connector_status: ConnectorStatus,

    /// ISO 8601 UTC timestamp for the time check the health status of the
    /// connectorV2.
    last_checked_at: i64,

    /// The message for the reason of connectorStatus change.
    message: ?[]const u8,

    pub const json_field_names = .{
        .connector_status = "ConnectorStatus",
        .last_checked_at = "LastCheckedAt",
        .message = "Message",
    };
};
