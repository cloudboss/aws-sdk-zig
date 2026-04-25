/// Configures Elemental Inference features in a channel.
pub const DescribeInferenceSettings = struct {
    /// The ARN of the feed resource that is associated with this channel. The feed
    /// is a resource in the Elemental Inference service.
    feed_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .feed_arn = "FeedArn",
    };
};
