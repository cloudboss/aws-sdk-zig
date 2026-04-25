/// Object specifying a configuration for integration with an AWS Elemental
/// MediaTailor (EMT).
pub const MediaTailorPlaybackConfiguration = struct {
    /// ARN of the customer-created EMT PlaybackConfiguration resource in the same
    /// region and account.
    playback_configuration_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .playback_configuration_arn = "playbackConfigurationArn",
    };
};
