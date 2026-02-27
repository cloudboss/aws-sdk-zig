/// The configuration for the reflections created with the episodic memory
/// strategy.
pub const EpisodicReflectionConfiguration = struct {
    /// The namespaces for which to create reflections. Can be less nested than the
    /// episodic namespaces.
    namespaces: []const []const u8,

    pub const json_field_names = .{
        .namespaces = "namespaces",
    };
};
