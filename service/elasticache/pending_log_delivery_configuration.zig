const DestinationDetails = @import("destination_details.zig").DestinationDetails;
const DestinationType = @import("destination_type.zig").DestinationType;
const LogFormat = @import("log_format.zig").LogFormat;
const LogType = @import("log_type.zig").LogType;

/// The log delivery configurations being modified
pub const PendingLogDeliveryConfiguration = struct {
    /// Configuration details of either a CloudWatch Logs destination or Kinesis
    /// Data Firehose
    /// destination.
    destination_details: ?DestinationDetails = null,

    /// Returns the destination type, either CloudWatch Logs or Kinesis Data
    /// Firehose.
    destination_type: ?DestinationType = null,

    /// Returns the log format, either JSON or TEXT
    log_format: ?LogFormat = null,

    /// Refers to [slow-log](https://redis.io/commands/slowlog) or
    /// engine-log..
    log_type: ?LogType = null,
};
