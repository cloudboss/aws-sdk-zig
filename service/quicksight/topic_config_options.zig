/// Configuration options for a `Topic`.
pub const TopicConfigOptions = struct {
    /// Enables Amazon Q Business Insights for a `Topic`.
    q_business_insights_enabled: ?bool,

    pub const json_field_names = .{
        .q_business_insights_enabled = "QBusinessInsightsEnabled",
    };
};
