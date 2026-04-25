const Channel = @import("channel.zig").Channel;

/// Configuration settings for persistent connection for a specific channel.
pub const PersistentConnectionConfig = struct {
    /// Configuration settings for persistent connection. **Only `VOICE` is
    /// supported for this data type.**
    channel: Channel,

    /// Indicates whether persistent connection is enabled. When enabled, the
    /// agent's connection is maintained after a call ends, enabling subsequent
    /// calls to connect faster.
    persistent_connection: bool,

    pub const json_field_names = .{
        .channel = "Channel",
        .persistent_connection = "PersistentConnection",
    };
};
