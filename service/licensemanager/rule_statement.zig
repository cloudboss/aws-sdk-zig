const InstanceRuleStatement = @import("instance_rule_statement.zig").InstanceRuleStatement;
const LicenseConfigurationRuleStatement = @import("license_configuration_rule_statement.zig").LicenseConfigurationRuleStatement;
const LicenseRuleStatement = @import("license_rule_statement.zig").LicenseRuleStatement;

/// Rule statement.
pub const RuleStatement = struct {
    /// Instance rule statement.
    instance_rule_statement: ?InstanceRuleStatement = null,

    /// License configuration rule statement.
    license_configuration_rule_statement: ?LicenseConfigurationRuleStatement = null,

    /// License rule statement.
    license_rule_statement: ?LicenseRuleStatement = null,

    pub const json_field_names = .{
        .instance_rule_statement = "InstanceRuleStatement",
        .license_configuration_rule_statement = "LicenseConfigurationRuleStatement",
        .license_rule_statement = "LicenseRuleStatement",
    };
};
