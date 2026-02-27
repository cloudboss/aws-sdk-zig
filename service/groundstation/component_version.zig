/// Version information for agent components.
pub const ComponentVersion = struct {
    /// Component type.
    component_type: []const u8,

    /// List of versions.
    versions: []const []const u8,

    pub const json_field_names = .{
        .component_type = "componentType",
        .versions = "versions",
    };
};
