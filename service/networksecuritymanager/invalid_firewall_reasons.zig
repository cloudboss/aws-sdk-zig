const ConfigurationIssue = @import("configuration_issue.zig").ConfigurationIssue;

/// Details about the ways in which a firewall's configuration differs from the
/// intended configuration.
pub const InvalidFirewallReasons = struct {
    /// Appendable configuration values that are present but in the wrong order.
    incorrect_appendable_configuration_order: ?[]const ConfigurationIssue = null,

    /// Single-value configuration settings whose values do not match the expected
    /// values.
    incorrect_single_value_configurations: ?[]const ConfigurationIssue = null,

    /// Appendable configuration values that are expected but missing.
    missing_appendable_configuration_values: ?[]const ConfigurationIssue = null,

    /// Mergeable configuration values that are expected but missing.
    missing_mergeable_configuration_values: ?[]const ConfigurationIssue = null,

    /// Appendable configuration values that are present but not expected.
    unexpected_appendable_configuration_values: ?[]const ConfigurationIssue = null,

    /// Mergeable configuration values that are present but not expected.
    unexpected_mergeable_configuration_values: ?[]const ConfigurationIssue = null,

    pub const json_field_names = .{
        .incorrect_appendable_configuration_order = "incorrectAppendableConfigurationOrder",
        .incorrect_single_value_configurations = "incorrectSingleValueConfigurations",
        .missing_appendable_configuration_values = "missingAppendableConfigurationValues",
        .missing_mergeable_configuration_values = "missingMergeableConfigurationValues",
        .unexpected_appendable_configuration_values = "unexpectedAppendableConfigurationValues",
        .unexpected_mergeable_configuration_values = "unexpectedMergeableConfigurationValues",
    };
};
