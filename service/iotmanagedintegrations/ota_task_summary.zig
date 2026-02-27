const OtaStatus = @import("ota_status.zig").OtaStatus;

/// Structure representing one over-the-air (OTA) task.
pub const OtaTaskSummary = struct {
    /// The timestamp value of when the over-the-air (OTA) task was created at.
    created_at: ?i64,

    /// The timestamp value of when the over-the-air (OTA) task was last updated at.
    last_updated_at: ?i64,

    /// The status of the over-the-air (OTA) task summary.
    status: ?OtaStatus,

    /// The Amazon Resource Name (ARN) of the over-the-air (OTA) task.
    task_arn: ?[]const u8,

    /// The identifier for the over-the-air (OTA) task configuration.
    task_configuration_id: ?[]const u8,

    /// The id of the over-the-air (OTA) task.
    task_id: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .last_updated_at = "LastUpdatedAt",
        .status = "Status",
        .task_arn = "TaskArn",
        .task_configuration_id = "TaskConfigurationId",
        .task_id = "TaskId",
    };
};
