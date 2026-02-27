const DatasetContentStatus = @import("dataset_content_status.zig").DatasetContentStatus;

/// Summary information about dataset contents.
pub const DatasetContentSummary = struct {
    /// The time the dataset content status was updated to SUCCEEDED or FAILED.
    completion_time: ?i64,

    /// The actual time the creation of the dataset contents was started.
    creation_time: ?i64,

    /// The time the creation of the dataset contents was scheduled to start.
    schedule_time: ?i64,

    /// The status of the dataset contents.
    status: ?DatasetContentStatus,

    /// The version of the dataset contents.
    version: ?[]const u8,

    pub const json_field_names = .{
        .completion_time = "completionTime",
        .creation_time = "creationTime",
        .schedule_time = "scheduleTime",
        .status = "status",
        .version = "version",
    };
};
