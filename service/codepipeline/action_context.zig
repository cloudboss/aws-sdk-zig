/// Represents the context of an action in the stage of a pipeline to a job
/// worker.
pub const ActionContext = struct {
    /// The system-generated unique ID that corresponds to an action's execution.
    action_execution_id: ?[]const u8,

    /// The name of the action in the context of a job.
    name: ?[]const u8,

    pub const json_field_names = .{
        .action_execution_id = "actionExecutionId",
        .name = "name",
    };
};
