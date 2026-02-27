pub const ActionStatus = enum {
    standby,
    pending,
    execution_in_progress,
    execution_success,
    execution_failure,
    reverse_in_progress,
    reverse_success,
    reverse_failure,
    reset_in_progress,
    reset_failure,

    pub const json_field_names = .{
        .standby = "Standby",
        .pending = "Pending",
        .execution_in_progress = "Execution_In_Progress",
        .execution_success = "Execution_Success",
        .execution_failure = "Execution_Failure",
        .reverse_in_progress = "Reverse_In_Progress",
        .reverse_success = "Reverse_Success",
        .reverse_failure = "Reverse_Failure",
        .reset_in_progress = "Reset_In_Progress",
        .reset_failure = "Reset_Failure",
    };
};
