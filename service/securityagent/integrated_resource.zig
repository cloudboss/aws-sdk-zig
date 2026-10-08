const AzureDevOpsRepositoryResource = @import("azure_dev_ops_repository_resource.zig").AzureDevOpsRepositoryResource;
const BitbucketRepositoryResource = @import("bitbucket_repository_resource.zig").BitbucketRepositoryResource;
const ConfluenceDocumentResource = @import("confluence_document_resource.zig").ConfluenceDocumentResource;
const GitHubRepositoryResource = @import("git_hub_repository_resource.zig").GitHubRepositoryResource;
const GitLabRepositoryResource = @import("git_lab_repository_resource.zig").GitLabRepositoryResource;

/// Represents an integrated resource from a third-party provider. This is a
/// union type that contains provider-specific resource information.
pub const IntegratedResource = union(enum) {
    /// The Azure DevOps repository resource information.
    azure_dev_ops_repository: ?AzureDevOpsRepositoryResource,
    bitbucket_repository: ?BitbucketRepositoryResource,
    confluence_document: ?ConfluenceDocumentResource,
    /// The GitHub repository resource information.
    github_repository: ?GitHubRepositoryResource,
    gitlab_repository: ?GitLabRepositoryResource,

    pub const json_field_names = .{
        .azure_dev_ops_repository = "azureDevOpsRepository",
        .bitbucket_repository = "bitbucketRepository",
        .confluence_document = "confluenceDocument",
        .github_repository = "githubRepository",
        .gitlab_repository = "gitlabRepository",
    };
};
