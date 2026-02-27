pub const RuleType = enum {
    content_blocker_rule,
    content_retrieval_rule,

    pub const json_field_names = .{
        .content_blocker_rule = "CONTENT_BLOCKER_RULE",
        .content_retrieval_rule = "CONTENT_RETRIEVAL_RULE",
    };
};
