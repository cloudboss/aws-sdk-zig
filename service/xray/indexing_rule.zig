const IndexingRuleValue = @import("indexing_rule_value.zig").IndexingRuleValue;

/// Rule used to determine the server-side sampling rate for spans ingested
/// through the CloudWatchLogs destination and indexed by X-Ray.
pub const IndexingRule = struct {
    /// Displays when the rule was last modified, in Unix time seconds.
    modified_at: ?i64 = null,

    /// The name of the indexing rule.
    name: ?[]const u8 = null,

    /// The indexing rule.
    rule: ?IndexingRuleValue = null,

    pub const json_field_names = .{
        .modified_at = "ModifiedAt",
        .name = "Name",
        .rule = "Rule",
    };
};
