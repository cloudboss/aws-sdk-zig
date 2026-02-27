const SpecialValue = @import("special_value.zig").SpecialValue;

/// Determines the color that's applied to a particular data value in a column.
pub const CustomColor = struct {
    /// The color that is applied to the data value.
    color: []const u8,

    /// The data value that the color is applied to.
    field_value: ?[]const u8,

    /// The value of a special data value.
    special_value: ?SpecialValue,

    pub const json_field_names = .{
        .color = "Color",
        .field_value = "FieldValue",
        .special_value = "SpecialValue",
    };
};
