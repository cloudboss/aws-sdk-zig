const AccessType = @import("access_type.zig").AccessType;

/// Metadata for an integrated Azure DevOps repository.
pub const AzureDevOpsRepositoryMetadata = struct {
    access_type: ?AccessType = null,

    name: []const u8,

    /// The name of the Azure DevOps organization that owns the repository.
    organization: []const u8,

    /// The name of the Azure DevOps project that contains the repository.
    project: ?[]const u8 = null,

    /// The GUID of the Azure DevOps project that contains the repository.
    project_id: ?[]const u8 = null,

    provider_resource_id: []const u8,

    pub const json_field_names = .{
        .access_type = "accessType",
        .name = "name",
        .organization = "organization",
        .project = "project",
        .project_id = "projectId",
        .provider_resource_id = "providerResourceId",
    };
};
