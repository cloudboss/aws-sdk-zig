const EpisodicOverrideReflectionConfigurationInput = @import("episodic_override_reflection_configuration_input.zig").EpisodicOverrideReflectionConfigurationInput;

/// Input for a custom reflection configuration.
pub const CustomReflectionConfigurationInput = union(enum) {
    /// The reflection override configuration input.
    episodic_reflection_override: ?EpisodicOverrideReflectionConfigurationInput,

    pub const json_field_names = .{
        .episodic_reflection_override = "episodicReflectionOverride",
    };
};
