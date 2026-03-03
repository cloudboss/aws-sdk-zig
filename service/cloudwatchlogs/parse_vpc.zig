/// Use this processor to parse Amazon VPC vended logs, extract fields, and and
/// convert them into a JSON format. This processor always processes the entire
/// log event
/// message.
///
/// This processor doesn't support custom log formats, such as NAT gateway logs.
/// For more
/// information about custom log formats in Amazon VPC, see [
/// parseVPC](https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs-records-examples.html#flow-log-example-tcp-flag) For more information about this processor including examples, see [ parseVPC](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-parseVPC).
///
/// If you use this processor, it must be the first processor in your
/// transformer.
pub const ParseVPC = struct {
    /// Omit this parameter and the whole log message will be processed by this
    /// processor. No
    /// other value than `@message` is allowed for `source`.
    source: ?[]const u8 = null,

    pub const json_field_names = .{
        .source = "source",
    };
};
