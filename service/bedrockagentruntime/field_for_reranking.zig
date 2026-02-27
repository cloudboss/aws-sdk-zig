/// Contains information for a metadata field to include in or exclude from
/// consideration when reranking.
pub const FieldForReranking = struct {
    /// The name of a metadata field to include in or exclude from consideration
    /// when reranking.
    field_name: []const u8,

    pub const json_field_names = .{
        .field_name = "fieldName",
    };
};
