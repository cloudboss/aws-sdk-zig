const AtlassianOauth2ProviderConfigOutput = @import("atlassian_oauth_2_provider_config_output.zig").AtlassianOauth2ProviderConfigOutput;
const CustomOauth2ProviderConfigOutput = @import("custom_oauth_2_provider_config_output.zig").CustomOauth2ProviderConfigOutput;
const GithubOauth2ProviderConfigOutput = @import("github_oauth_2_provider_config_output.zig").GithubOauth2ProviderConfigOutput;
const GoogleOauth2ProviderConfigOutput = @import("google_oauth_2_provider_config_output.zig").GoogleOauth2ProviderConfigOutput;
const IncludedOauth2ProviderConfigOutput = @import("included_oauth_2_provider_config_output.zig").IncludedOauth2ProviderConfigOutput;
const LinkedinOauth2ProviderConfigOutput = @import("linkedin_oauth_2_provider_config_output.zig").LinkedinOauth2ProviderConfigOutput;
const MicrosoftOauth2ProviderConfigOutput = @import("microsoft_oauth_2_provider_config_output.zig").MicrosoftOauth2ProviderConfigOutput;
const SalesforceOauth2ProviderConfigOutput = @import("salesforce_oauth_2_provider_config_output.zig").SalesforceOauth2ProviderConfigOutput;
const SlackOauth2ProviderConfigOutput = @import("slack_oauth_2_provider_config_output.zig").SlackOauth2ProviderConfigOutput;

/// Contains the output configuration for an OAuth2 provider.
pub const Oauth2ProviderConfigOutput = union(enum) {
    /// The configuration details for the Atlassian OAuth2 provider.
    atlassian_oauth_2_provider_config: ?AtlassianOauth2ProviderConfigOutput,
    /// The output configuration for a custom OAuth2 provider.
    custom_oauth_2_provider_config: ?CustomOauth2ProviderConfigOutput,
    /// The output configuration for a GitHub OAuth2 provider.
    github_oauth_2_provider_config: ?GithubOauth2ProviderConfigOutput,
    /// The output configuration for a Google OAuth2 provider.
    google_oauth_2_provider_config: ?GoogleOauth2ProviderConfigOutput,
    /// The configuration for a non-custom OAuth2 provider. This includes the
    /// configuration details for supported OAuth2 providers that have built-in
    /// integration support.
    included_oauth_2_provider_config: ?IncludedOauth2ProviderConfigOutput,
    /// The configuration details for the LinkedIn OAuth2 provider.
    linkedin_oauth_2_provider_config: ?LinkedinOauth2ProviderConfigOutput,
    /// The output configuration for a Microsoft OAuth2 provider.
    microsoft_oauth_2_provider_config: ?MicrosoftOauth2ProviderConfigOutput,
    /// The output configuration for a Salesforce OAuth2 provider.
    salesforce_oauth_2_provider_config: ?SalesforceOauth2ProviderConfigOutput,
    /// The output configuration for a Slack OAuth2 provider.
    slack_oauth_2_provider_config: ?SlackOauth2ProviderConfigOutput,

    pub const json_field_names = .{
        .atlassian_oauth_2_provider_config = "atlassianOauth2ProviderConfig",
        .custom_oauth_2_provider_config = "customOauth2ProviderConfig",
        .github_oauth_2_provider_config = "githubOauth2ProviderConfig",
        .google_oauth_2_provider_config = "googleOauth2ProviderConfig",
        .included_oauth_2_provider_config = "includedOauth2ProviderConfig",
        .linkedin_oauth_2_provider_config = "linkedinOauth2ProviderConfig",
        .microsoft_oauth_2_provider_config = "microsoftOauth2ProviderConfig",
        .salesforce_oauth_2_provider_config = "salesforceOauth2ProviderConfig",
        .slack_oauth_2_provider_config = "slackOauth2ProviderConfig",
    };
};
