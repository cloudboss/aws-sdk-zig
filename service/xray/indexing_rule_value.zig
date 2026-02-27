const ProbabilisticRuleValue = @import("probabilistic_rule_value.zig").ProbabilisticRuleValue;

/// The indexing rule configuration.
pub const IndexingRuleValue = union(enum) {
    /// Indexing rule configuration that is used to probabilistically sample
    /// traceIds.
    probabilistic: ?ProbabilisticRuleValue,

    pub const json_field_names = .{
        .probabilistic = "Probabilistic",
    };
};
