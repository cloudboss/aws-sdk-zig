const MetricStreamOutputFormat = @import("metric_stream_output_format.zig").MetricStreamOutputFormat;

/// This structure contains the configuration information about one metric
/// stream.
pub const MetricStreamEntry = struct {
    /// The ARN of the metric stream.
    arn: ?[]const u8 = null,

    /// The date that the metric stream was originally created.
    creation_date: ?i64 = null,

    /// The ARN of the Kinesis Firehose devlivery stream that is used for this
    /// metric
    /// stream.
    firehose_arn: ?[]const u8 = null,

    /// The date that the configuration of this metric stream was most recently
    /// updated.
    last_update_date: ?i64 = null,

    /// The name of the metric stream.
    name: ?[]const u8 = null,

    /// The output format of this metric stream. Valid values are `json`,
    /// `opentelemetry1.0`, and `opentelemetry0.7`.
    output_format: ?MetricStreamOutputFormat = null,

    /// The current state of this stream. Valid values are `running` and
    /// `stopped`.
    state: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .firehose_arn = "FirehoseArn",
        .last_update_date = "LastUpdateDate",
        .name = "Name",
        .output_format = "OutputFormat",
        .state = "State",
    };
};
