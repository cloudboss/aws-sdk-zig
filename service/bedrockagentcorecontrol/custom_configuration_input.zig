const EpisodicOverrideConfigurationInput = @import("episodic_override_configuration_input.zig").EpisodicOverrideConfigurationInput;
const SelfManagedConfigurationInput = @import("self_managed_configuration_input.zig").SelfManagedConfigurationInput;
const SemanticOverrideConfigurationInput = @import("semantic_override_configuration_input.zig").SemanticOverrideConfigurationInput;
const SummaryOverrideConfigurationInput = @import("summary_override_configuration_input.zig").SummaryOverrideConfigurationInput;
const UserPreferenceOverrideConfigurationInput = @import("user_preference_override_configuration_input.zig").UserPreferenceOverrideConfigurationInput;

/// Input for custom configuration of a memory strategy.
pub const CustomConfigurationInput = union(enum) {
    /// The episodic memory strategy override configuration for a custom memory
    /// strategy.
    episodic_override: ?EpisodicOverrideConfigurationInput,
    /// The self managed configuration for a custom memory strategy.
    self_managed_configuration: ?SelfManagedConfigurationInput,
    /// The semantic override configuration for a custom memory strategy.
    semantic_override: ?SemanticOverrideConfigurationInput,
    /// The summary override configuration for a custom memory strategy.
    summary_override: ?SummaryOverrideConfigurationInput,
    /// The user preference override configuration for a custom memory strategy.
    user_preference_override: ?UserPreferenceOverrideConfigurationInput,

    pub const json_field_names = .{
        .episodic_override = "episodicOverride",
        .self_managed_configuration = "selfManagedConfiguration",
        .semantic_override = "semanticOverride",
        .summary_override = "summaryOverride",
        .user_preference_override = "userPreferenceOverride",
    };
};
