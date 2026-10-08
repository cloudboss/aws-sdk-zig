/// Configuration for Pagerduty integration.
pub const PagerDutyConfiguration = struct {
    /// Email to be used in Pagerduty API header
    customer_email: []const u8,

    /// List of Pagerduty service available for the association.
    services: []const []const u8,

    pub const json_field_names = .{
        .customer_email = "customerEmail",
        .services = "services",
    };
};
