/// Represents a code repository that is integrated with the service through a
/// third-party provider.
pub const IntegratedRepository = struct {
    /// An optional override for the repository branch.
    branch: ?[]const u8 = null,

    /// The unique identifier of the integration that provides access to the
    /// repository.
    integration_id: []const u8,

    /// The provider-specific resource identifier for the repository.
    provider_resource_id: []const u8,

    pub const json_field_names = .{
        .branch = "branch",
        .integration_id = "integrationId",
        .provider_resource_id = "providerResourceId",
    };
};
