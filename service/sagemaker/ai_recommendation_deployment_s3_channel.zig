/// An Amazon S3 data channel for a recommended deployment configuration,
/// containing model artifacts or optimized model outputs.
pub const AIRecommendationDeploymentS3Channel = struct {
    /// A custom name for this Amazon S3 data channel.
    channel_name: ?[]const u8 = null,

    /// The Amazon S3 URI of the data for this channel.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_name = "ChannelName",
        .uri = "Uri",
    };
};
