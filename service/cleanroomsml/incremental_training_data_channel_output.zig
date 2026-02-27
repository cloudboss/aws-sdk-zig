/// Contains information about an incremental training data channel that was
/// used to create a trained model. This structure provides details about the
/// base model and channel configuration used during incremental training.
pub const IncrementalTrainingDataChannelOutput = struct {
    /// The name of the incremental training data channel that was used.
    channel_name: []const u8,

    /// The name of the base trained model that was used for incremental training.
    model_name: []const u8,

    /// The version identifier of the trained model that was used for incremental
    /// training.
    version_identifier: ?[]const u8,

    pub const json_field_names = .{
        .channel_name = "channelName",
        .model_name = "modelName",
        .version_identifier = "versionIdentifier",
    };
};
