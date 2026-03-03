const RuleSetCategory = @import("rule_set_category.zig").RuleSetCategory;
const ContinuousIntegrationScanEvent = @import("continuous_integration_scan_event.zig").ContinuousIntegrationScanEvent;

/// Contains the continuous integration scan configuration settings applied to a
/// specific
/// project.
pub const ProjectContinuousIntegrationScanConfiguration = struct {
    /// The categories of security rules applied during continuous integration scans
    /// for the
    /// project.
    rule_set_categories: ?[]const RuleSetCategory = null,

    /// The repository event that triggers continuous integration scans for the
    /// project.
    supported_event: ?ContinuousIntegrationScanEvent = null,

    pub const json_field_names = .{
        .rule_set_categories = "ruleSetCategories",
        .supported_event = "supportedEvent",
    };
};
