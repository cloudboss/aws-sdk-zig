/// An episodic reflection configuration input.
pub const EpisodicReflectionConfigurationInput = struct {
    /// The namespaces over which to create reflections. Can be less nested than
    /// episode namespaces.
    namespaces: []const []const u8,

    pub const json_field_names = .{
        .namespaces = "namespaces",
    };
};
