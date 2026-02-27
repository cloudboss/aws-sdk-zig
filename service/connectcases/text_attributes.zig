/// Field attributes for Text field type.
pub const TextAttributes = struct {
    /// Attribute that defines rendering component and validation.
    is_multiline: bool,

    pub const json_field_names = .{
        .is_multiline = "isMultiline",
    };
};
