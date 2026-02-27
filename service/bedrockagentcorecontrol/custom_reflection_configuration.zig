const EpisodicReflectionOverride = @import("episodic_reflection_override.zig").EpisodicReflectionOverride;

/// Contains configurations for a custom reflection strategy.
pub const CustomReflectionConfiguration = union(enum) {
    /// The configuration for a reflection strategy to override the default one.
    episodic_reflection_override: ?EpisodicReflectionOverride,

    pub const json_field_names = .{
        .episodic_reflection_override = "episodicReflectionOverride",
    };
};
