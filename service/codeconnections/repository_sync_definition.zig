/// The definition for a repository with a sync configuration.
pub const RepositorySyncDefinition = struct {
    /// The branch specified for a repository sync definition.
    branch: []const u8,

    /// The configuration file for a repository sync definition. This value comes
    /// from creating
    /// or updating the `config-file` field of a `sync-configuration`.
    directory: []const u8,

    /// The parent resource specified for a repository sync definition.
    parent: []const u8,

    /// The target resource specified for a repository sync definition. In some
    /// cases, such as CFN_STACK_SYNC, the parent and target resource are the same.
    target: []const u8,

    pub const json_field_names = .{
        .branch = "Branch",
        .directory = "Directory",
        .parent = "Parent",
        .target = "Target",
    };
};
