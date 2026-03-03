/// The details of a metadata form.
pub const FormOutput = struct {
    /// The content of the metadata form.
    content: ?[]const u8 = null,

    /// The name of the metadata form.
    form_name: []const u8,

    /// The name of the metadata form type.
    type_name: ?[]const u8 = null,

    /// The revision of the metadata form type.
    type_revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .content = "content",
        .form_name = "formName",
        .type_name = "typeName",
        .type_revision = "typeRevision",
    };
};
