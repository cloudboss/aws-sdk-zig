const aws = @import("aws");

const ContinuousIntegrationScanEvent = @import("continuous_integration_scan_event.zig").ContinuousIntegrationScanEvent;
const PeriodicScanFrequency = @import("periodic_scan_frequency.zig").PeriodicScanFrequency;
const RuleSetCategory = @import("rule_set_category.zig").RuleSetCategory;
const ScopeSettings = @import("scope_settings.zig").ScopeSettings;

/// A summary of information about a code security scan configuration.
pub const CodeSecurityScanConfigurationSummary = struct {
    /// The repository events that trigger continuous integration scans.
    continuous_integration_scan_supported_events: ?[]const ContinuousIntegrationScanEvent = null,

    /// The schedule expression for periodic scans, in cron format.
    frequency_expression: ?[]const u8 = null,

    /// The name of the scan configuration.
    name: []const u8,

    /// The Amazon Web Services account ID that owns the scan configuration.
    owner_account_id: []const u8,

    /// The frequency at which periodic scans are performed.
    periodic_scan_frequency: ?PeriodicScanFrequency = null,

    /// The categories of security rules applied during the scan.
    rule_set_categories: []const RuleSetCategory,

    /// The Amazon Resource Name (ARN) of the scan configuration.
    scan_configuration_arn: []const u8,

    /// The scope settings that define which repositories will be scanned. If the
    /// `ScopeSetting` parameter is `ALL` the scan configuration applies
    /// to all existing and future projects imported into Amazon Inspector.
    scope_settings: ?ScopeSettings = null,

    /// The tags associated with the scan configuration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .continuous_integration_scan_supported_events = "continuousIntegrationScanSupportedEvents",
        .frequency_expression = "frequencyExpression",
        .name = "name",
        .owner_account_id = "ownerAccountId",
        .periodic_scan_frequency = "periodicScanFrequency",
        .rule_set_categories = "ruleSetCategories",
        .scan_configuration_arn = "scanConfigurationArn",
        .scope_settings = "scopeSettings",
        .tags = "tags",
    };
};
