const std = @import("std");

pub const CredentialProviderVendorType = enum {
    google_oauth_2,
    github_oauth_2,
    slack_oauth_2,
    salesforce_oauth_2,
    microsoft_oauth_2,
    custom_oauth_2,
    atlassian_oauth_2,
    linkedin_oauth_2,
    x_oauth_2,
    okta_oauth_2,
    one_login_oauth_2,
    ping_one_oauth_2,
    facebook_oauth_2,
    yandex_oauth_2,
    reddit_oauth_2,
    zoom_oauth_2,
    twitch_oauth_2,
    spotify_oauth_2,
    dropbox_oauth_2,
    notion_oauth_2,
    hubspot_oauth_2,
    cyber_ark_oauth_2,
    fusion_auth_oauth_2,
    auth_0_oauth_2,
    cognito_oauth_2,

    pub const json_field_names = .{
        .google_oauth_2 = "GoogleOauth2",
        .github_oauth_2 = "GithubOauth2",
        .slack_oauth_2 = "SlackOauth2",
        .salesforce_oauth_2 = "SalesforceOauth2",
        .microsoft_oauth_2 = "MicrosoftOauth2",
        .custom_oauth_2 = "CustomOauth2",
        .atlassian_oauth_2 = "AtlassianOauth2",
        .linkedin_oauth_2 = "LinkedinOauth2",
        .x_oauth_2 = "XOauth2",
        .okta_oauth_2 = "OktaOauth2",
        .one_login_oauth_2 = "OneLoginOauth2",
        .ping_one_oauth_2 = "PingOneOauth2",
        .facebook_oauth_2 = "FacebookOauth2",
        .yandex_oauth_2 = "YandexOauth2",
        .reddit_oauth_2 = "RedditOauth2",
        .zoom_oauth_2 = "ZoomOauth2",
        .twitch_oauth_2 = "TwitchOauth2",
        .spotify_oauth_2 = "SpotifyOauth2",
        .dropbox_oauth_2 = "DropboxOauth2",
        .notion_oauth_2 = "NotionOauth2",
        .hubspot_oauth_2 = "HubspotOauth2",
        .cyber_ark_oauth_2 = "CyberArkOauth2",
        .fusion_auth_oauth_2 = "FusionAuthOauth2",
        .auth_0_oauth_2 = "Auth0Oauth2",
        .cognito_oauth_2 = "CognitoOauth2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .google_oauth_2 => "GoogleOauth2",
            .github_oauth_2 => "GithubOauth2",
            .slack_oauth_2 => "SlackOauth2",
            .salesforce_oauth_2 => "SalesforceOauth2",
            .microsoft_oauth_2 => "MicrosoftOauth2",
            .custom_oauth_2 => "CustomOauth2",
            .atlassian_oauth_2 => "AtlassianOauth2",
            .linkedin_oauth_2 => "LinkedinOauth2",
            .x_oauth_2 => "XOauth2",
            .okta_oauth_2 => "OktaOauth2",
            .one_login_oauth_2 => "OneLoginOauth2",
            .ping_one_oauth_2 => "PingOneOauth2",
            .facebook_oauth_2 => "FacebookOauth2",
            .yandex_oauth_2 => "YandexOauth2",
            .reddit_oauth_2 => "RedditOauth2",
            .zoom_oauth_2 => "ZoomOauth2",
            .twitch_oauth_2 => "TwitchOauth2",
            .spotify_oauth_2 => "SpotifyOauth2",
            .dropbox_oauth_2 => "DropboxOauth2",
            .notion_oauth_2 => "NotionOauth2",
            .hubspot_oauth_2 => "HubspotOauth2",
            .cyber_ark_oauth_2 => "CyberArkOauth2",
            .fusion_auth_oauth_2 => "FusionAuthOauth2",
            .auth_0_oauth_2 => "Auth0Oauth2",
            .cognito_oauth_2 => "CognitoOauth2",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
