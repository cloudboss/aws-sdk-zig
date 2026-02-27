/// Input for creating a user preference memory strategy.
pub const UserPreferenceMemoryStrategyInput = struct {
    /// The description of the user preference memory strategy.
    description: ?[]const u8,

    /// The name of the user preference memory strategy.
    name: []const u8,

    /// The namespaces associated with the user preference memory strategy.
    namespaces: ?[]const []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .namespaces = "namespaces",
    };
};
