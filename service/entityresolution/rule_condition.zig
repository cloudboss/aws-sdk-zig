/// An object that defines the `ruleCondition` and the `ruleName` to use in a
/// matching workflow.
pub const RuleCondition = struct {
    /// A statement that specifies the conditions for a matching rule.
    ///
    /// If your data is accurate, use an Exact matching function: `Exact` or
    /// `ExactManyToMany`.
    ///
    /// If your data has variations in spelling or pronunciation, use a Fuzzy
    /// matching function: `Cosine`, `Levenshtein`, or `Soundex`.
    ///
    /// Use operators if you want to combine (`AND`), separate (`OR`), or group
    /// matching functions `(...)`.
    ///
    /// For example: `(Cosine(a, 10) AND Exact(b, true)) OR ExactManyToMany(c, d)`
    condition: []const u8,

    /// A name for the matching rule.
    ///
    /// For example: `Rule1`
    rule_name: []const u8,

    pub const json_field_names = .{
        .condition = "condition",
        .rule_name = "ruleName",
    };
};
