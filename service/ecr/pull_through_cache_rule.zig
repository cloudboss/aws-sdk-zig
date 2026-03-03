const UpstreamRegistry = @import("upstream_registry.zig").UpstreamRegistry;

/// The details of a pull through cache rule.
pub const PullThroughCacheRule = struct {
    /// The date and time the pull through cache was created.
    created_at: ?i64 = null,

    /// The ARN of the Secrets Manager secret associated with the pull through cache
    /// rule.
    credential_arn: ?[]const u8 = null,

    /// The ARN of the IAM role associated with the pull through cache rule.
    custom_role_arn: ?[]const u8 = null,

    /// The Amazon ECR repository prefix associated with the pull through cache
    /// rule.
    ecr_repository_prefix: ?[]const u8 = null,

    /// The Amazon Web Services account ID associated with the registry the pull
    /// through cache rule is
    /// associated with.
    registry_id: ?[]const u8 = null,

    /// The date and time, in JavaScript date format, when the pull through cache
    /// rule was
    /// last updated.
    updated_at: ?i64 = null,

    /// The name of the upstream source registry associated with the pull through
    /// cache
    /// rule.
    upstream_registry: ?UpstreamRegistry = null,

    /// The upstream registry URL associated with the pull through cache rule.
    upstream_registry_url: ?[]const u8 = null,

    /// The upstream repository prefix associated with the pull through cache rule.
    upstream_repository_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .credential_arn = "credentialArn",
        .custom_role_arn = "customRoleArn",
        .ecr_repository_prefix = "ecrRepositoryPrefix",
        .registry_id = "registryId",
        .updated_at = "updatedAt",
        .upstream_registry = "upstreamRegistry",
        .upstream_registry_url = "upstreamRegistryUrl",
        .upstream_repository_prefix = "upstreamRepositoryPrefix",
    };
};
