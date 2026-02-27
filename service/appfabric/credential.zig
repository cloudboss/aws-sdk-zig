const ApiKeyCredential = @import("api_key_credential.zig").ApiKeyCredential;
const Oauth2Credential = @import("oauth_2_credential.zig").Oauth2Credential;

/// Contains credential information for an application.
pub const Credential = union(enum) {
    /// Contains API key credential information.
    api_key_credential: ?ApiKeyCredential,
    /// Contains OAuth2 client credential information.
    oauth_2_credential: ?Oauth2Credential,

    pub const json_field_names = .{
        .api_key_credential = "apiKeyCredential",
        .oauth_2_credential = "oauth2Credential",
    };
};
