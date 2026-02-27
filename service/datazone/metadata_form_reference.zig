/// The reference of a metadata form.
pub const MetadataFormReference = struct {
    /// The type ID of the metadata form reference.
    type_identifier: []const u8,

    /// The type revision of the metadata form reference.
    type_revision: []const u8,

    pub const json_field_names = .{
        .type_identifier = "typeIdentifier",
        .type_revision = "typeRevision",
    };
};
