const RepositoryBranch = @import("repository_branch.zig").RepositoryBranch;

/// Proton settings that are used for multiple services in the Amazon Web
/// Services account.
pub const AccountSettings = struct {
    /// The Amazon Resource Name (ARN) of the service role that Proton uses for
    /// provisioning pipelines. Proton assumes this role for CodeBuild-based
    /// provisioning.
    pipeline_codebuild_role_arn: ?[]const u8,

    /// The linked repository for pipeline provisioning. Required if you have
    /// environments configured for self-managed provisioning with services that
    /// include
    /// pipelines. A linked repository is a repository that has been registered with
    /// Proton. For more information, see CreateRepository.
    pipeline_provisioning_repository: ?RepositoryBranch,

    /// The Amazon Resource Name (ARN) of the service role you want to use for
    /// provisioning pipelines. Assumed by Proton for Amazon Web Services-managed
    /// provisioning, and by
    /// customer-owned automation for self-managed provisioning.
    pipeline_service_role_arn: ?[]const u8,

    pub const json_field_names = .{
        .pipeline_codebuild_role_arn = "pipelineCodebuildRoleArn",
        .pipeline_provisioning_repository = "pipelineProvisioningRepository",
        .pipeline_service_role_arn = "pipelineServiceRoleArn",
    };
};
