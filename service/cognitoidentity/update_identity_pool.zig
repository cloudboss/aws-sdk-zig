const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CognitoIdentityProvider = @import("cognito_identity_provider.zig").CognitoIdentityProvider;

pub const UpdateIdentityPoolInput = struct {
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

pub const UpdateIdentityPoolOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIdentityPoolInput, options: CallOptions) !UpdateIdentityPoolOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cognito-identity");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIdentityPoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-identity", "Cognito Identity", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityService.UpdateIdentityPool");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIdentityPoolOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateIdentityPoolOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DeveloperUserAlreadyRegisteredException")) {
        return .{ .arena = arena, .kind = .{ .developer_user_already_registered_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .external_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidIdentityPoolConfigurationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_identity_pool_configuration_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .arena = arena, .kind = .{ .resource_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
