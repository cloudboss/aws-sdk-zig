/// Provides details about the action to use in the place of the action that
/// results from the rule group
/// evaluation.
pub const AwsWafRegionalWebAclRulesListOverrideActionDetails = struct {
    /// Overrides the rule evaluation result in the rule group.
    type: ?[]const u8,

    pub const json_field_names = .{
        .type = "Type",
    };
};
