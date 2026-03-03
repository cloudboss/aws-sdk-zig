const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_pipeline => "CreatePipeline",
            .start_pipeline_execution => "StartPipelineExecution",
            .poll_for_source_changes => "PollForSourceChanges",
            .webhook => "Webhook",
            .cloud_watch_event => "CloudWatchEvent",
            .put_action_revision => "PutActionRevision",
            .webhook_v2 => "WebhookV2",
            .manual_rollback => "ManualRollback",
            .automated_rollback => "AutomatedRollback",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
