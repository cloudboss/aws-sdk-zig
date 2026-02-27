/// Access log settings, including the access log format and access log
/// destination ARN.
pub const AccessLogSettings = struct {
    /// The Amazon Resource Name (ARN) of the CloudWatch Logs log group or Kinesis
    /// Data Firehose delivery stream to receive access logs. If you specify a
    /// Kinesis Data Firehose delivery stream, the stream name must begin with
    /// `amazon-apigateway-`.
    destination_arn: ?[]const u8,

    /// A single line format of the access logs of data, as specified by selected
    /// $context variables. The format must include at least `$context.requestId`.
    format: ?[]const u8,

    pub const json_field_names = .{
        .destination_arn = "destinationArn",
        .format = "format",
    };
};
