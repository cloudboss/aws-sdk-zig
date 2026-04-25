/// An episodic reflection configuration input.
pub const EpisodicReflectionConfigurationInput = struct {
    /// The namespaces over which to create reflections. Can be less nested than
    /// episode namespaces.
    namespaces: ?[]const []const u8 = null,

    /// The namespaceTemplates over which to create reflections. Can be less nested
    /// than episode namespaces.
    namespace_templates: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .namespaces = "namespaces",
        .namespace_templates = "namespaceTemplates",
    };
};
