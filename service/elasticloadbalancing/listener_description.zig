const Listener = @import("listener.zig").Listener;

/// The policies enabled for a listener.
pub const ListenerDescription = struct {
    /// The listener.
    listener: ?Listener = null,

    /// The policies. If there are no policies enabled, the list is empty.
    policy_names: ?[]const []const u8 = null,
};
