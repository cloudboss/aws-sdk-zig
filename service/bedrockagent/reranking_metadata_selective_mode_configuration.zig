const FieldForReranking = @import("field_for_reranking.zig").FieldForReranking;

/// Configures the metadata fields to include or exclude during the reranking
/// process when using selective mode.
pub const RerankingMetadataSelectiveModeConfiguration = union(enum) {
    /// Specifies the metadata fields to exclude from the reranking process.
    fields_to_exclude: ?[]const FieldForReranking,
    /// Specifies the metadata fields to include in the reranking process.
    fields_to_include: ?[]const FieldForReranking,

    pub const json_field_names = .{
        .fields_to_exclude = "fieldsToExclude",
        .fields_to_include = "fieldsToInclude",
    };
};
