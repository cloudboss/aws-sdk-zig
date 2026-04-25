const Channel = @import("channel.zig").Channel;

/// Configuration settings for auto-accept for a specific channel.
pub const AutoAcceptConfig = struct {
    /// Indicates whether auto-accept is enabled for agent-first callbacks. This
    /// setting only applies to the VOICE channel.
    agent_first_callback_auto_accept: ?bool = null,

    /// Indicates whether auto-accept is enabled for this channel. When enabled,
    /// available agents are automatically connected to contacts from this channel.
    auto_accept: bool = false,

    /// The channel for this auto-accept configuration. Valid values: VOICE, CHAT,
    /// TASK, EMAIL.
    channel: Channel,

    pub const json_field_names = .{
        .agent_first_callback_auto_accept = "AgentFirstCallbackAutoAccept",
        .auto_accept = "AutoAccept",
        .channel = "Channel",
    };
};
