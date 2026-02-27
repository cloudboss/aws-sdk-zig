const EpisodicOverrideConsolidationConfigurationInput = @import("episodic_override_consolidation_configuration_input.zig").EpisodicOverrideConsolidationConfigurationInput;
const SemanticOverrideConsolidationConfigurationInput = @import("semantic_override_consolidation_configuration_input.zig").SemanticOverrideConsolidationConfigurationInput;
const SummaryOverrideConsolidationConfigurationInput = @import("summary_override_consolidation_configuration_input.zig").SummaryOverrideConsolidationConfigurationInput;
const UserPreferenceOverrideConsolidationConfigurationInput = @import("user_preference_override_consolidation_configuration_input.zig").UserPreferenceOverrideConsolidationConfigurationInput;

/// Input for a custom consolidation configuration.
pub const CustomConsolidationConfigurationInput = union(enum) {
    /// Configurations to override the consolidation step of the episodic strategy.
    episodic_consolidation_override: ?EpisodicOverrideConsolidationConfigurationInput,
    /// The semantic consolidation override configuration input.
    semantic_consolidation_override: ?SemanticOverrideConsolidationConfigurationInput,
    /// The summary consolidation override configuration input.
    summary_consolidation_override: ?SummaryOverrideConsolidationConfigurationInput,
    /// The user preference consolidation override configuration input.
    user_preference_consolidation_override: ?UserPreferenceOverrideConsolidationConfigurationInput,

    pub const json_field_names = .{
        .episodic_consolidation_override = "episodicConsolidationOverride",
        .semantic_consolidation_override = "semanticConsolidationOverride",
        .summary_consolidation_override = "summaryConsolidationOverride",
        .user_preference_consolidation_override = "userPreferenceConsolidationOverride",
    };
};
