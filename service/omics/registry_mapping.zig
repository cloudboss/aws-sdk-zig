/// If you are using the ECR pull through cache feature, the registry mapping
/// maps between the ECR repository and the upstream registry where container
/// images are pulled and synchronized.
pub const RegistryMapping = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret that holds the credentials for the upstream registry. You must
    /// specify this value when Amazon Elastic Container Registry (Amazon ECR)
    /// doesn't support pull through cache for the upstream registry. HealthOmics
    /// supports only some of these registries. The workflow role must have
    /// permission to call the `secretsmanager:GetSecretValue` operation on the
    /// secret. For more information about the supported registries, see [Container
    /// images](https://docs.aws.amazon.com/omics/latest/dev/workflows-ecr.html) in
    /// the *Amazon Web Services HealthOmics User Guide*.
    credential_arn: ?[]const u8 = null,

    /// Account ID of the account that owns the upstream container image.
    ecr_account_id: ?[]const u8 = null,

    /// The repository prefix to use in the ECR private repository.
    ecr_repository_prefix: []const u8,

    /// The URI of the upstream registry.
    upstream_registry_url: []const u8,

    /// The repository prefix of the corresponding repository in the upstream
    /// registry.
    upstream_repository_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .credential_arn = "credentialArn",
        .ecr_account_id = "ecrAccountId",
        .ecr_repository_prefix = "ecrRepositoryPrefix",
        .upstream_registry_url = "upstreamRegistryUrl",
        .upstream_repository_prefix = "upstreamRepositoryPrefix",
    };
};
