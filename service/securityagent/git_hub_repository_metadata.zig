const AccessType = @import("access_type.zig").AccessType;

/// Contains metadata about a GitHub repository that is integrated with the
/// service.
pub const GitHubRepositoryMetadata = struct {
    /// The access type of the GitHub repository. Valid values are PRIVATE and
    /// PUBLIC.
    access_type: ?AccessType = null,

    /// The name of the GitHub repository.
    name: []const u8,

    /// The owner of the GitHub repository.
    owner: []const u8,

    /// The provider-specific resource identifier for the GitHub repository.
    provider_resource_id: []const u8,

    pub const json_field_names = .{
        .access_type = "accessType",
        .name = "name",
        .owner = "owner",
        .provider_resource_id = "providerResourceId",
    };
};
