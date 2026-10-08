/// A Bitbucket repository integrated as a resource.
pub const BitbucketRepositoryResource = struct {
    name: []const u8,

    /// The workspace slug that owns the repository.
    workspace: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .workspace = "workspace",
    };
};
