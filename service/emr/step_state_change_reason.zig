const StepStateChangeReasonCode = @import("step_state_change_reason_code.zig").StepStateChangeReasonCode;

/// The details of the step state change reason.
pub const StepStateChangeReason = struct {
    /// The programmable code for the state change reason. Note: Currently, the
    /// service provides
    /// no code for the state change.
    code: ?StepStateChangeReasonCode,

    /// The descriptive message for the state change reason.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
