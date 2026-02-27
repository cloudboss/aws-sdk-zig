const SnapshotJobResultErrorInfo = @import("snapshot_job_result_error_info.zig").SnapshotJobResultErrorInfo;
const SnapshotS3DestinationConfiguration = @import("snapshot_s3_destination_configuration.zig").SnapshotS3DestinationConfiguration;

/// The Amazon S3 result from the snapshot job. The result includes the
/// `DestinationConfiguration` and the Amazon S3 Uri. If an error occured during
/// the job, the result returns information on the error.
pub const SnapshotJobS3Result = struct {
    /// An array of error records that describe any failures that occur while the
    /// dashboard snapshot job runs.
    error_info: ?[]const SnapshotJobResultErrorInfo,

    /// A list of Amazon S3 bucket configurations that are provided when you make a
    /// `StartDashboardSnapshotJob` API call.
    s3_destination_configuration: ?SnapshotS3DestinationConfiguration,

    /// The Amazon S3 Uri.
    s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .error_info = "ErrorInfo",
        .s3_destination_configuration = "S3DestinationConfiguration",
        .s3_uri = "S3Uri",
    };
};
