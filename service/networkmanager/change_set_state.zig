pub const ChangeSetState = enum {
    pending_generation,
    failed_generation,
    ready_to_execute,
    executing,
    execution_succeeded,
    out_of_date,

    pub const json_field_names = .{
        .pending_generation = "PENDING_GENERATION",
        .failed_generation = "FAILED_GENERATION",
        .ready_to_execute = "READY_TO_EXECUTE",
        .executing = "EXECUTING",
        .execution_succeeded = "EXECUTION_SUCCEEDED",
        .out_of_date = "OUT_OF_DATE",
    };
};
