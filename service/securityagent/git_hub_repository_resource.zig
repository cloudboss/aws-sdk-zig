/// Represents a GitHub repository resource used in an integration.
pub const GitHubRepositoryResource = struct {
    /// The name of the GitHub repository.
    name: []const u8,

    /// The owner of the GitHub repository.
    owner: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .owner = "owner",
    };
};
