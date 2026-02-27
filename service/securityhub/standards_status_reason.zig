const StatusReasonCode = @import("status_reason_code.zig").StatusReasonCode;

/// The reason for the current status of your subscription to the standard.
pub const StandardsStatusReason = struct {
    /// The reason code that represents the reason for the current status of a
    /// standard subscription.
    status_reason_code: StatusReasonCode,

    pub const json_field_names = .{
        .status_reason_code = "StatusReasonCode",
    };
};
