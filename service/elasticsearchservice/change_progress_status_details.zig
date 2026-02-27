const ChangeProgressStage = @import("change_progress_stage.zig").ChangeProgressStage;
const ConfigChangeStatus = @import("config_change_status.zig").ConfigChangeStatus;
const InitiatedBy = @import("initiated_by.zig").InitiatedBy;
const OverallChangeStatus = @import("overall_change_status.zig").OverallChangeStatus;

/// The progress details of a specific domain configuration change.
pub const ChangeProgressStatusDetails = struct {
    /// The unique change identifier associated with a specific domain configuration
    /// change.
    change_id: ?[]const u8,

    /// The specific stages that the domain is going through to perform the
    /// configuration change.
    change_progress_stages: ?[]const ChangeProgressStage,

    /// The list of properties involved in the domain configuration change that are
    /// completed.
    completed_properties: ?[]const []const u8,

    /// The current status of the configuration change.
    config_change_status: ?ConfigChangeStatus,

    /// The IAM principal who initiated the configuration change.
    initiated_by: ?InitiatedBy,

    /// The last time that the status of the configuration change was updated.
    last_updated_time: ?i64,

    /// The list of properties involved in the domain configuration change that are
    /// still in pending.
    pending_properties: ?[]const []const u8,

    /// The time at which the configuration change is made on the domain.
    start_time: ?i64,

    /// The overall status of the domain configuration change. This field can take
    /// the following values: `PENDING`, `PROCESSING`, `COMPLETED` and `FAILED`
    status: ?OverallChangeStatus,

    /// The total number of stages required for the configuration change.
    total_number_of_stages: i32 = 0,

    pub const json_field_names = .{
        .change_id = "ChangeId",
        .change_progress_stages = "ChangeProgressStages",
        .completed_properties = "CompletedProperties",
        .config_change_status = "ConfigChangeStatus",
        .initiated_by = "InitiatedBy",
        .last_updated_time = "LastUpdatedTime",
        .pending_properties = "PendingProperties",
        .start_time = "StartTime",
        .status = "Status",
        .total_number_of_stages = "TotalNumberOfStages",
    };
};
