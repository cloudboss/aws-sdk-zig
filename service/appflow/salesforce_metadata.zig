const SalesforceDataTransferApi = @import("salesforce_data_transfer_api.zig").SalesforceDataTransferApi;
const OAuth2GrantType = @import("o_auth_2_grant_type.zig").OAuth2GrantType;

/// The connector metadata specific to Salesforce.
pub const SalesforceMetadata = struct {
    /// The Salesforce APIs that you can have Amazon AppFlow use when your flows
    /// transfers
    /// data to or from Salesforce.
    data_transfer_apis: ?[]const SalesforceDataTransferApi = null,

    /// The OAuth 2.0 grant types that Amazon AppFlow can use when it requests an
    /// access
    /// token from Salesforce. Amazon AppFlow requires an access token each time it
    /// attempts to
    /// access your Salesforce records.
    ///
    /// **AUTHORIZATION_CODE**
    ///
    /// Amazon AppFlow passes an authorization code when it requests the access
    /// token
    /// from Salesforce. Amazon AppFlow receives the authorization code from
    /// Salesforce
    /// after you log in to your Salesforce account and authorize Amazon AppFlow to
    /// access
    /// your records.
    ///
    /// **JWT_BEARER**
    ///
    /// Amazon AppFlow passes a JSON web token (JWT) when it requests the access
    /// token
    /// from Salesforce. You provide the JWT to Amazon AppFlow when you define the
    /// connection to your Salesforce account. When you use this grant type, you
    /// don't need to
    /// log in to your Salesforce account to authorize Amazon AppFlow to access your
    /// records.
    ///
    /// The CLIENT_CREDENTIALS value is not supported for Salesforce.
    oauth_2_grant_types_supported: ?[]const OAuth2GrantType = null,

    /// The desired authorization scope for the Salesforce account.
    o_auth_scopes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .data_transfer_apis = "dataTransferApis",
        .oauth_2_grant_types_supported = "oauth2GrantTypesSupported",
        .o_auth_scopes = "oAuthScopes",
    };
};
