const ContinuousIntegrationScanConfiguration = @import("continuous_integration_scan_configuration.zig").ContinuousIntegrationScanConfiguration;
const PeriodicScanConfiguration = @import("periodic_scan_configuration.zig").PeriodicScanConfiguration;
const RuleSetCategory = @import("rule_set_category.zig").RuleSetCategory;

/// Contains the configuration settings for code security scans.
pub const CodeSecurityScanConfiguration = struct {
    /// Configuration settings for continuous integration scans that run
    /// automatically when code
    /// changes are made.
    continuous_integration_scan_configuration: ?ContinuousIntegrationScanConfiguration = null,

    /// Configuration settings for periodic scans that run on a scheduled basis.
    periodic_scan_configuration: ?PeriodicScanConfiguration = null,

    /// The categories of security rules to be applied during the scan.
    rule_set_categories: []const RuleSetCategory,

    pub const json_field_names = .{
        .continuous_integration_scan_configuration = "continuousIntegrationScanConfiguration",
        .periodic_scan_configuration = "periodicScanConfiguration",
        .rule_set_categories = "ruleSetCategories",
    };
};
