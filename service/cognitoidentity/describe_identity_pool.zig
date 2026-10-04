const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CognitoIdentityProvider = @import("cognito_identity_provider.zig").CognitoIdentityProvider;

pub const DescribeIdentityPoolInput = struct {
    /// An identity pool ID in the format REGION:GUID.
    identity_pool_id: []const u8,

    pub const json_field_names = .{
        .identity_pool_id = "IdentityPoolId",
    };
};

pub const DescribeIdentityPoolOutput = struct {
    /// Enables or disables the Basic (Classic) authentication flow. For more
    /// information, see
    /// [Identity Pools (Federated Identities) Authentication
    /// Flow](https://docs.aws.amazon.com/cognito/latest/developerguide/authentication-flow.html) in the
    /// *Amazon Cognito Developer Guide*.
    allow_classic_flow: ?bool = null,

    /// TRUE if the identity pool supports unauthenticated logins.
    allow_unauthenticated_identities: ?bool = null,

    /// A list representing an Amazon Cognito user pool and its client ID.
    cognito_identity_providers: ?[]const CognitoIdentityProvider = null,

    /// The "domain" by which Cognito will refer to your users.
    developer_provider_name: ?[]const u8 = null,

    /// An identity pool ID in the format REGION:GUID.
    identity_pool_id: []const u8,

    /// A string that you provide.
    identity_pool_name: []const u8,

    /// The tags that are assigned to the identity pool. A tag is a label that you
    /// can apply to
    /// identity pools to categorize and manage them in different ways, such as by
    /// purpose, owner,
    /// environment, or other criteria.
    identity_pool_tags: ?[]const aws.map.StringMapEntry = null,

    /// The ARNs of the OpenID Connect providers.
    open_id_connect_provider_ar_ns: ?[]const []const u8 = null,

    /// An array of Amazon Resource Names (ARNs) of the SAML provider for your
    /// identity
    /// pool.
    saml_provider_ar_ns: ?[]const []const u8 = null,

    /// Optional key:value pairs mapping provider names to provider app IDs.
    supported_login_providers: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .allow_classic_flow = "AllowClassicFlow",
        .allow_unauthenticated_identities = "AllowUnauthenticatedIdentities",
        .cognito_identity_providers = "CognitoIdentityProviders",
        .developer_provider_name = "DeveloperProviderName",
        .identity_pool_id = "IdentityPoolId",
        .identity_pool_name = "IdentityPoolName",
        .identity_pool_tags = "IdentityPoolTags",
        .open_id_connect_provider_ar_ns = "OpenIdConnectProviderARNs",
        .saml_provider_ar_ns = "SamlProviderARNs",
        .supported_login_providers = "SupportedLoginProviders",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeIdentityPoolInput, options: CallOptions) !DescribeIdentityPoolOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-identity", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeIdentityPoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-identity", "Cognito Identity", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityService.DescribeIdentityPool");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeIdentityPoolOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeIdentityPoolOutput, body, allocator);
}
