const AfterContactWorkConfig = @import("after_contact_work_config.zig").AfterContactWorkConfig;
const Channel = @import("channel.zig").Channel;

/// Configuration settings for after contact work (ACW) timeout for a specific
/// channel.
pub const AfterContactWorkConfigPerChannel = struct {
    /// The ACW timeout settings for this channel.
    after_contact_work_config: AfterContactWorkConfig,

    /// The ACW timeout settings for agent-first callbacks. This setting only
    /// applies to the VOICE channel.
    agent_first_callback_after_contact_work_config: ?AfterContactWorkConfig = null,

    /// The channel for this ACW timeout configuration. Valid values: VOICE, CHAT,
    /// TASK, EMAIL.
    channel: Channel,

    pub const json_field_names = .{
        .after_contact_work_config = "AfterContactWorkConfig",
        .agent_first_callback_after_contact_work_config = "AgentFirstCallbackAfterContactWorkConfig",
        .channel = "Channel",
    };
};
