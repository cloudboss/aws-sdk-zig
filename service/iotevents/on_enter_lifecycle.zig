const Event = @import("event.zig").Event;

/// When entering this state, perform these `actions` if the `condition`
/// is TRUE.
pub const OnEnterLifecycle = struct {
    /// Specifies the actions that are performed when the state is entered and the
    /// `condition` is `TRUE`.
    events: ?[]const Event = null,

    pub const json_field_names = .{
        .events = "events",
    };
};
