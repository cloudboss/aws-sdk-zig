const AzureDevOpsIntegrationInput = @import("azure_dev_ops_integration_input.zig").AzureDevOpsIntegrationInput;
const BitbucketIntegrationInput = @import("bitbucket_integration_input.zig").BitbucketIntegrationInput;
const BitbucketDataCenterIntegrationInput = @import("bitbucket_data_center_integration_input.zig").BitbucketDataCenterIntegrationInput;
const ConfluenceIntegrationInput = @import("confluence_integration_input.zig").ConfluenceIntegrationInput;
const GitHubIntegrationInput = @import("git_hub_integration_input.zig").GitHubIntegrationInput;
const GitLabIntegrationInput = @import("git_lab_integration_input.zig").GitLabIntegrationInput;

/// The provider-specific input for creating an integration. This is a union
/// type that contains provider-specific configuration.
pub const ProviderInput = union(enum) {
    /// The Azure DevOps-specific input for creating an integration.
    azure_dev_ops: ?AzureDevOpsIntegrationInput,
    /// The configuration for a Bitbucket integration.
    bitbucket: ?BitbucketIntegrationInput,
    /// The Bitbucket Data Center-specific input for creating an integration.
    bitbucket_data_center: ?BitbucketDataCenterIntegrationInput,
    /// The configuration for a Confluence integration.
    confluence: ?ConfluenceIntegrationInput,
    /// The GitHub-specific input for creating an integration.
    github: ?GitHubIntegrationInput,
    /// The configuration for a GitLab integration.
    gitlab: ?GitLabIntegrationInput,

    pub const json_field_names = .{
        .azure_dev_ops = "azureDevOps",
        .bitbucket = "bitbucket",
        .bitbucket_data_center = "bitbucketDataCenter",
        .confluence = "confluence",
        .github = "github",
        .gitlab = "gitlab",
    };
};
