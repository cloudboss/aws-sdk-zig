const OtaTaskExecutionSummary = @import("ota_task_execution_summary.zig").OtaTaskExecutionSummary;

/// Structure representing one execution summary.
pub const OtaTaskExecutionSummaries = struct {
    /// The id of a managed thing.
    managed_thing_id: ?[]const u8 = null,

    /// Structure representing one over-the-air (OTA) task execution summary
    task_execution_summary: ?OtaTaskExecutionSummary = null,

    pub const json_field_names = .{
        .managed_thing_id = "ManagedThingId",
        .task_execution_summary = "TaskExecutionSummary",
    };
};
