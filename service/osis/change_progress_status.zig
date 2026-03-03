const ChangeProgressStage = @import("change_progress_stage.zig").ChangeProgressStage;
const ChangeProgressStatuses = @import("change_progress_statuses.zig").ChangeProgressStatuses;

/// The progress details of a pipeline configuration change.
pub const ChangeProgressStatus = struct {
    /// Information about the stages that the pipeline is going through to perform
    /// the configuration change.
    change_progress_stages: ?[]const ChangeProgressStage = null,

    /// The time at which the configuration change is made on the pipeline.
    start_time: ?i64 = null,

    /// The overall status of the pipeline configuration change.
    status: ?ChangeProgressStatuses = null,

    /// The total number of stages required for the pipeline configuration change.
    total_number_of_stages: i32 = 0,

    pub const json_field_names = .{
        .change_progress_stages = "ChangeProgressStages",
        .start_time = "StartTime",
        .status = "Status",
        .total_number_of_stages = "TotalNumberOfStages",
    };
};
