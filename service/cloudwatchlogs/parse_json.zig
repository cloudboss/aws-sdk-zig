/// This processor parses log events that are in JSON format. It can extract
/// JSON key-value
/// pairs and place them under a destination that you specify.
///
/// Additionally, because you must have at least one parse-type processor in a
/// transformer,
/// you can use `ParseJSON` as that processor for JSON-format logs, so that you
/// can
/// also apply other processors, such as mutate processors, to these logs.
///
/// For more information about this processor including examples, see [
/// parseJSON](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-parseJSON) in the *CloudWatch Logs User Guide*.
pub const ParseJSON = struct {
    /// The location to put the parsed key value pair into. If you omit this
    /// parameter, it is
    /// placed under the root node.
    destination: ?[]const u8 = null,

    /// Path to the field in the log event that will be parsed. Use dot notation to
    /// access child
    /// fields. For example, `store.book`
    source: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination = "destination",
        .source = "source",
    };
};
