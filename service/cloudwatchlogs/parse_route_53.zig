/// Use this processor to parse Route 53 vended logs, extract fields, and and
/// convert them into a JSON format. This processor always processes the entire
/// log event message.
/// For more information about this processor including examples, see [
/// parseRoute53](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-parseRoute53).
///
/// If you use this processor, it must be the first processor in your
/// transformer.
pub const ParseRoute53 = struct {
    /// Omit this parameter and the whole log message will be processed by this
    /// processor. No
    /// other value than `@message` is allowed for `source`.
    source: ?[]const u8,

    pub const json_field_names = .{
        .source = "source",
    };
};
