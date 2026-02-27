pub const TriggerType = enum {
    create_pipeline,
    start_pipeline_execution,
    poll_for_source_changes,
    webhook,
    cloud_watch_event,
    put_action_revision,
    webhook_v2,
    manual_rollback,
    automated_rollback,

    pub const json_field_names = .{
        .create_pipeline = "CreatePipeline",
        .start_pipeline_execution = "StartPipelineExecution",
        .poll_for_source_changes = "PollForSourceChanges",
        .webhook = "Webhook",
        .cloud_watch_event = "CloudWatchEvent",
        .put_action_revision = "PutActionRevision",
        .webhook_v2 = "WebhookV2",
        .manual_rollback = "ManualRollback",
        .automated_rollback = "AutomatedRollback",
    };
};
