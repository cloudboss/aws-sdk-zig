const EventsConfig = @import("events_config.zig").EventsConfig;

/// Configuration settings that define the behavior and parameters of a
/// recommender.
pub const RecommenderConfig = struct {
    /// Configuration settings for how the recommender processes and uses events.
    events_config: EventsConfig,

    /// How often the recommender should retrain its model with new data.
    training_frequency: ?i32,

    pub const json_field_names = .{
        .events_config = "EventsConfig",
        .training_frequency = "TrainingFrequency",
    };
};
