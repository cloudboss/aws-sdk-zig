const ContentBlockerRule = @import("content_blocker_rule.zig").ContentBlockerRule;
const ContentRetrievalRule = @import("content_retrieval_rule.zig").ContentRetrievalRule;

/// Provides configuration information about a rule.
pub const RuleConfiguration = union(enum) {
    /// A rule for configuring how Amazon Q Business responds when it encounters a a
    /// blocked topic.
    content_blocker_rule: ?ContentBlockerRule,
    content_retrieval_rule: ?ContentRetrievalRule,

    pub const json_field_names = .{
        .content_blocker_rule = "contentBlockerRule",
        .content_retrieval_rule = "contentRetrievalRule",
    };
};
