/// Metadata about a rule. Rule metadata includes an ID, a name, a list of tags,
/// and a short and long description. CodeGuru Reviewer uses rules to analyze
/// code. A rule's recommendation is included in analysis results if code is
/// detected that violates the rule.
pub const RuleMetadata = struct {
    /// A long description of the rule.
    long_description: ?[]const u8 = null,

    /// The ID of the rule.
    rule_id: ?[]const u8 = null,

    /// The name of the rule.
    rule_name: ?[]const u8 = null,

    /// Tags that are associated with the rule.
    rule_tags: ?[]const []const u8 = null,

    /// A short description of the rule.
    short_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .long_description = "LongDescription",
        .rule_id = "RuleId",
        .rule_name = "RuleName",
        .rule_tags = "RuleTags",
        .short_description = "ShortDescription",
    };
};
