const TypeConverterEntry = @import("type_converter_entry.zig").TypeConverterEntry;

/// Use this processor to convert a value type associated with the specified key
/// to the
/// specified type. It's a casting processor that changes the types of the
/// specified fields.
/// Values can be converted into one of the following datatypes: `integer`,
/// `double`, `string` and `boolean`.
///
/// For more information about this processor including examples, see [
/// trimString](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-trimString) in the *CloudWatch Logs User Guide*.
pub const TypeConverter = struct {
    /// An array of `TypeConverterEntry` objects, where each object contains the
    /// information about one field to change the type of.
    entries: []const TypeConverterEntry,

    pub const json_field_names = .{
        .entries = "entries",
    };
};
