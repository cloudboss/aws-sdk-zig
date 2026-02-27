/// Readiness rule information, including the resource type, rule ID, and rule
/// description.
pub const ListRulesOutput = struct {
    /// The resource type that the readiness rule applies to.
    resource_type: []const u8,

    /// The description of a readiness rule.
    rule_description: []const u8,

    /// The ID for the readiness rule.
    rule_id: []const u8,

    pub const json_field_names = .{
        .resource_type = "ResourceType",
        .rule_description = "RuleDescription",
        .rule_id = "RuleId",
    };
};
