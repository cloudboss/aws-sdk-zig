const MappingRule = @import("mapping_rule.zig").MappingRule;

/// A container for rules.
pub const RulesConfigurationType = struct {
    /// An array of rules. You can specify up to 25 rules per identity provider.
    ///
    /// Rules are evaluated in order. The first one to match specifies the role.
    rules: []const MappingRule,

    pub const json_field_names = .{
        .rules = "Rules",
    };
};
