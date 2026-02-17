const VerifiedAccessLogCloudWatchLogsDestinationOptions = @import("verified_access_log_cloud_watch_logs_destination_options.zig").VerifiedAccessLogCloudWatchLogsDestinationOptions;
const VerifiedAccessLogKinesisDataFirehoseDestinationOptions = @import("verified_access_log_kinesis_data_firehose_destination_options.zig").VerifiedAccessLogKinesisDataFirehoseDestinationOptions;
const VerifiedAccessLogS3DestinationOptions = @import("verified_access_log_s3_destination_options.zig").VerifiedAccessLogS3DestinationOptions;

/// Options for Verified Access logs.
pub const VerifiedAccessLogOptions = struct {
    /// Sends Verified Access logs to CloudWatch Logs.
    cloud_watch_logs: ?VerifiedAccessLogCloudWatchLogsDestinationOptions,

    /// Indicates whether to include trust data sent by trust providers in the logs.
    include_trust_context: ?bool,

    /// Sends Verified Access logs to Kinesis.
    kinesis_data_firehose: ?VerifiedAccessLogKinesisDataFirehoseDestinationOptions,

    /// The logging version.
    ///
    /// Valid values: `ocsf-0.1` | `ocsf-1.0.0-rc.2`
    log_version: ?[]const u8,

    /// Sends Verified Access logs to Amazon S3.
    s3: ?VerifiedAccessLogS3DestinationOptions,
};
