const Event = @import("event.zig").Event;
const TransitionEvent = @import("transition_event.zig").TransitionEvent;

/// Specifies the actions performed when the `condition` evaluates to TRUE.
pub const OnInputLifecycle = struct {
    /// Specifies the actions performed when the `condition` evaluates to TRUE.
    events: ?[]const Event,

    /// Specifies the actions performed, and the next state entered, when a
    /// `condition`
    /// evaluates to TRUE.
    transition_events: ?[]const TransitionEvent,

    pub const json_field_names = .{
        .events = "events",
        .transition_events = "transitionEvents",
    };
};
