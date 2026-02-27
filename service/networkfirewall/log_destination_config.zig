const aws = @import("aws");

const LogDestinationType = @import("log_destination_type.zig").LogDestinationType;
const LogType = @import("log_type.zig").LogType;

/// Defines where Network Firewall sends logs for the firewall for one log type.
/// This is used
/// in LoggingConfiguration. You can send each type of log to an Amazon S3
/// bucket, a CloudWatch log group, or a Firehose delivery stream.
///
/// Network Firewall generates logs for stateful rule groups. You can save
/// alert, flow, and TLS log
/// types.
pub const LogDestinationConfig = struct {
    /// The named location for the logs, provided in a key:value mapping that is
    /// specific to the
    /// chosen destination type.
    ///
    /// * For an Amazon S3 bucket, provide the name of the bucket, with key
    ///   `bucketName`,
    /// and optionally provide a prefix, with key `prefix`.
    ///
    /// The following example specifies an Amazon S3 bucket named
    /// `DOC-EXAMPLE-BUCKET` and the prefix `alerts`:
    ///
    /// `"LogDestination": { "bucketName": "DOC-EXAMPLE-BUCKET", "prefix": "alerts"
    /// }`
    ///
    /// * For a CloudWatch log group, provide the name of the CloudWatch log group,
    ///   with key
    /// `logGroup`. The following example specifies a log group named
    /// `alert-log-group`:
    ///
    /// `"LogDestination": { "logGroup": "alert-log-group" }`
    ///
    /// * For a Firehose delivery stream, provide the name of the delivery stream,
    ///   with key
    /// `deliveryStream`. The following example specifies a delivery stream
    /// named `alert-delivery-stream`:
    ///
    /// `"LogDestination": { "deliveryStream": "alert-delivery-stream"
    /// }`
    log_destination: []const aws.map.StringMapEntry,

    /// The type of storage destination to send these logs to. You can send logs to
    /// an Amazon S3 bucket,
    /// a CloudWatch log group, or a Firehose delivery stream.
    log_destination_type: LogDestinationType,

    /// The type of log to record. You can record the following types of logs from
    /// your Network Firewall stateful engine.
    ///
    /// * `ALERT` - Logs for traffic that matches your stateful rules and that have
    ///   an action that sends an alert. A stateful rule sends alerts for the rule
    ///   actions DROP, ALERT, and REJECT. For more information, see StatefulRule.
    ///
    /// * `FLOW` - Standard network traffic flow logs. The stateful rules engine
    ///   records flow logs for all network traffic that it receives. Each flow log
    ///   record captures the network flow for a specific standard stateless rule
    ///   group.
    ///
    /// * `TLS` - Logs for events that are related to TLS inspection. For more
    ///   information, see
    /// [Inspecting SSL/TLS traffic with TLS inspection
    /// configurations](https://docs.aws.amazon.com/network-firewall/latest/developerguide/tls-inspection-configurations.html)
    /// in the *Network Firewall Developer Guide*.
    log_type: LogType,

    pub const json_field_names = .{
        .log_destination = "LogDestination",
        .log_destination_type = "LogDestinationType",
        .log_type = "LogType",
    };
};
