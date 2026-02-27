const RawValueType = @import("raw_value_type.zig").RawValueType;

/// The value type of null asset property data with BAD and UNCERTAIN qualities.
pub const PropertyValueNullValue = struct {
    /// The type of null asset property data.
    value_type: RawValueType,

    pub const json_field_names = .{
        .value_type = "valueType",
    };
};
