const EnvironmentEnterSessionActionDefinition = @import("environment_enter_session_action_definition.zig").EnvironmentEnterSessionActionDefinition;
const EnvironmentExitSessionActionDefinition = @import("environment_exit_session_action_definition.zig").EnvironmentExitSessionActionDefinition;
const SyncInputJobAttachmentsSessionActionDefinition = @import("sync_input_job_attachments_session_action_definition.zig").SyncInputJobAttachmentsSessionActionDefinition;
const TaskRunSessionActionDefinition = @import("task_run_session_action_definition.zig").TaskRunSessionActionDefinition;

/// The definition of the session action.
pub const SessionActionDefinition = union(enum) {
    /// The environment to enter into.
    env_enter: ?EnvironmentEnterSessionActionDefinition,
    /// The environment to exit from.
    env_exit: ?EnvironmentExitSessionActionDefinition,
    /// The session action definition for syncing input job attachments.
    sync_input_job_attachments: ?SyncInputJobAttachmentsSessionActionDefinition,
    /// The task run in the session.
    task_run: ?TaskRunSessionActionDefinition,

    pub const json_field_names = .{
        .env_enter = "envEnter",
        .env_exit = "envExit",
        .sync_input_job_attachments = "syncInputJobAttachments",
        .task_run = "taskRun",
    };
};
