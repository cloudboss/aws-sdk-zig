/// Data associated with the QUERY RecommendationTriggerType.
pub const QueryRecommendationTriggerData = struct {
    /// The text associated with the recommendation trigger.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .text = "text",
    };
};
