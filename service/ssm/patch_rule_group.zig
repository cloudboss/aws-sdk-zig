const PatchRule = @import("patch_rule.zig").PatchRule;

/// A set of rules defining the approval rules for a patch baseline.
pub const PatchRuleGroup = struct {
    /// The rules that make up the rule group.
    patch_rules: []const PatchRule,

    pub const json_field_names = .{
        .patch_rules = "PatchRules",
    };
};
