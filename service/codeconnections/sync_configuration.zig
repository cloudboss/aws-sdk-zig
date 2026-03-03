const ProviderType = @import("provider_type.zig").ProviderType;
const PublishDeploymentStatus = @import("publish_deployment_status.zig").PublishDeploymentStatus;
const PullRequestComment = @import("pull_request_comment.zig").PullRequestComment;
const SyncConfigurationType = @import("sync_configuration_type.zig").SyncConfigurationType;
const TriggerResourceUpdateOn = @import("trigger_resource_update_on.zig").TriggerResourceUpdateOn;

/// Information, such as repository, branch, provider, and resource names for a
/// specific sync configuration.
pub const SyncConfiguration = struct {
    /// The branch associated with a specific sync configuration.
    branch: []const u8,

    /// The file path to the configuration file associated with a specific sync
    /// configuration. The path should point to an actual file in the sync
    /// configurations linked repository.
    config_file: ?[]const u8 = null,

    /// The owner ID for the repository associated with a specific sync
    /// configuration, such as
    /// the owner ID in GitHub.
    owner_id: []const u8,

    /// The connection provider type associated with a specific sync configuration,
    /// such as
    /// GitHub.
    provider_type: ProviderType,

    /// Whether to enable or disable publishing of deployment status to source
    /// providers.
    publish_deployment_status: ?PublishDeploymentStatus = null,

    /// A toggle that specifies whether to enable or disable pull request comments
    /// for the sync configuration to be created.
    pull_request_comment: ?PullRequestComment = null,

    /// The ID of the repository link associated with a specific sync configuration.
    repository_link_id: []const u8,

    /// The name of the repository associated with a specific sync configuration.
    repository_name: []const u8,

    /// The name of the connection resource associated with a specific sync
    /// configuration.
    resource_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role associated with a specific
    /// sync configuration.
    role_arn: []const u8,

    /// The type of sync for a specific sync configuration.
    sync_type: SyncConfigurationType,

    /// When to trigger Git sync to begin the stack update.
    trigger_resource_update_on: ?TriggerResourceUpdateOn = null,

    pub const json_field_names = .{
        .branch = "Branch",
        .config_file = "ConfigFile",
        .owner_id = "OwnerId",
        .provider_type = "ProviderType",
        .publish_deployment_status = "PublishDeploymentStatus",
        .pull_request_comment = "PullRequestComment",
        .repository_link_id = "RepositoryLinkId",
        .repository_name = "RepositoryName",
        .resource_name = "ResourceName",
        .role_arn = "RoleArn",
        .sync_type = "SyncType",
        .trigger_resource_update_on = "TriggerResourceUpdateOn",
    };
};
