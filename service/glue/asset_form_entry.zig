/// A form on an asset, consisting of the form type identifier and its JSON
/// content.
pub const AssetFormEntry = struct {
    /// The JSON content of the form, conforming to the schema of the specified form
    /// type.
    content: ?[]const u8 = null,

    /// The identifier of the form type that defines this form's schema.
    form_type_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .content = "Content",
        .form_type_id = "FormTypeId",
    };
};
