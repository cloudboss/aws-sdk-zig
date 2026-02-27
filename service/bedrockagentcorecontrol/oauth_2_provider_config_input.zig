const AtlassianOauth2ProviderConfigInput = @import("atlassian_oauth_2_provider_config_input.zig").AtlassianOauth2ProviderConfigInput;
const CustomOauth2ProviderConfigInput = @import("custom_oauth_2_provider_config_input.zig").CustomOauth2ProviderConfigInput;
const GithubOauth2ProviderConfigInput = @import("github_oauth_2_provider_config_input.zig").GithubOauth2ProviderConfigInput;
const GoogleOauth2ProviderConfigInput = @import("google_oauth_2_provider_config_input.zig").GoogleOauth2ProviderConfigInput;
const IncludedOauth2ProviderConfigInput = @import("included_oauth_2_provider_config_input.zig").IncludedOauth2ProviderConfigInput;
const LinkedinOauth2ProviderConfigInput = @import("linkedin_oauth_2_provider_config_input.zig").LinkedinOauth2ProviderConfigInput;
const MicrosoftOauth2ProviderConfigInput = @import("microsoft_oauth_2_provider_config_input.zig").MicrosoftOauth2ProviderConfigInput;
const SalesforceOauth2ProviderConfigInput = @import("salesforce_oauth_2_provider_config_input.zig").SalesforceOauth2ProviderConfigInput;
const SlackOauth2ProviderConfigInput = @import("slack_oauth_2_provider_config_input.zig").SlackOauth2ProviderConfigInput;

/// Contains the input configuration for an OAuth2 provider.
pub const Oauth2ProviderConfigInput = union(enum) {
    /// Configuration settings for Atlassian OAuth2 provider integration.
    atlassian_oauth_2_provider_config: ?AtlassianOauth2ProviderConfigInput,
    /// The configuration for a custom OAuth2 provider.
    custom_oauth_2_provider_config: ?CustomOauth2ProviderConfigInput,
    /// The configuration for a GitHub OAuth2 provider.
    github_oauth_2_provider_config: ?GithubOauth2ProviderConfigInput,
    /// The configuration for a Google OAuth2 provider.
    google_oauth_2_provider_config: ?GoogleOauth2ProviderConfigInput,
    /// The configuration for a non-custom OAuth2 provider. This includes settings
    /// for supported OAuth2 providers that have built-in integration support.
    included_oauth_2_provider_config: ?IncludedOauth2ProviderConfigInput,
    /// Configuration settings for LinkedIn OAuth2 provider integration.
    linkedin_oauth_2_provider_config: ?LinkedinOauth2ProviderConfigInput,
    /// The configuration for a Microsoft OAuth2 provider.
    microsoft_oauth_2_provider_config: ?MicrosoftOauth2ProviderConfigInput,
    /// The configuration for a Salesforce OAuth2 provider.
    salesforce_oauth_2_provider_config: ?SalesforceOauth2ProviderConfigInput,
    /// The configuration for a Slack OAuth2 provider.
    slack_oauth_2_provider_config: ?SlackOauth2ProviderConfigInput,

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
