const Type = @import("type.zig").Type;

/// This object defines one value type that will be converted using the [
/// typeConverter](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-typeConverter) processor.
pub const TypeConverterEntry = struct {
    /// The key with the value that is to be converted to a different type.
    key: []const u8,

    /// The type to convert the field value to. Valid values are `integer`,
    /// `double`, `string` and `boolean`.
    type: Type,

    pub const json_field_names = .{
        .key = "key",
        .type = "type",
    };
};
