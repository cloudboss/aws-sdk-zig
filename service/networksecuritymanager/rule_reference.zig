/// A reference to a rule in a create or update request.
pub const RuleReference = struct {
    /// The identifier of the rule. This is the rule's Amazon Resource Name (ARN).
    rule_identifier: []const u8,

    pub const json_field_names = .{
        .rule_identifier = "ruleIdentifier",
    };
};
