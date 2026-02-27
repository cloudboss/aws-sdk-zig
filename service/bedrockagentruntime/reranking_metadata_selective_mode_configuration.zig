const FieldForReranking = @import("field_for_reranking.zig").FieldForReranking;

/// Contains configurations for the metadata fields to include or exclude when
/// considering reranking. If you include the `fieldsToExclude` field, the
/// reranker ignores all the metadata fields that you specify. If you include
/// the `fieldsToInclude` field, the reranker uses only the metadata fields that
/// you specify and ignores all others. You can include only one of these
/// fields.
pub const RerankingMetadataSelectiveModeConfiguration = union(enum) {
    /// An array of objects, each of which specifies a metadata field to exclude
    /// from consideration when reranking.
    fields_to_exclude: ?[]const FieldForReranking,
    /// An array of objects, each of which specifies a metadata field to include in
    /// consideration when reranking. The remaining metadata fields are ignored.
    fields_to_include: ?[]const FieldForReranking,

    pub const json_field_names = .{
        .fields_to_exclude = "fieldsToExclude",
        .fields_to_include = "fieldsToInclude",
    };
};
