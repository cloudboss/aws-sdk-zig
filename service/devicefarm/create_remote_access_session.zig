const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CreateRemoteAccessSessionConfiguration = @import("create_remote_access_session_configuration.zig").CreateRemoteAccessSessionConfiguration;
const InteractionMode = @import("interaction_mode.zig").InteractionMode;
const RemoteAccessSession = @import("remote_access_session.zig").RemoteAccessSession;

pub const CreateRemoteAccessSessionInput = struct {
    /// The Amazon Resource Name (ARN) of the app to create the remote access
    /// session.
    app_arn: ?[]const u8 = null,

    /// The configuration information for the remote access session request.
    configuration: ?CreateRemoteAccessSessionConfiguration = null,

    /// The ARN of the device for which you want to create a remote access session.
    device_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the device instance for which you want to
    /// create a
    /// remote access session.
    instance_arn: ?[]const u8 = null,

    /// The interaction mode of the remote access session. Changing the interactive
    /// mode of remote access sessions is no longer available.
    interaction_mode: ?InteractionMode = null,

    /// The name of the remote access session to create.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the project for which you want to create a
    /// remote
    /// access session.
    project_arn: []const u8,

    /// When set to `true`, for private devices, Device Farm does not sign your app
    /// again. For public
    /// devices, Device Farm always signs your apps again.
    ///
    /// For more information on how Device Farm modifies your uploads during tests,
    /// see [Do you modify my app?](http://aws.amazon.com/device-farm/faqs/)
    skip_app_resign: ?bool = null,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .configuration = "configuration",
        .device_arn = "deviceArn",
        .instance_arn = "instanceArn",
        .interaction_mode = "interactionMode",
        .name = "name",
        .project_arn = "projectArn",
        .skip_app_resign = "skipAppResign",
    };
};

pub const CreateRemoteAccessSessionOutput = struct {
    /// A container that describes the remote access session when the request to
    /// create a
    /// remote access session is sent.
    remote_access_session: ?RemoteAccessSession = null,

    pub const json_field_names = .{
        .remote_access_session = "remoteAccessSession",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRemoteAccessSessionInput, options: CallOptions) !CreateRemoteAccessSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "devicefarm");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRemoteAccessSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.CreateRemoteAccessSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRemoteAccessSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRemoteAccessSessionOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ArgumentException")) {
        return .{ .arena = arena, .kind = .{ .argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CannotDeleteException")) {
        return .{ .arena = arena, .kind = .{ .cannot_delete_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyException")) {
        return .{ .arena = arena, .kind = .{ .idempotency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotEligibleException")) {
        return .{ .arena = arena, .kind = .{ .not_eligible_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceAccountException")) {
        return .{ .arena = arena, .kind = .{ .service_account_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagOperationException")) {
        return .{ .arena = arena, .kind = .{ .tag_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TagPolicyException")) {
        return .{ .arena = arena, .kind = .{ .tag_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
