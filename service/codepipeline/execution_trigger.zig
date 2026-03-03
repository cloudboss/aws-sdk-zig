const TriggerType = @import("trigger_type.zig").TriggerType;

/// The interaction or event that started a pipeline execution.
pub const ExecutionTrigger = struct {
    /// Detail related to the event that started a pipeline execution, such as the
    /// webhook ARN
    /// of the webhook that triggered the pipeline execution or the user ARN for a
    /// user-initiated `start-pipeline-execution` CLI command.
    trigger_detail: ?[]const u8 = null,

    /// The type of change-detection method, command, or user interaction that
    /// started a
    /// pipeline execution.
    trigger_type: ?TriggerType = null,

    pub const json_field_names = .{
        .trigger_detail = "triggerDetail",
        .trigger_type = "triggerType",
    };
};
