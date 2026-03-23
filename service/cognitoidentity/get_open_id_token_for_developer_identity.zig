const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const GetOpenIdTokenForDeveloperIdentityInput = struct {
    /// A unique identifier in the format REGION:GUID.
    identity_id: ?[]const u8 = null,

    /// An identity pool ID in the format REGION:GUID.
    identity_pool_id: []const u8,

    /// A set of optional name-value pairs that map provider names to provider
    /// tokens. Each
    /// name-value pair represents a user from a public provider or developer
    /// provider. If the user
    /// is from a developer provider, the name-value pair will follow the syntax
    /// `"developer_provider_name": "developer_user_identifier"`. The developer
    /// provider is the "domain" by which Cognito will refer to your users; you
    /// provided this
    /// domain while creating/updating the identity pool. The developer user
    /// identifier is an
    /// identifier from your backend that uniquely identifies a user. When you
    /// create an identity
    /// pool, you can specify the supported logins.
    logins: []const aws.map.StringMapEntry,

    /// Use this operation to configure attribute mappings for custom providers.
    principal_tags: ?[]const aws.map.StringMapEntry = null,

    /// The expiration time of the token, in seconds. You can specify a custom
    /// expiration
    /// time for the token so that you can cache it. If you don't provide an
    /// expiration time, the
    /// token is valid for 15 minutes. You can exchange the token with Amazon STS
    /// for temporary
    /// Amazon Web Services credentials, which are valid for a maximum of one hour.
    /// The maximum
    /// token duration you can set is 24 hours. You should take care in setting the
    /// expiration time
    /// for a token, as there are significant security implications: an attacker
    /// could use a leaked
    /// token to access your Amazon Web Services resources for the token's duration.
    ///
    /// Please provide for a small grace period, usually no more than 5 minutes, to
    /// account for clock skew.
    token_duration: ?i64 = null,

    pub const json_field_names = .{
        .identity_id = "IdentityId",
        .identity_pool_id = "IdentityPoolId",
        .logins = "Logins",
        .principal_tags = "PrincipalTags",
        .token_duration = "TokenDuration",
    };
};

pub const GetOpenIdTokenForDeveloperIdentityOutput = struct {
    /// A unique identifier in the format REGION:GUID.
    identity_id: ?[]const u8 = null,

    /// An OpenID token.
    token: ?[]const u8 = null,

    pub const json_field_names = .{
        .identity_id = "IdentityId",
        .token = "Token",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOpenIdTokenForDeveloperIdentityInput, options: CallOptions) !GetOpenIdTokenForDeveloperIdentityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOpenIdTokenForDeveloperIdentityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSCognitoIdentityService.GetOpenIdTokenForDeveloperIdentity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOpenIdTokenForDeveloperIdentityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetOpenIdTokenForDeveloperIdentityOutput, body, allocator);
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
