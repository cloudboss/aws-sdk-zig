const CanaryState = @import("canary_state.zig").CanaryState;
const CanaryStateReasonCode = @import("canary_state_reason_code.zig").CanaryStateReasonCode;

/// A structure that contains the current state of the canary.
pub const CanaryStatus = struct {
    /// The current state of the canary.
    state: ?CanaryState = null,

    /// If the canary creation or update failed, this field provides details on the
    /// failure.
    state_reason: ?[]const u8 = null,

    /// If the canary creation or update failed, this field displays the reason
    /// code.
    state_reason_code: ?CanaryStateReasonCode = null,

    pub const json_field_names = .{
        .state = "State",
        .state_reason = "StateReason",
        .state_reason_code = "StateReasonCode",
    };
};
