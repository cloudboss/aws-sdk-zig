const JobFlowExecutionState = @import("job_flow_execution_state.zig").JobFlowExecutionState;

/// Describes the status of the cluster (job flow).
pub const JobFlowExecutionStatusDetail = struct {
    /// The creation date and time of the job flow.
    creation_date_time: i64,

    /// The completion date and time of the job flow.
    end_date_time: ?i64 = null,

    /// Description of the job flow last changed state.
    last_state_change_reason: ?[]const u8 = null,

    /// The date and time when the job flow was ready to start running bootstrap
    /// actions.
    ready_date_time: ?i64 = null,

    /// The start date and time of the job flow.
    start_date_time: ?i64 = null,

    /// The state of the job flow.
    state: JobFlowExecutionState,

    pub const json_field_names = .{
        .creation_date_time = "CreationDateTime",
        .end_date_time = "EndDateTime",
        .last_state_change_reason = "LastStateChangeReason",
        .ready_date_time = "ReadyDateTime",
        .start_date_time = "StartDateTime",
        .state = "State",
    };
};
