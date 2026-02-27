const BlueprintRunState = @import("blueprint_run_state.zig").BlueprintRunState;

/// The details of a blueprint run.
pub const BlueprintRun = struct {
    /// The name of the blueprint.
    blueprint_name: ?[]const u8,

    /// The date and time that the blueprint run completed.
    completed_on: ?i64,

    /// Indicates any errors that are seen while running the blueprint.
    error_message: ?[]const u8,

    /// The blueprint parameters as a string. You will have to provide a value for
    /// each key that is required from the parameter spec that is defined in the
    /// `Blueprint$ParameterSpec`.
    parameters: ?[]const u8,

    /// The role ARN. This role will be assumed by the Glue service and will be used
    /// to create the workflow and other entities of a workflow.
    role_arn: ?[]const u8,

    /// If there are any errors while creating the entities of a workflow, we try to
    /// roll back the created entities until that point and delete them. This
    /// attribute indicates the errors seen while trying to delete the entities that
    /// are created.
    rollback_error_message: ?[]const u8,

    /// The run ID for this blueprint run.
    run_id: ?[]const u8,

    /// The date and time that the blueprint run started.
    started_on: ?i64,

    /// The state of the blueprint run. Possible values are:
    ///
    /// * Running — The blueprint run is in progress.
    ///
    /// * Succeeded — The blueprint run completed successfully.
    ///
    /// * Failed — The blueprint run failed and rollback is complete.
    ///
    /// * Rolling Back — The blueprint run failed and rollback is in progress.
    state: ?BlueprintRunState,

    /// The name of a workflow that is created as a result of a successful blueprint
    /// run. If a blueprint run has an error, there will not be a workflow created.
    workflow_name: ?[]const u8,

    pub const json_field_names = .{
        .blueprint_name = "BlueprintName",
        .completed_on = "CompletedOn",
        .error_message = "ErrorMessage",
        .parameters = "Parameters",
        .role_arn = "RoleArn",
        .rollback_error_message = "RollbackErrorMessage",
        .run_id = "RunId",
        .started_on = "StartedOn",
        .state = "State",
        .workflow_name = "WorkflowName",
    };
};
