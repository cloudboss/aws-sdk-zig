/// Contains information about a goal associated with a recommendation.
pub const RecommendationGoal = struct {
    /// The title of the goal associated with the recommendation.
    title: []const u8,

    pub const json_field_names = .{
        .title = "title",
    };
};
