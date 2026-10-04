const HookState = @import("hook_state.zig").HookState;

/// Configuration for hooks invoked during MicroVM image build events such as
/// ready and validate.
pub const MicrovmImageHooks = struct {
    /// The path of the hook invoked when the MicroVM image build is ready.
    ready: HookState = .disabled,

    /// The maximum time in seconds for the ready hook to complete.
    ready_timeout_in_seconds: i32 = 30,

    /// The path of the hook invoked to validate the MicroVM image build.
    validate: HookState = .disabled,

    /// The maximum time in seconds for the validate hook to complete.
    validate_timeout_in_seconds: i32 = 30,

    pub const json_field_names = .{
        .ready = "ready",
        .ready_timeout_in_seconds = "readyTimeoutInSeconds",
        .validate = "validate",
        .validate_timeout_in_seconds = "validateTimeoutInSeconds",
    };
};
