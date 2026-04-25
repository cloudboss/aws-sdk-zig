const aws = @import("aws");

const EventsConfig = @import("events_config.zig").EventsConfig;
const InferenceConfig = @import("inference_config.zig").InferenceConfig;

/// Configuration settings that define the behavior and parameters of a
/// recommender.
pub const RecommenderConfig = struct {
    /// Configuration settings for how the recommender processes and uses events.
    events_config: ?EventsConfig = null,

    /// A map of dataset type to a list of column names to train on. The column
    /// names must be a subset of the columns defined in the recommender schema. If
    /// not specified, all columns in the schema are used for training. The
    /// following columns are always included and do not need to be specified:
    /// `Item.Id`, `ItemList[].Id`, `EventTimestamp`, `EventType`, and `EventValue`.
    included_columns: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// Configuration settings for how the recommender handles inference requests.
    inference_config: ?InferenceConfig = null,

    /// How often the recommender should retrain its model with new data.
    training_frequency: ?i32 = null,

    pub const json_field_names = .{
        .events_config = "EventsConfig",
        .included_columns = "IncludedColumns",
        .inference_config = "InferenceConfig",
        .training_frequency = "TrainingFrequency",
    };
};
