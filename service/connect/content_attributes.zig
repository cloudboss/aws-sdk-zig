const RecommenderConfig = @import("recommender_config.zig").RecommenderConfig;

/// Optional attributes used to populate the content of an outbound web
/// notification, such as recommender
/// configuration for personalized content.
pub const ContentAttributes = struct {
    /// Configuration for the recommender used to generate personalized
    /// recommendations for the notification
    /// content.
    recommender_config: ?RecommenderConfig = null,

    pub const json_field_names = .{
        .recommender_config = "RecommenderConfig",
    };
};
