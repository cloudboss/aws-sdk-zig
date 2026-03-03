const VerifiedAccessLogCloudWatchLogsDestination = @import("verified_access_log_cloud_watch_logs_destination.zig").VerifiedAccessLogCloudWatchLogsDestination;
const VerifiedAccessLogKinesisDataFirehoseDestination = @import("verified_access_log_kinesis_data_firehose_destination.zig").VerifiedAccessLogKinesisDataFirehoseDestination;
const VerifiedAccessLogS3Destination = @import("verified_access_log_s3_destination.zig").VerifiedAccessLogS3Destination;

/// Describes the options for Verified Access logs.
pub const VerifiedAccessLogs = struct {
    /// CloudWatch Logs logging destination.
    cloud_watch_logs: ?VerifiedAccessLogCloudWatchLogsDestination = null,

    /// Indicates whether trust data is included in the logs.
    include_trust_context: ?bool = null,

    /// Kinesis logging destination.
    kinesis_data_firehose: ?VerifiedAccessLogKinesisDataFirehoseDestination = null,

    /// The log version.
    log_version: ?[]const u8 = null,

    /// Amazon S3 logging options.
    s3: ?VerifiedAccessLogS3Destination = null,
};
