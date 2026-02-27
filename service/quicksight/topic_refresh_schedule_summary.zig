const TopicRefreshSchedule = @import("topic_refresh_schedule.zig").TopicRefreshSchedule;

/// A summary of the refresh schedule details for a dataset.
pub const TopicRefreshScheduleSummary = struct {
    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: ?[]const u8,

    /// The ID of the dataset.
    dataset_id: ?[]const u8,

    /// The name of the dataset.
    dataset_name: ?[]const u8,

    /// The definition of a refresh schedule.
    refresh_schedule: ?TopicRefreshSchedule,

    pub const json_field_names = .{
        .dataset_arn = "DatasetArn",
        .dataset_id = "DatasetId",
        .dataset_name = "DatasetName",
        .refresh_schedule = "RefreshSchedule",
    };
};
