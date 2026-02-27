const CalculationExecutionState = @import("calculation_execution_state.zig").CalculationExecutionState;

/// Contains information about the status of a notebook calculation.
pub const CalculationStatus = struct {
    /// The date and time the calculation completed processing.
    completion_date_time: ?i64,

    /// The state of the calculation execution. A description of each state follows.
    ///
    /// `CREATING` - The calculation is in the process of being created.
    ///
    /// `CREATED` - The calculation has been created and is ready to run.
    ///
    /// `QUEUED` - The calculation has been queued for processing.
    ///
    /// `RUNNING` - The calculation is running.
    ///
    /// `CANCELING` - A request to cancel the calculation has been received and the
    /// system is working to stop it.
    ///
    /// `CANCELED` - The calculation is no longer running as the result of a cancel
    /// request.
    ///
    /// `COMPLETED` - The calculation has completed without error.
    ///
    /// `FAILED` - The calculation failed and is no longer running.
    state: ?CalculationExecutionState,

    /// The reason for the calculation state change (for example, the calculation
    /// was canceled
    /// because the session was terminated).
    state_change_reason: ?[]const u8,

    /// The date and time the calculation was submitted for processing.
    submission_date_time: ?i64,

    pub const json_field_names = .{
        .completion_date_time = "CompletionDateTime",
        .state = "State",
        .state_change_reason = "StateChangeReason",
        .submission_date_time = "SubmissionDateTime",
    };
};
