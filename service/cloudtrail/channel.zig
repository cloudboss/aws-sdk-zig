/// Contains information about a returned CloudTrail channel.
pub const Channel = struct {
    /// The Amazon Resource Name (ARN) of a channel.
    channel_arn: ?[]const u8 = null,

    /// The name of the CloudTrail channel. For service-linked channels, the name is
    /// `aws-service-channel/service-name/custom-suffix` where
    /// `service-name` represents the name of the Amazon Web Services service that
    /// created the channel and `custom-suffix` represents the suffix created by the
    /// Amazon Web Services service.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .name = "Name",
    };
};
