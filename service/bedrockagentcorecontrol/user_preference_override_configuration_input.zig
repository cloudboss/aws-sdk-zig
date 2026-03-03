const UserPreferenceOverrideConsolidationConfigurationInput = @import("user_preference_override_consolidation_configuration_input.zig").UserPreferenceOverrideConsolidationConfigurationInput;
const UserPreferenceOverrideExtractionConfigurationInput = @import("user_preference_override_extraction_configuration_input.zig").UserPreferenceOverrideExtractionConfigurationInput;

/// Input for user preference override configuration in a memory strategy.
pub const UserPreferenceOverrideConfigurationInput = struct {
    /// The consolidation configuration for a user preference override.
    consolidation: ?UserPreferenceOverrideConsolidationConfigurationInput = null,

    /// The extraction configuration for a user preference override.
    extraction: ?UserPreferenceOverrideExtractionConfigurationInput = null,

    pub const json_field_names = .{
        .consolidation = "consolidation",
        .extraction = "extraction",
    };
};
