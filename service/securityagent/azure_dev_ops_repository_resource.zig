/// An Azure DevOps repository integrated as a resource.
pub const AzureDevOpsRepositoryResource = struct {
    name: []const u8,

    /// The name of the Azure DevOps organization that owns the repository.
    organization: []const u8,

    /// The name of the Azure DevOps project that contains the repository.
    project: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .organization = "organization",
        .project = "project",
    };
};
