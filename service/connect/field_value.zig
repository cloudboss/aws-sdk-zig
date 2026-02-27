const FieldValueUnion = @import("field_value_union.zig").FieldValueUnion;

/// Object for case field values.
pub const FieldValue = struct {
    /// Unique identifier of a field.
    id: []const u8,

    /// Union of potential field value types.
    value: FieldValueUnion,

    pub const json_field_names = .{
        .id = "Id",
        .value = "Value",
    };
};
