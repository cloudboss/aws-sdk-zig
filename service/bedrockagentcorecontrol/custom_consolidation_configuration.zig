const EpisodicConsolidationOverride = @import("episodic_consolidation_override.zig").EpisodicConsolidationOverride;
const SemanticConsolidationOverride = @import("semantic_consolidation_override.zig").SemanticConsolidationOverride;
const SummaryConsolidationOverride = @import("summary_consolidation_override.zig").SummaryConsolidationOverride;
const UserPreferenceConsolidationOverride = @import("user_preference_consolidation_override.zig").UserPreferenceConsolidationOverride;

/// Contains custom consolidation configuration information.
pub const CustomConsolidationConfiguration = union(enum) {
    /// The configurations to override the default consolidation step for the
    /// episodic memory strategy.
    episodic_consolidation_override: ?EpisodicConsolidationOverride,
    /// The semantic consolidation override configuration.
    semantic_consolidation_override: ?SemanticConsolidationOverride,
    /// The summary consolidation override configuration.
    summary_consolidation_override: ?SummaryConsolidationOverride,
    /// The user preference consolidation override configuration.
    user_preference_consolidation_override: ?UserPreferenceConsolidationOverride,

    pub const json_field_names = .{
        .episodic_consolidation_override = "episodicConsolidationOverride",
        .semantic_consolidation_override = "semanticConsolidationOverride",
        .summary_consolidation_override = "summaryConsolidationOverride",
        .user_preference_consolidation_override = "userPreferenceConsolidationOverride",
    };
};
