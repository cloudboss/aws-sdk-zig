/// A structure that contains the settings for a keyword match task.
pub const KeywordMatchConfiguration = struct {
    /// The keywords or phrases that you want to match.
    keywords: []const []const u8,

    /// Matches keywords or phrases on their presence or absence. If set to `TRUE`,
    /// the rule matches when all
    /// the specified keywords or phrases are absent. Default: `FALSE`.
    negate: bool = false,

    /// The name of the keyword match rule.
    rule_name: []const u8,

    pub const json_field_names = .{
        .keywords = "Keywords",
        .negate = "Negate",
        .rule_name = "RuleName",
    };
};
