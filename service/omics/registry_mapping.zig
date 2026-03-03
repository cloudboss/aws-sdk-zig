/// If you are using the ECR pull through cache feature, the registry mapping
/// maps between the ECR repository and the upstream registry where container
/// images are pulled and synchronized.
pub const RegistryMapping = struct {
    /// Account ID of the account that owns the upstream container image.
    ecr_account_id: ?[]const u8 = null,

    /// The repository prefix to use in the ECR private repository.
    ecr_repository_prefix: ?[]const u8 = null,

    /// The URI of the upstream registry.
    upstream_registry_url: ?[]const u8 = null,

    /// The repository prefix of the corresponding repository in the upstream
    /// registry.
    upstream_repository_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .ecr_account_id = "ecrAccountId",
        .ecr_repository_prefix = "ecrRepositoryPrefix",
        .upstream_registry_url = "upstreamRegistryUrl",
        .upstream_repository_prefix = "upstreamRepositoryPrefix",
    };
};
