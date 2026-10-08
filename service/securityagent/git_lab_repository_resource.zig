/// A GitLab repository integrated as a resource.
pub const GitLabRepositoryResource = struct {
    name: []const u8,

    /// The namespace (group or user path) that owns the project.
    namespace: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .namespace = "namespace",
    };
};
