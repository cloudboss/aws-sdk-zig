/// The summary of the metadata form.
pub const MetadataFormSummary = struct {
    /// The form name of the metadata form.
    form_name: ?[]const u8,

    /// The type name of the metadata form.
    type_name: []const u8,

    /// The type revision of the metadata form.
    type_revision: []const u8,

    pub const json_field_names = .{
        .form_name = "formName",
        .type_name = "typeName",
        .type_revision = "typeRevision",
    };
};
