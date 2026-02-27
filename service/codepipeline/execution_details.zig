/// The details of the actions taken and results produced on an artifact as it
/// passes
/// through stages in the pipeline.
pub const ExecutionDetails = struct {
    /// The system-generated unique ID of this action used to identify this job
    /// worker in
    /// any external systems, such as CodeDeploy.
    external_execution_id: ?[]const u8,

    /// The percentage of work completed on the action, represented on a scale of 0
    /// to 100
    /// percent.
    percent_complete: ?i32,

    /// The summary of the current status of the actions.
    summary: ?[]const u8,

    pub const json_field_names = .{
        .external_execution_id = "externalExecutionId",
        .percent_complete = "percentComplete",
        .summary = "summary",
    };
};
