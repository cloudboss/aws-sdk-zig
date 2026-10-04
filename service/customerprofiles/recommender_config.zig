const aws = @import("aws");

const DiversityConfig = @import("diversity_config.zig").DiversityConfig;
const EventsConfig = @import("events_config.zig").EventsConfig;
const InferenceConfig = @import("inference_config.zig").InferenceConfig;

/// Configuration settings that define the behavior and parameters of a
/// recommender.
pub const RecommenderConfig = struct {
    /// Configuration for diversity-aware recommendations. When set, the recommender
    /// applies diversity constraints defined per item column to reduce
    /// over-concentration of similar items in the results.
    diversity_config: ?DiversityConfig = null,

    /// Configuration settings for how the recommender processes and uses events.
    events_config: ?EventsConfig = null,

    /// A map of dataset type to a list of column names to exclude from training.
    /// The `_webAnalytics` and `_catalogItem` keys are supported. The column names
    /// must be valid columns defined in the recommender schema. All columns in the
    /// schema except the listed columns will be used for training. The following
    /// columns are mandatory and cannot be excluded: `Item.Id`, `EventTimestamp`,
    /// and `EventType` for `_webAnalytics`; `Id` for `_catalogItem`. Mutually
    /// exclusive with IncludedColumns — both cannot be specified in the same
    /// request.
    excluded_columns: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// A map of dataset type to a list of column names to train on. The
    /// `_webAnalytics` and `_catalogItem` keys are supported. The column names must
    /// be a subset of the columns defined in the recommender schema. If not
    /// specified, all columns in the schema are used for training. The following
    /// columns are always included in training and do not need to be specified:
    /// `Item.Id`, `EventTimestamp`, and `EventType` for `_webAnalytics`; `Id` for
    /// `_catalogItem`. Mutually exclusive with ExcludedColumns — both cannot be
    /// specified in the same request.
    included_columns: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// Configuration settings for how the recommender handles inference requests.
    inference_config: ?InferenceConfig = null,

    /// How often the recommender should retrain its model with new data. If set to
    /// 0, automatic retraining will not be enabled.
    training_frequency: ?i32 = null,

    pub const json_field_names = .{
        .diversity_config = "DiversityConfig",
        .events_config = "EventsConfig",
        .excluded_columns = "ExcludedColumns",
        .included_columns = "IncludedColumns",
        .inference_config = "InferenceConfig",
        .training_frequency = "TrainingFrequency",
    };
};
