/// Contains details about a specific Map Run.
pub const MapRunListItem = struct {
    /// The `executionArn` of the execution from which the Map Run was started.
    execution_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the Map Run.
    map_run_arn: []const u8,

    /// The date on which the Map Run started.
    start_date: i64,

    /// The Amazon Resource Name (ARN) of the executed state machine.
    state_machine_arn: []const u8,

    /// The date on which the Map Run stopped.
    stop_date: ?i64 = null,

    pub const json_field_names = .{
        .execution_arn = "executionArn",
        .map_run_arn = "mapRunArn",
        .start_date = "startDate",
        .state_machine_arn = "stateMachineArn",
        .stop_date = "stopDate",
    };
};
