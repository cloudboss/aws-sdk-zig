const ConnectorStatus = @import("connector_status.zig").ConnectorStatus;
const HealthIssue = @import("health_issue.zig").HealthIssue;

/// Information about the operational status and health of a connectorV2.
pub const HealthCheck = struct {
    /// The status of the connectorV2.
    connector_status: ConnectorStatus,

    /// A list of health issues associated with the connector, including error codes
    /// and messages.
    issues: ?[]const HealthIssue = null,

    /// ISO 8601 UTC timestamp for the time check the health status of the
    /// connectorV2.
    last_checked_at: i64,

    /// The message for the reason of connectorStatus change.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_status = "ConnectorStatus",
        .issues = "Issues",
        .last_checked_at = "LastCheckedAt",
        .message = "Message",
    };
};
