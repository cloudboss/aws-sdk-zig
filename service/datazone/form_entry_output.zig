/// The details of the form entry.
pub const FormEntryOutput = struct {
    /// Specifies whether a form entry is required.
    required: ?bool,

    /// The name of the type of the form entry.
    type_name: []const u8,

    /// The type revision of the form entry.
    type_revision: []const u8,

    pub const json_field_names = .{
        .required = "required",
        .type_name = "typeName",
        .type_revision = "typeRevision",
    };
};
