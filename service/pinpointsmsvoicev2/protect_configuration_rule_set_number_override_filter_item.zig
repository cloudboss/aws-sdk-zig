const ProtectConfigurationRuleSetNumberOverrideFilterName = @import("protect_configuration_rule_set_number_override_filter_name.zig").ProtectConfigurationRuleSetNumberOverrideFilterName;

/// The information for a protect configuration rule set number override that
/// meets a specified criteria.
pub const ProtectConfigurationRuleSetNumberOverrideFilterItem = struct {
    /// The name of the attribute to filter on.
    name: ProtectConfigurationRuleSetNumberOverrideFilterName,

    /// An array values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
