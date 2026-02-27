const EpisodicOverrideConsolidationConfigurationInput = @import("episodic_override_consolidation_configuration_input.zig").EpisodicOverrideConsolidationConfigurationInput;
const EpisodicOverrideExtractionConfigurationInput = @import("episodic_override_extraction_configuration_input.zig").EpisodicOverrideExtractionConfigurationInput;
const EpisodicOverrideReflectionConfigurationInput = @import("episodic_override_reflection_configuration_input.zig").EpisodicOverrideReflectionConfigurationInput;

/// Input for the configuration to override the episodic memory strategy.
pub const EpisodicOverrideConfigurationInput = struct {
    /// Contains configurations for overriding the consolidation step of the
    /// episodic memory strategy.
    consolidation: ?EpisodicOverrideConsolidationConfigurationInput,

    /// Contains configurations for overriding the extraction step of the episodic
    /// memory strategy.
    extraction: ?EpisodicOverrideExtractionConfigurationInput,

    /// Contains configurations for overriding the reflection step of the episodic
    /// memory strategy.
    reflection: ?EpisodicOverrideReflectionConfigurationInput,

    pub const json_field_names = .{
        .consolidation = "consolidation",
        .extraction = "extraction",
        .reflection = "reflection",
    };
};
