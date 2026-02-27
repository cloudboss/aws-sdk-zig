const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const LookupDeveloperIdentityInput = struct {
    /// A unique ID used by your backend authentication process to identify a user.
    /// Typically, a developer identity provider would issue many developer user
    /// identifiers, in
    /// keeping with the number of users.
    developer_user_identifier: ?[]const u8 = null,

    /// A unique identifier in the format REGION:GUID.
    identity_id: ?[]const u8 = null,

    /// An identity pool ID in the format REGION:GUID.
    identity_pool_id: []const u8,

    /// The maximum number of identities to return.
    max_results: ?i32 = null,

    /// A pagination token. The first call you make will have `NextToken` set to
    /// null. After that the service will return `NextToken` values as needed. For
    /// example, let's say you make a request with `MaxResults` set to 10, and there
    /// are
    /// 20 matches in the database. The service will return a pagination token as a
    /// part of the
    /// response. This token can be used to call the API again and get results
    /// starting from the
    /// 11th match.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .developer_user_identifier = "DeveloperUserIdentifier",
        .identity_id = "IdentityId",
        .identity_pool_id = "IdentityPoolId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const LookupDeveloperIdentityOutput = struct {
    /// This is the list of developer user identifiers associated with an identity
    /// ID.
    /// Cognito supports the association of multiple developer user identifiers with
    /// an identity
    /// ID.
    developer_user_identifier_list: ?[]const []const u8 = null,

    /// A unique identifier in the format REGION:GUID.
    identity_id: ?[]const u8 = null,

    /// A pagination token. The first call you make will have `NextToken` set to
    /// null. After that the service will return `NextToken` values as needed. For
    /// example, let's say you make a request with `MaxResults` set to 10, and there
    /// are
    /// 20 matches in the database. The service will return a pagination token as a
    /// part of the
    /// response. This token can be used to call the API again and get results
    /// starting from the
    /// 11th match.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .developer_user_identifier_list = "DeveloperUserIdentifierList",
        .identity_id = "IdentityId",
        .next_token = "NextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: LookupDeveloperIdentityInput, options: Options) !LookupDeveloperIdentityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cognitoidentity");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: LookupDeveloperIdentityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognitoidentity", "Cognito Identity", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AWSCognitoIdentityService.LookupDeveloperIdentity");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !LookupDeveloperIdentityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(LookupDeveloperIdentityOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
