const MetadataValueType = @import("metadata_value_type.zig").MetadataValueType;

/// Contains the value of the metadata attribute. Choose a `type` and include
/// the field that corresponds to it.
pub const MetadataAttributeValue = struct {
    /// The value of the Boolean metadata attribute.
    boolean_value: ?bool,

    /// The value of the numeric metadata attribute.
    number_value: ?f64,

    /// An array of strings that define the value of the metadata attribute.
    string_list_value: ?[]const []const u8,

    /// The value of the string metadata attribute.
    string_value: ?[]const u8,

    /// The type of the metadata attribute.
    type: MetadataValueType,

    pub const json_field_names = .{
        .boolean_value = "booleanValue",
        .number_value = "numberValue",
        .string_list_value = "stringListValue",
        .string_value = "stringValue",
        .type = "type",
    };
};
