/// This object defines one log field key that will be replaced using the [
/// substituteString](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-substituteString) processor.
pub const SubstituteStringEntry = struct {
    /// The regular expression string to be replaced. Special regex characters such
    /// as [ and ]
    /// must be escaped using \\ when using double quotes and with \ when using
    /// single quotes. For
    /// more information, see [ Class
    /// Pattern](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/regex/Pattern.html) on the Oracle web site.
    from: []const u8,

    /// The key to modify
    source: []const u8,

    /// The string to be substituted for each match of `from`
    to: []const u8,

    pub const json_field_names = .{
        .from = "from",
        .source = "source",
        .to = "to",
    };
};
