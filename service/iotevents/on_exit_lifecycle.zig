const Event = @import("event.zig").Event;

/// When exiting this state, perform these `actions` if the specified
/// `condition` is `TRUE`.
pub const OnExitLifecycle = struct {
    /// Specifies the `actions` that are performed when the state is exited and the
    /// `condition` is `TRUE`.
    events: ?[]const Event,

    pub const json_field_names = .{
        .events = "events",
    };
};
