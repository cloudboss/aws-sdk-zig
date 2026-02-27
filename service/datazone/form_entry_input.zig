/// The details of the form entry.
pub const FormEntryInput = struct {
    /// Specifies whether a form entry is required.
    required: ?bool,

    /// The type ID of the form entry.
    type_identifier: []const u8,

    /// The type revision of the form entry.
    type_revision: []const u8,

    pub const json_field_names = .{
        .required = "required",
        .type_identifier = "typeIdentifier",
        .type_revision = "typeRevision",
    };
};
