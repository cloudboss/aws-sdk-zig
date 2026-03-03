const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConnectionAuthorizationType = @import("connection_authorization_type.zig").ConnectionAuthorizationType;
const ConnectionAuthResponseParameters = @import("connection_auth_response_parameters.zig").ConnectionAuthResponseParameters;
const ConnectionState = @import("connection_state.zig").ConnectionState;
const DescribeConnectionConnectivityParameters = @import("describe_connection_connectivity_parameters.zig").DescribeConnectionConnectivityParameters;

pub const DescribeConnectionInput = struct {
    /// The name of the connection to retrieve.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const DescribeConnectionOutput = struct {
    /// The type of authorization specified for the connection.
    authorization_type: ?ConnectionAuthorizationType = null,

    /// The parameters to use for authorization for the connection.
    auth_parameters: ?ConnectionAuthResponseParameters = null,

    /// The ARN of the connection retrieved.
    connection_arn: ?[]const u8 = null,

    /// The state of the connection retrieved.
    connection_state: ?ConnectionState = null,

    /// A time stamp for the time that the connection was created.
    creation_time: ?i64 = null,

    /// The description for the connection retrieved.
    description: ?[]const u8 = null,

    /// For connections to private APIs The parameters EventBridge uses to invoke
    /// the resource
    /// endpoint.
    ///
    /// For more information, see [Connecting to private
    /// APIs](https://docs.aws.amazon.com/eventbridge/latest/userguide/connection-private.html) in the *
    /// Amazon EventBridge User Guide*
    /// .
    invocation_connectivity_parameters: ?DescribeConnectionConnectivityParameters = null,

    /// The identifier of the KMS
    /// customer managed key for EventBridge to use to encrypt the connection, if
    /// one has been specified.
    ///
    /// For more information, see [Encrypting
    /// connections](https://docs.aws.amazon.com/eventbridge/latest/userguide/encryption-connections.html) in the *Amazon EventBridge User Guide*.
    kms_key_identifier: ?[]const u8 = null,

    /// A time stamp for the time that the connection was last authorized.
    last_authorized_time: ?i64 = null,

    /// A time stamp for the time that the connection was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the connection retrieved.
    name: ?[]const u8 = null,

    /// The ARN of the secret created from the authorization parameters specified
    /// for the
    /// connection.
    secret_arn: ?[]const u8 = null,

    /// The reason that the connection is in the current connection state.
    state_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorization_type = "AuthorizationType",
        .auth_parameters = "AuthParameters",
        .connection_arn = "ConnectionArn",
        .connection_state = "ConnectionState",
        .creation_time = "CreationTime",
        .description = "Description",
        .invocation_connectivity_parameters = "InvocationConnectivityParameters",
        .kms_key_identifier = "KmsKeyIdentifier",
        .last_authorized_time = "LastAuthorizedTime",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .secret_arn = "SecretArn",
        .state_reason = "StateReason",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeConnectionInput, options: Options) !DescribeConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "eventbridge");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eventbridge", "EventBridge", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSEvents.DescribeConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeConnectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeConnectionOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IllegalStatusException")) {
        return .{ .arena = arena, .kind = .{ .illegal_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEventPatternException")) {
        return .{ .arena = arena, .kind = .{ .invalid_event_pattern_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_state_exception = .{
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
    if (std.mem.eql(u8, error_code, "ManagedRuleException")) {
        return .{ .arena = arena, .kind = .{ .managed_rule_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationDisabledException")) {
        return .{ .arena = arena, .kind = .{ .operation_disabled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
