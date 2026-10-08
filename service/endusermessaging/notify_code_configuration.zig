const ChannelParameters = @import("channel_parameters.zig").ChannelParameters;
const CodeConfigurationParameters = @import("code_configuration_parameters.zig").CodeConfigurationParameters;

/// Contains the settings of a notify code configuration, which is a reusable
/// one-time passcode policy.
pub const NotifyCodeConfiguration = struct {
    /// The channel-specific parameters used to render and deliver the one-time
    /// passcode. A configuration can carry parameters for every channel at once,
    /// and the send route selects the matching channel at send time.
    channel_parameters: ?ChannelParameters = null,

    /// The passcode policy parameters, including the code type, length, validity
    /// period, and maximum number of attempts.
    code_configuration_parameters: ?CodeConfigurationParameters = null,

    /// The time when the resource was created, in Unix epoch time.
    created_at: i64,

    /// Specifies whether deletion protection is enabled. When enabled, the resource
    /// cannot be deleted until deletion protection is turned off.
    deletion_protection_enabled: bool,

    /// The Amazon Resource Name (ARN) of the notify code configuration.
    notify_code_configuration_arn: []const u8,

    /// The unique identifier of the notify code configuration.
    notify_code_configuration_id: []const u8,

    /// The name of the notify code configuration.
    notify_code_configuration_name: []const u8,

    /// The time when the resource was last updated, in Unix epoch time.
    updated_at: i64,

    pub const json_field_names = .{
        .channel_parameters = "channelParameters",
        .code_configuration_parameters = "codeConfigurationParameters",
        .created_at = "createdAt",
        .deletion_protection_enabled = "deletionProtectionEnabled",
        .notify_code_configuration_arn = "notifyCodeConfigurationArn",
        .notify_code_configuration_id = "notifyCodeConfigurationId",
        .notify_code_configuration_name = "notifyCodeConfigurationName",
        .updated_at = "updatedAt",
    };
};
