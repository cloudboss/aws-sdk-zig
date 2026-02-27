const RecommendedActionTotal = @import("recommended_action_total.zig").RecommendedActionTotal;

/// Summary information about recommended actions, grouped by specific criteria
/// with totals and counts.
pub const RecommendedActionSummary = struct {
    /// The grouping key used to categorize the recommended actions in this summary.
    key: []const u8,

    /// Aggregate totals for the recommended actions in this group, including count
    /// and estimated savings.
    total: RecommendedActionTotal,

    pub const json_field_names = .{
        .key = "key",
        .total = "total",
    };
};
