const EndPoint = @import("end_point.zig").EndPoint;

/// A real-time log configuration.
pub const RealtimeLogConfig = struct {
    /// The Amazon Resource Name (ARN) of this real-time log configuration.
    arn: []const u8,

    /// Contains information about the Amazon Kinesis data stream where you are
    /// sending real-time log data for this real-time log configuration.
    end_points: []const EndPoint,

    /// A list of fields that are included in each real-time log record. In an API
    /// response, the fields are provided in the same order in which they are sent
    /// to the Amazon Kinesis data stream.
    ///
    /// For more information about fields, see [Real-time log configuration
    /// fields](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/real-time-logs.html#understand-real-time-log-config-fields) in the *Amazon CloudFront Developer Guide*.
    fields: []const []const u8,

    /// The unique name of this real-time log configuration.
    name: []const u8,

    /// The sampling rate for this real-time log configuration. The sampling rate
    /// determines the percentage of viewer requests that are represented in the
    /// real-time log data. The sampling rate is an integer between 1 and 100,
    /// inclusive.
    sampling_rate: i64,
};
