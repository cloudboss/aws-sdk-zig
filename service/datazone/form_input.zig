/// The details of a metadata form.
pub const FormInput = struct {
    /// The content of the metadata form.
    content: ?[]const u8 = null,

    /// The name of the metadata form.
    form_name: []const u8,

    /// The ID of the metadata form type.
    type_identifier: ?[]const u8 = null,

    /// The revision of the metadata form type.
    type_revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .content = "content",
        .form_name = "formName",
        .type_identifier = "typeIdentifier",
        .type_revision = "typeRevision",
    };
};
