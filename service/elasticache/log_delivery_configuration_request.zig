const DestinationDetails = @import("destination_details.zig").DestinationDetails;
const DestinationType = @import("destination_type.zig").DestinationType;
const LogFormat = @import("log_format.zig").LogFormat;
const LogType = @import("log_type.zig").LogType;

/// Specifies the destination, format and type of the logs.
pub const LogDeliveryConfigurationRequest = struct {
    /// Configuration details of either a CloudWatch Logs destination or Kinesis
    /// Data Firehose
    /// destination.
    destination_details: ?DestinationDetails,

    /// Specify either `cloudwatch-logs` or `kinesis-firehose` as the
    /// destination type.
    destination_type: ?DestinationType,

    /// Specify if log delivery is enabled. Default `true`.
    enabled: ?bool,

    /// Specifies either JSON or TEXT
    log_format: ?LogFormat,

    /// Refers to [slow-log](https://redis.io/commands/slowlog) or
    /// engine-log..
    log_type: ?LogType,
};
