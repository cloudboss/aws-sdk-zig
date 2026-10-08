const AzureDevOpsResourceCapabilities = @import("azure_dev_ops_resource_capabilities.zig").AzureDevOpsResourceCapabilities;
const BitbucketResourceCapabilities = @import("bitbucket_resource_capabilities.zig").BitbucketResourceCapabilities;
const ConfluenceResourceCapabilities = @import("confluence_resource_capabilities.zig").ConfluenceResourceCapabilities;
const GitHubResourceCapabilities = @import("git_hub_resource_capabilities.zig").GitHubResourceCapabilities;
const GitLabResourceCapabilities = @import("git_lab_resource_capabilities.zig").GitLabResourceCapabilities;

/// The capabilities for an integrated resource from a third-party provider.
/// This is a union type that contains provider-specific capabilities.
pub const ProviderResourceCapabilities = union(enum) {
    /// The Azure DevOps-specific resource capabilities.
    azure_dev_ops: ?AzureDevOpsResourceCapabilities,
    bitbucket: ?BitbucketResourceCapabilities,
    confluence: ?ConfluenceResourceCapabilities,
    /// The GitHub-specific resource capabilities.
    github: ?GitHubResourceCapabilities,
    gitlab: ?GitLabResourceCapabilities,

    pub const json_field_names = .{
        .azure_dev_ops = "azureDevOps",
        .bitbucket = "bitbucket",
        .confluence = "confluence",
        .github = "github",
        .gitlab = "gitlab",
    };
};
