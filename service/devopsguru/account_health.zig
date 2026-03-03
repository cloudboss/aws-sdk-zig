const AccountInsightHealth = @import("account_insight_health.zig").AccountInsightHealth;

/// Returns the number of open reactive insights, the number of open proactive
/// insights,
/// and the number of metrics analyzed in your Amazon Web Services account. Use
/// these numbers to gauge the
/// health of operations in your Amazon Web Services account.
pub const AccountHealth = struct {
    /// The ID of the Amazon Web Services account.
    account_id: ?[]const u8 = null,

    /// Information about the health of the Amazon Web Services resources in your
    /// account, including the
    /// number of open proactive, open reactive insights, and the Mean Time to
    /// Recover (MTTR) of closed insights.
    insight: ?AccountInsightHealth = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .insight = "Insight",
    };
};
