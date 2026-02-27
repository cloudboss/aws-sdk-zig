const LateDataRuleConfiguration = @import("late_data_rule_configuration.zig").LateDataRuleConfiguration;

/// A structure that contains the name and configuration information of a late
/// data
/// rule.
pub const LateDataRule = struct {
    /// The information needed to configure the late data rule.
    rule_configuration: LateDataRuleConfiguration,

    /// The name of the late data rule.
    rule_name: ?[]const u8,

    pub const json_field_names = .{
        .rule_configuration = "ruleConfiguration",
        .rule_name = "ruleName",
    };
};
