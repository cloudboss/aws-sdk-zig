const FieldValue = @import("field_value.zig").FieldValue;

/// Represents the updated content of a `Custom` related item.
pub const CustomUpdateContent = struct {
    /// List of updated field values for the `Custom` related item. All existing and
    /// new fields, and their associated values should be included. Fields not
    /// included as part of this request will be removed.
    fields: []const FieldValue,

    pub const json_field_names = .{
        .fields = "fields",
    };
};
