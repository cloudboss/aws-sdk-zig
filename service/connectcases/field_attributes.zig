const TextAttributes = @import("text_attributes.zig").TextAttributes;

/// Union of field attributes.
pub const FieldAttributes = union(enum) {
    /// Field attributes for Text field type.
    text: ?TextAttributes,

    pub const json_field_names = .{
        .text = "text",
    };
};
