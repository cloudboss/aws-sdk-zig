const HookState = @import("hook_state.zig").HookState;

/// Configuration for lifecycle hooks invoked during MicroVM events such as run,
/// resume, suspend, and terminate.
pub const MicrovmHooks = struct {
    /// The path of the hook invoked when the MicroVM resumes from a suspended
    /// state.
    @"resume": HookState = .disabled,

    /// The maximum time in seconds for the resume hook to complete.
    resume_timeout_in_seconds: i32 = 1,

    /// The path of the hook invoked when the MicroVM starts running.
    run: HookState = .disabled,

    /// The maximum time in seconds for the run hook to complete.
    run_timeout_in_seconds: i32 = 1,

    /// The path of the hook invoked when the MicroVM is suspended.
    @"suspend": HookState = .disabled,

    /// The maximum time in seconds for the suspend hook to complete.
    suspend_timeout_in_seconds: i32 = 1,

    /// The path of the hook invoked when the MicroVM is terminated.
    terminate: HookState = .disabled,

    /// The maximum time in seconds for the terminate hook to complete.
    terminate_timeout_in_seconds: i32 = 1,

    pub const json_field_names = .{
        .@"resume" = "resume",
        .resume_timeout_in_seconds = "resumeTimeoutInSeconds",
        .run = "run",
        .run_timeout_in_seconds = "runTimeoutInSeconds",
        .@"suspend" = "suspend",
        .suspend_timeout_in_seconds = "suspendTimeoutInSeconds",
        .terminate = "terminate",
        .terminate_timeout_in_seconds = "terminateTimeoutInSeconds",
    };
};
