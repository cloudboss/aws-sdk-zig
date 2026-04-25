/// The `CSV` processor parses comma-separated values (CSV) from the log events
/// into columns.
///
/// For more information about this processor including examples, see [
/// csv](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-csv) in the *CloudWatch Logs User Guide*.
pub const CSV = struct {
    /// An array of names to use for the columns in the transformed log event.
    ///
    /// If you omit this, default column names (`[column_1, column_2 ...]`) are
    /// used.
    columns: ?[]const []const u8 = null,

    /// The character used to separate each column in the original comma-separated
    /// value log
    /// event. If you omit this, the processor looks for the comma `,` character as
    /// the
    /// delimiter.
    delimiter: ?[]const u8 = null,

    /// The path to the parent field to put transformed key value pairs under.
    /// If you omit this value, the key value pairs will be placed under the root
    /// node.
    destination: ?[]const u8 = null,

    /// The character used used as a text qualifier for a single column of data. If
    /// you omit this,
    /// the double quotation mark `"` character is used.
    quote_character: ?[]const u8 = null,

    /// The path to the field in the log event that has the comma separated values
    /// to be parsed.
    /// If you omit this value, the whole log message is processed.
    source: ?[]const u8 = null,

    pub const json_field_names = .{
        .columns = "columns",
        .delimiter = "delimiter",
        .destination = "destination",
        .quote_character = "quoteCharacter",
        .source = "source",
    };
};
