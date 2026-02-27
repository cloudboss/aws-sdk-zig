const CustomReflectionConfiguration = @import("custom_reflection_configuration.zig").CustomReflectionConfiguration;
const EpisodicReflectionConfiguration = @import("episodic_reflection_configuration.zig").EpisodicReflectionConfiguration;

/// Contains reflection configuration information for a memory strategy.
pub const ReflectionConfiguration = union(enum) {
    /// The configuration for a custom reflection strategy.
    custom_reflection_configuration: ?CustomReflectionConfiguration,
    /// The configuration for the episodic reflection strategy.
    episodic_reflection_configuration: ?EpisodicReflectionConfiguration,

    pub const json_field_names = .{
        .custom_reflection_configuration = "customReflectionConfiguration",
        .episodic_reflection_configuration = "episodicReflectionConfiguration",
    };
};
