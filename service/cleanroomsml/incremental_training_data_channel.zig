/// Defines an incremental training data channel that references a previously
/// trained model. Incremental training allows you to update an existing trained
/// model with new data, building upon the knowledge from a base model rather
/// than training from scratch. This can significantly reduce training time and
/// computational costs while improving model performance with additional data.
pub const IncrementalTrainingDataChannel = struct {
    /// The name of the incremental training data channel. This name is used to
    /// identify the channel during the training process and must be unique within
    /// the training job.
    channel_name: []const u8,

    /// The Amazon Resource Name (ARN) of the base trained model to use for
    /// incremental training. This model serves as the starting point for the
    /// incremental training process.
    trained_model_arn: []const u8,

    /// The version identifier of the base trained model to use for incremental
    /// training. If not specified, the latest version of the trained model is used.
    version_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_name = "channelName",
        .trained_model_arn = "trainedModelArn",
        .version_identifier = "versionIdentifier",
    };
};
