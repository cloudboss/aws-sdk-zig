const AdditionalResultAttributeValue = @import("additional_result_attribute_value.zig").AdditionalResultAttributeValue;
const AdditionalResultAttributeValueType = @import("additional_result_attribute_value_type.zig").AdditionalResultAttributeValueType;

/// An attribute returned from an index query.
pub const AdditionalResultAttribute = struct {
    /// The key that identifies the attribute.
    key: []const u8,

    /// An object that contains the attribute value.
    value: AdditionalResultAttributeValue,

    /// The data type of the `Value` property.
    value_type: AdditionalResultAttributeValueType,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
        .value_type = "ValueType",
    };
};
