const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityProviderTypeType = @import("identity_provider_type_type.zig").IdentityProviderTypeType;
const IdentityProviderType = @import("identity_provider_type.zig").IdentityProviderType;

pub const CreateIdentityProviderInput = struct {
    /// A mapping of IdP attributes to standard and custom user pool attributes.
    /// Specify a
    /// user pool attribute as the key of the key-value pair, and the IdP attribute
    /// claim name
    /// as the value.
    attribute_mapping: ?[]const aws.map.StringMapEntry = null,

    /// An array of IdP identifiers, for example `"IdPIdentifiers": [ "MyIdP",
    /// "MyIdP2"
    /// ]`. Identifiers are friendly names that you can pass in the
    /// `idp_identifier` query parameter of requests to the [Authorize
    /// endpoint](https://docs.aws.amazon.com/cognito/latest/developerguide/authorization-endpoint.html) to silently redirect to sign-in with the associated IdP.
    /// Identifiers in a domain format also enable the use of [email-address
    /// matching with SAML
    /// providers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managing-saml-idp-naming.html).
    idp_identifiers: ?[]const []const u8 = null,

    /// The scopes, URLs, and identifiers for your external identity provider. The
    /// following
    /// examples describe the provider detail keys for each IdP type. These values
    /// and their
    /// schema are subject to change. Social IdP `authorize_scopes` values must
    /// match
    /// the values listed here.
    ///
    /// **OpenID Connect (OIDC)**
    ///
    /// Amazon Cognito accepts the following elements when it can't discover
    /// endpoint
    /// URLs from `oidc_issuer`: `attributes_url`,
    /// `authorize_url`, `jwks_uri`,
    /// `token_url`.
    ///
    /// Create or update request: `"ProviderDetails": {
    /// "attributes_request_method": "GET", "attributes_url":
    /// "https://auth.example.com/userInfo", "authorize_scopes": "openid profile
    /// email", "authorize_url": "https://auth.example.com/authorize",
    /// "client_id": "1example23456789", "client_secret":
    /// "provider-app-client-secret", "jwks_uri":
    /// "https://auth.example.com/.well-known/jwks.json", "oidc_issuer":
    /// "https://auth.example.com", "token_url": "https://example.com/token"
    /// }`
    ///
    /// Describe response: `"ProviderDetails": { "attributes_request_method":
    /// "GET", "attributes_url": "https://auth.example.com/userInfo",
    /// "attributes_url_add_attributes": "false", "authorize_scopes": "openid
    /// profile email", "authorize_url": "https://auth.example.com/authorize",
    /// "client_id": "1example23456789", "client_secret":
    /// "provider-app-client-secret", "jwks_uri":
    /// "https://auth.example.com/.well-known/jwks.json", "oidc_issuer":
    /// "https://auth.example.com", "token_url": "https://example.com/token"
    /// }`
    ///
    /// **SAML**
    ///
    /// Create or update request with Metadata URL: `"ProviderDetails": { "IDPInit":
    /// "true",
    /// "IDPSignout": "true", "EncryptedResponses" : "true", "MetadataURL":
    /// "https://auth.example.com/sso/saml/metadata", "RequestSigningAlgorithm":
    /// "rsa-sha256" }`
    ///
    /// Create or update request with Metadata file: `"ProviderDetails": {
    /// "IDPInit": "true",
    /// "IDPSignout": "true", "EncryptedResponses" : "true",
    /// "MetadataFile": "[metadata XML]", "RequestSigningAlgorithm":
    /// "rsa-sha256" }`
    ///
    /// The value of `MetadataFile` must be the plaintext metadata document with all
    /// quote (") characters escaped by backslashes.
    ///
    /// Describe response: `"ProviderDetails": { "IDPInit": "true",
    /// "IDPSignout": "true", "EncryptedResponses" : "true",
    /// "ActiveEncryptionCertificate": "[certificate]",
    /// "MetadataURL": "https://auth.example.com/sso/saml/metadata",
    /// "RequestSigningAlgorithm":
    /// "rsa-sha256", "SLORedirectBindingURI":
    /// "https://auth.example.com/slo/saml", "SSORedirectBindingURI":
    /// "https://auth.example.com/sso/saml" }`
    ///
    /// **LoginWithAmazon**
    ///
    /// Create or update request: `"ProviderDetails": { "authorize_scopes":
    /// "profile postal_code", "client_id":
    /// "amzn1.application-oa2-client.1example23456789", "client_secret":
    /// "provider-app-client-secret"`
    ///
    /// Describe response: `"ProviderDetails": { "attributes_url":
    /// "https://api.amazon.com/user/profile", "attributes_url_add_attributes":
    /// "false", "authorize_scopes": "profile postal_code", "authorize_url":
    /// "https://www.amazon.com/ap/oa", "client_id":
    /// "amzn1.application-oa2-client.1example23456789", "client_secret":
    /// "provider-app-client-secret", "token_request_method": "POST",
    /// "token_url": "https://api.amazon.com/auth/o2/token" }`
    ///
    /// **Google**
    ///
    /// Create or update request: `"ProviderDetails": { "authorize_scopes":
    /// "email profile openid", "client_id":
    /// "1example23456789.apps.googleusercontent.com", "client_secret":
    /// "provider-app-client-secret" }`
    ///
    /// Describe response: `"ProviderDetails": { "attributes_url":
    /// "https://people.googleapis.com/v1/people/me?personFields=",
    /// "attributes_url_add_attributes": "true", "authorize_scopes": "email
    /// profile openid", "authorize_url":
    /// "https://accounts.google.com/o/oauth2/v2/auth", "client_id":
    /// "1example23456789.apps.googleusercontent.com", "client_secret":
    /// "provider-app-client-secret", "oidc_issuer":
    /// "https://accounts.google.com", "token_request_method": "POST",
    /// "token_url": "https://www.googleapis.com/oauth2/v4/token"
    /// }`
    ///
    /// **SignInWithApple**
    ///
    /// Create or update request: `"ProviderDetails": { "authorize_scopes":
    /// "email name", "client_id": "com.example.cognito", "private_key": "1EXAMPLE",
    /// "key_id": "2EXAMPLE", "team_id": "3EXAMPLE" }`
    ///
    /// Describe response: `"ProviderDetails": {
    /// "attributes_url_add_attributes": "false", "authorize_scopes": "email
    /// name", "authorize_url": "https://appleid.apple.com/auth/authorize",
    /// "client_id": "com.example.cognito", "key_id": "1EXAMPLE", "oidc_issuer":
    /// "https://appleid.apple.com", "team_id": "2EXAMPLE",
    /// "token_request_method": "POST", "token_url":
    /// "https://appleid.apple.com/auth/token" }`
    ///
    /// **Facebook**
    ///
    /// Create or update request: `"ProviderDetails": { "api_version": "v17.0",
    /// "authorize_scopes": "public_profile, email", "client_id":
    /// "1example23456789",
    /// "client_secret": "provider-app-client-secret" }`
    ///
    /// Describe response: `"ProviderDetails":
    /// { "api_version": "v17.0", "attributes_url":
    /// "https://graph.facebook.com/v17.0/me?fields=",
    /// "attributes_url_add_attributes": "true", "authorize_scopes":
    /// "public_profile, email",
    /// "authorize_url": "https://www.facebook.com/v17.0/dialog/oauth", "client_id":
    /// "1example23456789", "client_secret": "provider-app-client-secret",
    /// "token_request_method":
    /// "GET", "token_url": "https://graph.facebook.com/v17.0/oauth/access_token" }`
    provider_details: []const aws.map.StringMapEntry,

    /// The name that you want to assign to the IdP. You can pass the identity
    /// provider name
    /// in the `identity_provider` query parameter of requests to the [Authorize
    /// endpoint](https://docs.aws.amazon.com/cognito/latest/developerguide/authorization-endpoint.html) to silently redirect to sign-in with the associated
    /// IdP.
    provider_name: []const u8,

    /// The type of IdP that you want to add. Amazon Cognito supports OIDC, SAML
    /// 2.0, Login With
    /// Amazon, Sign In With Apple, Google, and Facebook IdPs.
    provider_type: IdentityProviderTypeType,

    /// The Id of the user pool where you want to create an IdP.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .attribute_mapping = "AttributeMapping",
        .idp_identifiers = "IdpIdentifiers",
        .provider_details = "ProviderDetails",
        .provider_name = "ProviderName",
        .provider_type = "ProviderType",
        .user_pool_id = "UserPoolId",
    };
};

pub const CreateIdentityProviderOutput = struct {
    /// The details of the new user pool IdP.
    identity_provider: ?IdentityProviderType = null,

    pub const json_field_names = .{
        .identity_provider = "IdentityProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIdentityProviderInput, options: CallOptions) !CreateIdentityProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-idp", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIdentityProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-idp", "Cognito Identity Provider", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.CreateIdentityProvider");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIdentityProviderOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateIdentityProviderOutput, body, allocator);
}
