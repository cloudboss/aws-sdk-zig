/// This object defines one key that will be added with the [
/// addKeys](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-addKey) processor.
pub const AddKeyEntry = struct {
    /// The key of the new entry to be added to the log event
    key: []const u8,

    /// Specifies whether to overwrite the value if the key already exists in the
    /// log event. If
    /// you omit this, the default is `false`.
    overwrite_if_exists: bool = false,

    /// The value of the new entry to be added to the log event
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .overwrite_if_exists = "overwriteIfExists",
        .value = "value",
    };
};
