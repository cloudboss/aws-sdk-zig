const OnEnterLifecycle = @import("on_enter_lifecycle.zig").OnEnterLifecycle;
const OnExitLifecycle = @import("on_exit_lifecycle.zig").OnExitLifecycle;
const OnInputLifecycle = @import("on_input_lifecycle.zig").OnInputLifecycle;

/// Information that defines a state of a detector.
pub const State = struct {
    /// When entering this state, perform these `actions` if the `condition`
    /// is TRUE.
    on_enter: ?OnEnterLifecycle = null,

    /// When exiting this state, perform these `actions` if the specified
    /// `condition` is `TRUE`.
    on_exit: ?OnExitLifecycle = null,

    /// When an input is received and the `condition` is TRUE, perform the specified
    /// `actions`.
    on_input: ?OnInputLifecycle = null,

    /// The name of the state.
    state_name: []const u8,

    pub const json_field_names = .{
        .on_enter = "onEnter",
        .on_exit = "onExit",
        .on_input = "onInput",
        .state_name = "stateName",
    };
};
