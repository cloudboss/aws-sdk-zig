const S3DataDistributionType = @import("s3_data_distribution_type.zig").S3DataDistributionType;

/// Information about the model training data channel. A training data channel
/// is a named data source that the training algorithms can consume.
pub const ModelTrainingDataChannel = struct {
    /// The name of the training data channel.
    channel_name: []const u8,

    /// The Amazon Resource Name (ARN) of the ML input channel for this model
    /// training data channel.
    ml_input_channel_arn: []const u8,

    /// Specifies how the training data stored in Amazon S3 should be distributed to
    /// training instances. This parameter controls the data distribution strategy
    /// for the training job:
    ///
    /// * `FullyReplicated` - The entire dataset is replicated on each training
    ///   instance. This is suitable for smaller datasets and algorithms that
    ///   require access to the complete dataset.
    /// * `ShardedByS3Key` - The dataset is distributed across training instances
    ///   based on Amazon S3 key names. This is suitable for larger datasets and
    ///   distributed training scenarios where each instance processes a subset of
    ///   the data.
    s_3_data_distribution_type: S3DataDistributionType = "FullyReplicated",

    pub const json_field_names = .{
        .channel_name = "channelName",
        .ml_input_channel_arn = "mlInputChannelArn",
        .s_3_data_distribution_type = "s3DataDistributionType",
    };
};
