const EpisodicReflectionConfigurationInput = @import("episodic_reflection_configuration_input.zig").EpisodicReflectionConfigurationInput;

/// Input for creating an episodic memory strategy.
pub const EpisodicMemoryStrategyInput = struct {
    /// The description of the episodic memory strategy.
    description: ?[]const u8,

    /// The name of the episodic memory strategy.
    name: []const u8,

    /// The namespaces for which to create episodes.
    namespaces: ?[]const []const u8,

    /// The configuration for the reflections created with the episodic memory
    /// strategy.
    reflection_configuration: ?EpisodicReflectionConfigurationInput,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .namespaces = "namespaces",
        .reflection_configuration = "reflectionConfiguration",
    };
};
