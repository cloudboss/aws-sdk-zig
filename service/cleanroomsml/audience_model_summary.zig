const AudienceModelStatus = @import("audience_model_status.zig").AudienceModelStatus;

/// Information about the audience model.
pub const AudienceModelSummary = struct {
    /// The Amazon Resource Name (ARN) of the audience model.
    audience_model_arn: []const u8,

    /// The time at which the audience model was created.
    create_time: i64,

    /// The description of the audience model.
    description: ?[]const u8 = null,

    /// The name of the audience model.
    name: []const u8,

    /// The status of the audience model.
    status: AudienceModelStatus,

    /// The Amazon Resource Name (ARN) of the training dataset that was used for the
    /// audience model.
    training_dataset_arn: []const u8,

    /// The most recent time at which the audience model was updated.
    update_time: i64,

    pub const json_field_names = .{
        .audience_model_arn = "audienceModelArn",
        .create_time = "createTime",
        .description = "description",
        .name = "name",
        .status = "status",
        .training_dataset_arn = "trainingDatasetArn",
        .update_time = "updateTime",
    };
};
