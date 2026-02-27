const PagerDutyConfiguration = @import("pager_duty_configuration.zig").PagerDutyConfiguration;

/// Information about third-party services integrated into a response plan.
pub const Integration = union(enum) {
    /// Information about the PagerDuty service where the response plan creates an
    /// incident.
    pager_duty_configuration: ?PagerDutyConfiguration,

    pub const json_field_names = .{
        .pager_duty_configuration = "pagerDutyConfiguration",
    };
};
