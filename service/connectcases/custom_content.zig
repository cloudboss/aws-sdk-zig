const FieldValue = @import("field_value.zig").FieldValue;

/// Represents the content of a `Custom` type related item.
pub const CustomContent = struct {
    /// List of field values for the `Custom` related item.
    fields: []const FieldValue,

    pub const json_field_names = .{
        .fields = "fields",
    };
};
