/// Specifies a metadata field to include or exclude during the reranking
/// process.
pub const FieldForReranking = struct {
    /// The name of the metadata field to include or exclude during reranking.
    field_name: []const u8,

    pub const json_field_names = .{
        .field_name = "fieldName",
    };
};
