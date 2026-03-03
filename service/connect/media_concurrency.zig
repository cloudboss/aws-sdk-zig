const Channel = @import("channel.zig").Channel;
const CrossChannelBehavior = @import("cross_channel_behavior.zig").CrossChannelBehavior;

/// Contains information about which channels are supported, and how many
/// contacts an agent can have on a channel
/// simultaneously.
pub const MediaConcurrency = struct {
    /// The channels that agents can handle in the Contact Control Panel (CCP).
    channel: Channel,

    /// The number of contacts an agent can have on a channel simultaneously.
    ///
    /// Valid Range for `VOICE`: Minimum value of 1. Maximum value of 1.
    ///
    /// Valid Range for `CHAT`: Minimum value of 1. Maximum value of 10.
    ///
    /// Valid Range for `TASK`: Minimum value of 1. Maximum value of 10.
    concurrency: i32,

    /// Defines the cross-channel routing behavior for each channel that is enabled
    /// for this Routing Profile. For
    /// example, this allows you to offer an agent a different contact from another
    /// channel when they are currently working
    /// with a contact from a Voice channel.
    cross_channel_behavior: ?CrossChannelBehavior = null,

    pub const json_field_names = .{
        .channel = "Channel",
        .concurrency = "Concurrency",
        .cross_channel_behavior = "CrossChannelBehavior",
    };
};
