/// This processor parses CloudFront vended logs, extract fields, and convert
/// them into
/// JSON format. Encoded field values are decoded. Values that are integers and
/// doubles are
/// treated as such. For more information about this processor including
/// examples, see [
/// parseCloudfront](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-parseCloudfront)
///
/// For more information about CloudFront log format, see [ Configure and use
/// standard
/// logs (access
/// logs)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html).
///
/// If you use this processor, it must be the first processor in your
/// transformer.
pub const ParseCloudfront = struct {
    /// Omit this parameter and the whole log message will be processed by this
    /// processor. No
    /// other value than `@message` is allowed for `source`.
    source: ?[]const u8 = null,

    pub const json_field_names = .{
        .source = "source",
    };
};
