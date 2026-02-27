const PagerDutyIncidentConfiguration = @import("pager_duty_incident_configuration.zig").PagerDutyIncidentConfiguration;

/// Details about the PagerDuty configuration for a response plan.
pub const PagerDutyConfiguration = struct {
    /// The name of the PagerDuty configuration.
    name: []const u8,

    /// Details about the PagerDuty service associated with the configuration.
    pager_duty_incident_configuration: PagerDutyIncidentConfiguration,

    /// The ID of the Amazon Web Services Secrets Manager secret that stores your
    /// PagerDuty key, either a General Access REST API Key or
    /// User Token REST API Key, and other user credentials.
    secret_id: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .pager_duty_incident_configuration = "pagerDutyIncidentConfiguration",
        .secret_id = "secretId",
    };
};
