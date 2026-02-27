const RulePreviewTotal = @import("rule_preview_total.zig").RulePreviewTotal;

/// Contains a summary of preview results for an automation rule.
pub const PreviewResultSummary = struct {
    /// The key identifier for this preview result summary.
    key: []const u8,

    total: RulePreviewTotal,

    pub const json_field_names = .{
        .key = "key",
        .total = "total",
    };
};
