const CustomReflectionConfigurationInput = @import("custom_reflection_configuration_input.zig").CustomReflectionConfigurationInput;
const EpisodicReflectionConfigurationInput = @import("episodic_reflection_configuration_input.zig").EpisodicReflectionConfigurationInput;

/// Contains information for modifying a reflection configuration.
pub const ModifyReflectionConfiguration = union(enum) {
    /// The updated custom reflection configuration.
    custom_reflection_configuration: ?CustomReflectionConfigurationInput,
    /// The updated episodic reflection configuration.
    episodic_reflection_configuration: ?EpisodicReflectionConfigurationInput,

    pub const json_field_names = .{
        .custom_reflection_configuration = "customReflectionConfiguration",
        .episodic_reflection_configuration = "episodicReflectionConfiguration",
    };
};
