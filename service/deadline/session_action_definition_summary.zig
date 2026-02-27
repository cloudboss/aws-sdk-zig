const EnvironmentEnterSessionActionDefinitionSummary = @import("environment_enter_session_action_definition_summary.zig").EnvironmentEnterSessionActionDefinitionSummary;
const EnvironmentExitSessionActionDefinitionSummary = @import("environment_exit_session_action_definition_summary.zig").EnvironmentExitSessionActionDefinitionSummary;
const SyncInputJobAttachmentsSessionActionDefinitionSummary = @import("sync_input_job_attachments_session_action_definition_summary.zig").SyncInputJobAttachmentsSessionActionDefinitionSummary;
const TaskRunSessionActionDefinitionSummary = @import("task_run_session_action_definition_summary.zig").TaskRunSessionActionDefinitionSummary;

/// The details of a session action definition.
pub const SessionActionDefinitionSummary = union(enum) {
    /// The environment to enter into.
    env_enter: ?EnvironmentEnterSessionActionDefinitionSummary,
    /// The environment to exit from.
    env_exit: ?EnvironmentExitSessionActionDefinitionSummary,
    /// The session action definition summary for syncing input job attachments.
    sync_input_job_attachments: ?SyncInputJobAttachmentsSessionActionDefinitionSummary,
    /// The task run.
    task_run: ?TaskRunSessionActionDefinitionSummary,

    pub const json_field_names = .{
        .env_enter = "envEnter",
        .env_exit = "envExit",
        .sync_input_job_attachments = "syncInputJobAttachments",
        .task_run = "taskRun",
    };
};
