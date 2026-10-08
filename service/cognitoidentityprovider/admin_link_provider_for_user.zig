const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProviderUserIdentifierType = @import("provider_user_identifier_type.zig").ProviderUserIdentifierType;

pub const AdminLinkProviderForUserInput = struct {
    /// The existing user in the user pool that you want to assign to the external
    /// IdP user
    /// account. This user can be a local (Username + Password) Amazon Cognito user
    /// pools user or a
    /// federated user (for example, a SAML or Facebook user). If the user doesn't
    /// exist, Amazon Cognito
    /// generates an exception. Amazon Cognito returns this user when the new user
    /// (with the linked IdP
    /// attribute) signs in.
    ///
    /// For a native username + password user, the `ProviderAttributeValue` for the
    /// `DestinationUser` should be the username in the user pool. For a
    /// federated user, it should be the provider-specific `user_id`.
    ///
    /// The `ProviderAttributeName` of the `DestinationUser` is
    /// ignored.
    ///
    /// The `ProviderName` should be set to `Cognito` for users in
    /// Cognito user pools.
    destination_user: ProviderUserIdentifierType,

    /// An external IdP account for a user who doesn't exist yet in the user pool.
    /// This user
    /// must be a federated user (for example, a SAML or Facebook user), not another
    /// native
    /// user.
    ///
    /// If the `SourceUser` is using a federated social IdP, such as Facebook,
    /// Google, or Login with Amazon, you must set the `ProviderAttributeName` to
    /// `Cognito_Subject`. For social IdPs, the `ProviderName` will be
    /// `Facebook`, `Google`, or `LoginWithAmazon`, and
    /// Amazon Cognito will automatically parse the Facebook, Google, and Login with
    /// Amazon tokens for
    /// `id`, `sub`, and `user_id`, respectively. The
    /// `ProviderAttributeValue` for the user must be the same value as the
    /// `id`, `sub`, or `user_id` value found in the social
    /// IdP token.
    ///
    /// For OIDC, the `ProviderAttributeName` can be any mapped value from a claim
    /// in the ID token, or that your app retrieves from the `userInfo` endpoint.
    /// For
    /// SAML, the `ProviderAttributeName` can be any mapped value from a claim in
    /// the
    /// SAML assertion.
    ///
    /// The following additional considerations apply to `SourceUser` for OIDC and
    /// SAML providers.
    ///
    /// * You must map the claim to a user pool attribute in your IdP configuration,
    ///   and
    /// set the user pool attribute name as the value of
    /// `ProviderAttributeName` in your
    /// `AdminLinkProviderForUser` request. For example,
    /// `email`.
    ///
    /// * When you set `ProviderAttributeName` to
    /// `Cognito_Subject`, Amazon Cognito will automatically parse the default
    /// unique identifier found in the subject from the IdP token.
    source_user: ProviderUserIdentifierType,

    /// The ID of the user pool where you want to link a federated identity.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .destination_user = "DestinationUser",
        .source_user = "SourceUser",
        .user_pool_id = "UserPoolId",
    };
};

pub const AdminLinkProviderForUserOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AdminLinkProviderForUserInput, options: CallOptions) !AdminLinkProviderForUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AdminLinkProviderForUserInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityProviderService.AdminLinkProviderForUser");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AdminLinkProviderForUserOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
