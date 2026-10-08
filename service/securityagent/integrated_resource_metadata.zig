const AzureDevOpsRepositoryMetadata = @import("azure_dev_ops_repository_metadata.zig").AzureDevOpsRepositoryMetadata;
const BitbucketRepositoryMetadata = @import("bitbucket_repository_metadata.zig").BitbucketRepositoryMetadata;
const ConfluenceDocumentMetadata = @import("confluence_document_metadata.zig").ConfluenceDocumentMetadata;
const GitHubRepositoryMetadata = @import("git_hub_repository_metadata.zig").GitHubRepositoryMetadata;
const GitLabRepositoryMetadata = @import("git_lab_repository_metadata.zig").GitLabRepositoryMetadata;

/// Contains metadata about an integrated resource. This is a union type that
/// contains provider-specific metadata.
pub const IntegratedResourceMetadata = union(enum) {
    /// The Azure DevOps repository metadata.
    azure_dev_ops_repository: ?AzureDevOpsRepositoryMetadata,
    bitbucket_repository: ?BitbucketRepositoryMetadata,
    confluence_document: ?ConfluenceDocumentMetadata,
    /// The GitHub repository metadata.
    github_repository: ?GitHubRepositoryMetadata,
    gitlab_repository: ?GitLabRepositoryMetadata,

    pub const json_field_names = .{
        .azure_dev_ops_repository = "azureDevOpsRepository",
        .bitbucket_repository = "bitbucketRepository",
        .confluence_document = "confluenceDocument",
        .github_repository = "githubRepository",
        .gitlab_repository = "gitlabRepository",
    };
};
