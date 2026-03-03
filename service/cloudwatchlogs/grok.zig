/// This processor uses pattern matching to parse and structure unstructured
/// data. This
/// processor can also extract fields from log messages.
///
/// For more information about this processor including examples, see
/// [grok](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation-Processors.html#CloudWatch-Logs-Transformation-Grok) in the *CloudWatch Logs User Guide*.
pub const Grok = struct {
    /// The grok pattern to match against the log event. For a list of supported
    /// grok patterns,
    /// see [Supported grok
    /// patterns](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation-Processors.html#Grok-Patterns).
    match: []const u8,

    /// The path to the field in the log event that you want to parse. If you omit
    /// this value, the
    /// whole log message is parsed.
    source: ?[]const u8 = null,

    pub const json_field_names = .{
        .match = "match",
        .source = "source",
    };
};
