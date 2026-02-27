const RerankingMetadataSelectionMode = @import("reranking_metadata_selection_mode.zig").RerankingMetadataSelectionMode;
const RerankingMetadataSelectiveModeConfiguration = @import("reranking_metadata_selective_mode_configuration.zig").RerankingMetadataSelectiveModeConfiguration;

/// Contains configurations for the metadata to use in reranking.
pub const MetadataConfigurationForReranking = struct {
    /// Specifies whether to consider all metadata when reranking, or only the
    /// metadata that you select. If you specify `SELECTIVE`, include the
    /// `selectiveModeConfiguration` field.
    selection_mode: RerankingMetadataSelectionMode,

    /// Contains configurations for the metadata fields to include or exclude when
    /// considering reranking.
    selective_mode_configuration: ?RerankingMetadataSelectiveModeConfiguration,

    pub const json_field_names = .{
        .selection_mode = "selectionMode",
        .selective_mode_configuration = "selectiveModeConfiguration",
    };
};
