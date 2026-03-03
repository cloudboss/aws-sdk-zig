const ChangeProgressStageStatuses = @import("change_progress_stage_statuses.zig").ChangeProgressStageStatuses;

/// Progress details for a specific stage of a pipeline configuration change.
pub const ChangeProgressStage = struct {
    /// A description of the stage.
    description: ?[]const u8 = null,

    /// The most recent updated timestamp of the stage.
    last_updated_at: ?i64 = null,

    /// The name of the stage.
    name: ?[]const u8 = null,

    /// The current status of the stage that the change is in.
    status: ?ChangeProgressStageStatuses = null,

    pub const json_field_names = .{
        .description = "Description",
        .last_updated_at = "LastUpdatedAt",
        .name = "Name",
        .status = "Status",
    };
};
