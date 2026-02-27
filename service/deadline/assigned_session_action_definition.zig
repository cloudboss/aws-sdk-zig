const AssignedEnvironmentEnterSessionActionDefinition = @import("assigned_environment_enter_session_action_definition.zig").AssignedEnvironmentEnterSessionActionDefinition;
const AssignedEnvironmentExitSessionActionDefinition = @import("assigned_environment_exit_session_action_definition.zig").AssignedEnvironmentExitSessionActionDefinition;
const AssignedSyncInputJobAttachmentsSessionActionDefinition = @import("assigned_sync_input_job_attachments_session_action_definition.zig").AssignedSyncInputJobAttachmentsSessionActionDefinition;
const AssignedTaskRunSessionActionDefinition = @import("assigned_task_run_session_action_definition.zig").AssignedTaskRunSessionActionDefinition;

/// The definition of the assigned session action.
pub const AssignedSessionActionDefinition = union(enum) {
    /// The environment a session starts on.
    env_enter: ?AssignedEnvironmentEnterSessionActionDefinition,
    /// The environment a session exits from.
    env_exit: ?AssignedEnvironmentExitSessionActionDefinition,
    /// The job attachments to sync for the assigned session action.
    sync_input_job_attachments: ?AssignedSyncInputJobAttachmentsSessionActionDefinition,
    /// The task run.
    task_run: ?AssignedTaskRunSessionActionDefinition,

    pub const json_field_names = .{
        .env_enter = "envEnter",
        .env_exit = "envExit",
        .sync_input_job_attachments = "syncInputJobAttachments",
        .task_run = "taskRun",
    };
};
