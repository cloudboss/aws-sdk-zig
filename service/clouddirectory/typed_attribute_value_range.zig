const RangeMode = @import("range_mode.zig").RangeMode;
const TypedAttributeValue = @import("typed_attribute_value.zig").TypedAttributeValue;

/// A range of attribute values. For more information, see [Range
/// Filters](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/directory_objects_range_filters.html).
pub const TypedAttributeValueRange = struct {
    /// The inclusive or exclusive range end.
    end_mode: RangeMode,

    /// The attribute value to terminate the range at.
    end_value: ?TypedAttributeValue = null,

    /// The inclusive or exclusive range start.
    start_mode: RangeMode,

    /// The value to start the range at.
    start_value: ?TypedAttributeValue = null,

    pub const json_field_names = .{
        .end_mode = "EndMode",
        .end_value = "EndValue",
        .start_mode = "StartMode",
        .start_value = "StartValue",
    };
};
