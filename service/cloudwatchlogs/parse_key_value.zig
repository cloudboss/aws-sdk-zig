/// This processor parses a specified field in the original log event into
/// key-value pairs.
///
/// For more information about this processor including examples, see [
/// parseKeyValue](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-parseKeyValue) in the *CloudWatch Logs User Guide*.
pub const ParseKeyValue = struct {
    /// The destination field to put the extracted key-value pairs into
    destination: ?[]const u8,

    /// The field delimiter string that is used between key-value pairs in the
    /// original log
    /// events. If you omit this, the ampersand `&` character is used.
    field_delimiter: ?[]const u8,

    /// If you want to add a prefix to all transformed keys, specify it here.
    key_prefix: ?[]const u8,

    /// The delimiter string to use between the key and value in each pair in the
    /// transformed log
    /// event.
    ///
    /// If you omit this, the equal `=` character is used.
    key_value_delimiter: ?[]const u8,

    /// A value to insert into the value field in the result, when a key-value pair
    /// is not
    /// successfully split.
    non_match_value: ?[]const u8,

    /// Specifies whether to overwrite the value if the destination key already
    /// exists. If you
    /// omit this, the default is `false`.
    overwrite_if_exists: bool = false,

    /// Path to the field in the log event that will be parsed. Use dot notation to
    /// access child
    /// fields. For example, `store.book`
    source: ?[]const u8,

    pub const json_field_names = .{
        .destination = "destination",
        .field_delimiter = "fieldDelimiter",
        .key_prefix = "keyPrefix",
        .key_value_delimiter = "keyValueDelimiter",
        .non_match_value = "nonMatchValue",
        .overwrite_if_exists = "overwriteIfExists",
        .source = "source",
    };
};
