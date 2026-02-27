const CancelStepsRequestStatus = @import("cancel_steps_request_status.zig").CancelStepsRequestStatus;

/// Specification of the status of a CancelSteps request. Available only in
/// Amazon EMR version 4.8.0 and later, excluding version 5.0.0.
pub const CancelStepsInfo = struct {
    /// The reason for the failure if the CancelSteps request fails.
    reason: ?[]const u8,

    /// The status of a CancelSteps Request. The value may be SUBMITTED or FAILED.
    status: ?CancelStepsRequestStatus,

    /// The encrypted StepId of a step.
    step_id: ?[]const u8,

    pub const json_field_names = .{
        .reason = "Reason",
        .status = "Status",
        .step_id = "StepId",
    };
};
