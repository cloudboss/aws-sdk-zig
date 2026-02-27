const RerankingMetadataSelectionMode = @import("reranking_metadata_selection_mode.zig").RerankingMetadataSelectionMode;
const RerankingMetadataSelectiveModeConfiguration = @import("reranking_metadata_selective_mode_configuration.zig").RerankingMetadataSelectiveModeConfiguration;

/// Configuration for how metadata should be used during the reranking process
/// in Knowledge Base vector searches. This determines which metadata fields are
/// included or excluded when reordering search results.
pub const MetadataConfigurationForReranking = struct {
    /// The mode for selecting which metadata fields to include in the reranking
    /// process. Valid values are ALL (use all available metadata fields) or
    /// SELECTIVE (use only specified fields).
    selection_mode: RerankingMetadataSelectionMode,

    /// Configuration for selective mode, which allows you to explicitly include or
    /// exclude specific metadata fields during reranking. This is only used when
    /// selectionMode is set to SELECTIVE.
    selective_mode_configuration: ?RerankingMetadataSelectiveModeConfiguration,

    pub const json_field_names = .{
        .selection_mode = "selectionMode",
        .selective_mode_configuration = "selectiveModeConfiguration",
    };
};
