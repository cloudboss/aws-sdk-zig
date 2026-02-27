const SemanticOverrideConsolidationConfigurationInput = @import("semantic_override_consolidation_configuration_input.zig").SemanticOverrideConsolidationConfigurationInput;
const SemanticOverrideExtractionConfigurationInput = @import("semantic_override_extraction_configuration_input.zig").SemanticOverrideExtractionConfigurationInput;

/// Input for semantic override configuration in a memory strategy.
pub const SemanticOverrideConfigurationInput = struct {
    /// The consolidation configuration for a semantic override.
    consolidation: ?SemanticOverrideConsolidationConfigurationInput,

    /// The extraction configuration for a semantic override.
    extraction: ?SemanticOverrideExtractionConfigurationInput,

    pub const json_field_names = .{
        .consolidation = "consolidation",
        .extraction = "extraction",
    };
};
