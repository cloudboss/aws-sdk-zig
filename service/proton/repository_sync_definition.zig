/// A repository sync definition.
pub const RepositorySyncDefinition = struct {
    /// The repository branch.
    branch: []const u8,

    /// The directory in the repository.
    directory: []const u8,

    /// The resource that is synced from.
    parent: []const u8,

    /// The resource that is synced to.
    target: []const u8,

    pub const json_field_names = .{
        .branch = "branch",
        .directory = "directory",
        .parent = "parent",
        .target = "target",
    };
};
