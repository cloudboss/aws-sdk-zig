const InputSwitchConfiguration = @import("input_switch_configuration.zig").InputSwitchConfiguration;
const MultiviewConfiguration = @import("multiview_configuration.zig").MultiviewConfiguration;
const OutputHeaderConfiguration = @import("output_header_configuration.zig").OutputHeaderConfiguration;

pub const UpdateChannelRequest = struct {
    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The name that describes the channel. The name is the primary identifier for
    /// the channel, and must be unique for your account in the AWS Region and
    /// channel group.
    channel_name: []const u8,

    /// Any descriptive information that you want to add to the channel for future
    /// identification purposes.
    description: ?[]const u8 = null,

    /// The expected current Entity Tag (ETag) for the resource. If the specified
    /// ETag does not match the resource's current entity tag, the update request
    /// will be rejected.
    e_tag: ?[]const u8 = null,

    /// The configuration for input switching based on the media quality confidence
    /// score (MQCS) as provided from AWS Elemental MediaLive. This setting is valid
    /// only when `InputType` is `CMAF`.
    input_switch_configuration: ?InputSwitchConfiguration = null,

    /// The multiview configuration for the channel. This setting is required when
    /// the channel's `InputType` is `MULTIVIEW`, and can't be set for any other
    /// input type. Because `InputType` is immutable, you can change a multiview
    /// channel's sources and layouts. You can't add or remove the multiview
    /// configuration itself.
    multiview_configuration: ?MultiviewConfiguration = null,

    /// The settings for what common media server data (CMSD) headers AWS Elemental
    /// MediaPackage includes in responses to the CDN. This setting is valid only
    /// when `InputType` is `CMAF`.
    output_header_configuration: ?OutputHeaderConfiguration = null,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .description = "Description",
        .e_tag = "ETag",
        .input_switch_configuration = "InputSwitchConfiguration",
        .multiview_configuration = "MultiviewConfiguration",
        .output_header_configuration = "OutputHeaderConfiguration",
    };
};
