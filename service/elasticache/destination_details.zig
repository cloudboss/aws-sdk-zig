const CloudWatchLogsDestinationDetails = @import("cloud_watch_logs_destination_details.zig").CloudWatchLogsDestinationDetails;
const KinesisFirehoseDestinationDetails = @import("kinesis_firehose_destination_details.zig").KinesisFirehoseDestinationDetails;

/// Configuration details of either a CloudWatch Logs destination or Kinesis
/// Data Firehose
/// destination.
pub const DestinationDetails = struct {
    /// The configuration details of the CloudWatch Logs destination.
    cloud_watch_logs_details: ?CloudWatchLogsDestinationDetails,

    /// The configuration details of the Kinesis Data Firehose destination.
    kinesis_firehose_details: ?KinesisFirehoseDestinationDetails,
};
