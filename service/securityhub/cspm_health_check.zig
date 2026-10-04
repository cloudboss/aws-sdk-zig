const CspmConnectorStatus = @import("cspm_connector_status.zig").CspmConnectorStatus;
const HealthIssue = @import("health_issue.zig").HealthIssue;

/// Information about the operational status and health of a CSPM connector.
pub const CspmHealthCheck = struct {
    /// The connectivity status of the connector.
    connector_status: CspmConnectorStatus,

    /// A list of health issues associated with the connector.
    issues: ?[]const HealthIssue = null,

    /// The ISO 8601 UTC timestamp indicating when the health status was last
    /// checked.
    last_checked_at: i64,

    /// A message describing the reason for the current connector status.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_status = "ConnectorStatus",
        .issues = "Issues",
        .last_checked_at = "LastCheckedAt",
        .message = "Message",
    };
};
