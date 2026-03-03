const DestinationDetails = @import("destination_details.zig").DestinationDetails;
const DestinationType = @import("destination_type.zig").DestinationType;
const LogFormat = @import("log_format.zig").LogFormat;
const LogType = @import("log_type.zig").LogType;
const LogDeliveryConfigurationStatus = @import("log_delivery_configuration_status.zig").LogDeliveryConfigurationStatus;

/// Returns the destination, format and type of the logs.
pub const LogDeliveryConfiguration = struct {
    /// Configuration details of either a CloudWatch Logs destination or Kinesis
    /// Data Firehose
    /// destination.
    destination_details: ?DestinationDetails = null,

    /// Returns the destination type, either `cloudwatch-logs` or
    /// `kinesis-firehose`.
    destination_type: ?DestinationType = null,

    /// Returns the log format, either JSON or TEXT.
    log_format: ?LogFormat = null,

    /// Refers to [slow-log](https://redis.io/commands/slowlog) or
    /// engine-log.
    log_type: ?LogType = null,

    /// Returns an error message for the log delivery configuration.
    message: ?[]const u8 = null,

    /// Returns the log delivery configuration status. Values are one of `enabling`
    /// | `disabling` | `modifying` | `active` |
    /// `error`
    status: ?LogDeliveryConfigurationStatus = null,
};
