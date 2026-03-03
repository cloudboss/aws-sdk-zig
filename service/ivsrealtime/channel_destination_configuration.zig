/// Object specifying a channel as a destination.
pub const ChannelDestinationConfiguration = struct {
    /// ARN of the channel to use for broadcasting. The channel and stage resources
    /// must be in
    /// the same AWS account and region. The channel must be offline (not
    /// broadcasting).
    channel_arn: []const u8,

    /// ARN of the EncoderConfiguration resource. The encoder configuration
    /// and stage resources must be in the same AWS account and region.
    encoder_configuration_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "channelArn",
        .encoder_configuration_arn = "encoderConfigurationArn",
    };
};
