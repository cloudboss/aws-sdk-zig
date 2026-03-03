const TypedAttributeValueRange = @import("typed_attribute_value_range.zig").TypedAttributeValueRange;

/// Identifies the range of attributes that are used by a specified filter.
pub const TypedLinkAttributeRange = struct {
    /// The unique name of the typed link attribute.
    attribute_name: ?[]const u8 = null,

    /// The range of attribute values that are being selected.
    range: TypedAttributeValueRange,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .range = "Range",
    };
};
