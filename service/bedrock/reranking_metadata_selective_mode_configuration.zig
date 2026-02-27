const FieldForReranking = @import("field_for_reranking.zig").FieldForReranking;

/// Configuration for selectively including or excluding metadata fields during
/// the reranking process. This allows you to control which metadata attributes
/// are considered when reordering search results.
pub const RerankingMetadataSelectiveModeConfiguration = union(enum) {
    /// A list of metadata field names to explicitly exclude from the reranking
    /// process. All metadata fields except these will be considered when reordering
    /// search results. This parameter cannot be used together with fieldsToInclude.
    fields_to_exclude: ?[]const FieldForReranking,
    /// A list of metadata field names to explicitly include in the reranking
    /// process. Only these fields will be considered when reordering search
    /// results. This parameter cannot be used together with fieldsToExclude.
    fields_to_include: ?[]const FieldForReranking,

    pub const json_field_names = .{
        .fields_to_exclude = "fieldsToExclude",
        .fields_to_include = "fieldsToInclude",
    };
};
