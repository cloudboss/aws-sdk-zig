const TrainingDatasetStatus = @import("training_dataset_status.zig").TrainingDatasetStatus;

/// Provides information about the training dataset.
pub const TrainingDatasetSummary = struct {
    /// The time at which the training dataset was created.
    create_time: i64,

    /// The description of the training dataset.
    description: ?[]const u8,

    /// The name of the training dataset.
    name: []const u8,

    /// The status of the training dataset.
    status: TrainingDatasetStatus,

    /// The Amazon Resource Name (ARN) of the training dataset.
    training_dataset_arn: []const u8,

    /// The most recent time at which the training dataset was updated.
    update_time: i64,

    pub const json_field_names = .{
        .create_time = "createTime",
        .description = "description",
        .name = "name",
        .status = "status",
        .training_dataset_arn = "trainingDatasetArn",
        .update_time = "updateTime",
    };
};
