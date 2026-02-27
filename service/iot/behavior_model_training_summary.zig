const ModelStatus = @import("model_status.zig").ModelStatus;

/// The summary of an ML Detect behavior model.
pub const BehaviorModelTrainingSummary = struct {
    /// The name of the behavior.
    behavior_name: ?[]const u8,

    /// The percentage of datapoints collected.
    datapoints_collection_percentage: ?f64,

    /// The date the model was last refreshed.
    last_model_refresh_date: ?i64,

    /// The status of the behavior model.
    model_status: ?ModelStatus,

    /// The name of the security profile.
    security_profile_name: ?[]const u8,

    /// The date a training model started collecting data.
    training_data_collection_start_date: ?i64,

    pub const json_field_names = .{
        .behavior_name = "behaviorName",
        .datapoints_collection_percentage = "datapointsCollectionPercentage",
        .last_model_refresh_date = "lastModelRefreshDate",
        .model_status = "modelStatus",
        .security_profile_name = "securityProfileName",
        .training_data_collection_start_date = "trainingDataCollectionStartDate",
    };
};
