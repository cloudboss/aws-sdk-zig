const ChannelDefinition = @import("channel_definition.zig").ChannelDefinition;
const PostCallAnalyticsSettings = @import("post_call_analytics_settings.zig").PostCallAnalyticsSettings;

/// Allows you to set audio channel definitions and post-call analytics
/// settings.
pub const ConfigurationEvent = struct {
    /// Indicates which speaker is on which audio channel.
    channel_definitions: ?[]const ChannelDefinition,

    /// Provides additional optional settings for your Call Analytics post-call
    /// request, including
    /// encryption and output locations for your redacted transcript.
    ///
    /// `PostCallAnalyticsSettings` provides you with the same insights as a
    /// Call Analytics post-call transcription. Refer to [Post-call
    /// analytics](https://docs.aws.amazon.com/transcribe/latest/dg/tca-post-call.html) for more information
    /// on this feature.
    post_call_analytics_settings: ?PostCallAnalyticsSettings,

    pub const json_field_names = .{
        .channel_definitions = "ChannelDefinitions",
        .post_call_analytics_settings = "PostCallAnalyticsSettings",
    };
};
