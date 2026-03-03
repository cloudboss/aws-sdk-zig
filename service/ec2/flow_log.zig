const DestinationOptionsResponse = @import("destination_options_response.zig").DestinationOptionsResponse;
const LogDestinationType = @import("log_destination_type.zig").LogDestinationType;
const Tag = @import("tag.zig").Tag;
const TrafficType = @import("traffic_type.zig").TrafficType;

/// Describes a flow log.
pub const FlowLog = struct {
    /// The date and time the flow log was created.
    creation_time: ?i64 = null,

    /// The ARN of the IAM role that allows the service to publish flow logs across
    /// accounts.
    deliver_cross_account_role: ?[]const u8 = null,

    /// Information about the error that occurred. `Rate limited` indicates that
    /// CloudWatch Logs throttling has been applied for one or more network
    /// interfaces, or that you've
    /// reached the limit on the number of log groups that you can create. `Access
    /// error` indicates that the IAM role associated with the flow log does not
    /// have
    /// sufficient permissions to publish to CloudWatch Logs. `Unknown error`
    /// indicates an
    /// internal error.
    deliver_logs_error_message: ?[]const u8 = null,

    /// The ARN of the IAM role allows the service to publish logs to CloudWatch
    /// Logs.
    deliver_logs_permission_arn: ?[]const u8 = null,

    /// The status of the logs delivery (`SUCCESS` | `FAILED`).
    deliver_logs_status: ?[]const u8 = null,

    /// The destination options.
    destination_options: ?DestinationOptionsResponse = null,

    /// The ID of the flow log.
    flow_log_id: ?[]const u8 = null,

    /// The status of the flow log (`ACTIVE`).
    flow_log_status: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the destination for the flow log data.
    log_destination: ?[]const u8 = null,

    /// The type of destination for the flow log data.
    log_destination_type: ?LogDestinationType = null,

    /// The format of the flow log record.
    log_format: ?[]const u8 = null,

    /// The name of the flow log group.
    log_group_name: ?[]const u8 = null,

    /// The maximum interval of time, in seconds, during which a flow of packets is
    /// captured and aggregated into a flow log record.
    ///
    /// When a network interface is attached to a [Nitro-based
    /// instance](https://docs.aws.amazon.com/ec2/latest/instancetypes/ec2-nitro-instances.html), the aggregation interval is always 60 seconds (1 minute) or less,
    /// regardless of the specified value.
    ///
    /// Valid Values: `60` | `600`
    max_aggregation_interval: ?i32 = null,

    /// The ID of the resource being monitored.
    resource_id: ?[]const u8 = null,

    /// The tags for the flow log.
    tags: ?[]const Tag = null,

    /// The type of traffic captured for the flow log.
    traffic_type: ?TrafficType = null,
};
