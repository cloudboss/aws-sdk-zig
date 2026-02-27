const RerankingMetadataSelectionMode = @import("reranking_metadata_selection_mode.zig").RerankingMetadataSelectionMode;
const RerankingMetadataSelectiveModeConfiguration = @import("reranking_metadata_selective_mode_configuration.zig").RerankingMetadataSelectiveModeConfiguration;

/// Specifies how metadata fields should be handled during the reranking
/// process.
pub const MetadataConfigurationForReranking = struct {
    /// The mode for selecting metadata fields for reranking.
    selection_mode: RerankingMetadataSelectionMode,

    /// The configuration for selective metadata field inclusion or exclusion during
    /// reranking.
    selective_mode_configuration: ?RerankingMetadataSelectiveModeConfiguration,

    pub const json_field_names = .{
        .selection_mode = "selectionMode",
        .selective_mode_configuration = "selectiveModeConfiguration",
    };
};
