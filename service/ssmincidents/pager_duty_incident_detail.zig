/// Details about the PagerDuty incident associated with an incident created by
/// an Incident Manager
/// response plan.
pub const PagerDutyIncidentDetail = struct {
    /// Indicates whether to resolve the PagerDuty incident when you resolve the
    /// associated
    /// Incident Manager incident.
    auto_resolve: ?bool = null,

    /// The ID of the incident associated with the PagerDuty service for the
    /// response plan.
    id: []const u8,

    /// The ID of the Amazon Web Services Secrets Manager secret that stores your
    /// PagerDuty key, either a General Access REST API Key or
    /// User Token REST API Key, and other user credentials.
    secret_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_resolve = "autoResolve",
        .id = "id",
        .secret_id = "secretId",
    };
};
