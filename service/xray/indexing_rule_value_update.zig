const ProbabilisticRuleValueUpdate = @import("probabilistic_rule_value_update.zig").ProbabilisticRuleValueUpdate;

/// Update to an indexing rule.
pub const IndexingRuleValueUpdate = union(enum) {
    /// Indexing rule configuration that is used to probabilistically sample
    /// traceIds.
    probabilistic: ?ProbabilisticRuleValueUpdate,

    pub const json_field_names = .{
        .probabilistic = "Probabilistic",
    };
};
