const BackupJobStatus = @import("backup_job_status.zig").BackupJobStatus;

/// This is a summary of jobs created
/// or running within the most recent 30 days.
///
/// The returned summary may contain the following:
/// Region, Account, State, RestourceType, MessageCategory,
/// StartTime, EndTime, and Count of included jobs.
pub const BackupJobSummary = struct {
    /// The account ID that owns the jobs within the summary.
    account_id: ?[]const u8 = null,

    /// The value as a number of jobs in a job summary.
    count: i32 = 0,

    /// The value of time in number format of a job end time.
    ///
    /// This value is the time in Unix format, Coordinated Universal Time (UTC), and
    /// accurate to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018
    /// 12:11:30.087 AM.
    end_time: ?i64 = null,

    /// This parameter is the job count for the specified
    /// message category.
    ///
    /// Example strings include `AccessDenied`,
    /// `Success`, and `InvalidParameters`. See
    /// [Monitoring](https://docs.aws.amazon.com/aws-backup/latest/devguide/monitoring.html)
    /// for a list of MessageCategory strings.
    ///
    /// The the value ANY returns count of all message categories.
    ///
    /// `AGGREGATE_ALL` aggregates job counts
    /// for all message categories and returns the sum.
    message_category: ?[]const u8 = null,

    /// The Amazon Web Services Regions within the job summary.
    region: ?[]const u8 = null,

    /// This value is the job count for the specified resource type.
    /// The request `GetSupportedResourceTypes` returns
    /// strings for supported resource types.
    resource_type: ?[]const u8 = null,

    /// The value of time in number format of a job start time.
    ///
    /// This value is the time in Unix format, Coordinated Universal Time (UTC), and
    /// accurate to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018
    /// 12:11:30.087 AM.
    start_time: ?i64 = null,

    /// This value is job count for jobs
    /// with the specified state.
    state: ?BackupJobStatus = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .count = "Count",
        .end_time = "EndTime",
        .message_category = "MessageCategory",
        .region = "Region",
        .resource_type = "ResourceType",
        .start_time = "StartTime",
        .state = "State",
    };
};
