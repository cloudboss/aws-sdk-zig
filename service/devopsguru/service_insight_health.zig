/// Contains the number of open proactive and reactive insights in an analyzed
/// Amazon Web Services
/// service.
pub const ServiceInsightHealth = struct {
    /// The number of open proactive insights in the Amazon Web Services service
    open_proactive_insights: i32 = 0,

    /// The number of open reactive insights in the Amazon Web Services service
    open_reactive_insights: i32 = 0,

    pub const json_field_names = .{
        .open_proactive_insights = "OpenProactiveInsights",
        .open_reactive_insights = "OpenReactiveInsights",
    };
};
