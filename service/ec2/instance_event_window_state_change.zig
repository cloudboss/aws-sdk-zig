const InstanceEventWindowState = @import("instance_event_window_state.zig").InstanceEventWindowState;

/// The state of the event window.
pub const InstanceEventWindowStateChange = struct {
    /// The ID of the event window.
    instance_event_window_id: ?[]const u8,

    /// The current state of the event window.
    state: ?InstanceEventWindowState,
};
