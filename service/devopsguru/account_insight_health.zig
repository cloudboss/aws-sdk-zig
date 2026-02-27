/// Information about the number of open reactive and proactive insights that
/// can be used
/// to gauge the health of your system.
pub const AccountInsightHealth = struct {
    /// An integer that specifies the number of open proactive insights in your
    /// Amazon Web Services
    /// account.
    open_proactive_insights: i32 = 0,

    /// An integer that specifies the number of open reactive insights in your
    /// Amazon Web Services
    /// account.
    open_reactive_insights: i32 = 0,

    pub const json_field_names = .{
        .open_proactive_insights = "OpenProactiveInsights",
        .open_reactive_insights = "OpenReactiveInsights",
    };
};
