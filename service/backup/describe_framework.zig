const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FrameworkControl = @import("framework_control.zig").FrameworkControl;

pub const DescribeFrameworkInput = struct {
    /// The unique name of a framework.
    framework_name: []const u8,

    pub const json_field_names = .{
        .framework_name = "FrameworkName",
    };
};

pub const DescribeFrameworkOutput = struct {
    /// The date and time that a framework is created, in ISO 8601 representation.
    /// The value of `CreationTime` is accurate to milliseconds. For example,
    /// 2020-07-10T15:00:00.000-08:00 represents the 10th of July 2020 at 3:00 PM 8
    /// hours behind
    /// UTC.
    creation_time: ?i64 = null,

    /// The deployment status of a framework. The statuses are:
    ///
    /// `CREATE_IN_PROGRESS | UPDATE_IN_PROGRESS | DELETE_IN_PROGRESS | COMPLETED |
    /// FAILED`
    deployment_status: ?[]const u8 = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
    /// format of the ARN
    /// depends on the resource type.
    framework_arn: ?[]const u8 = null,

    /// The controls that make up the framework. Each control in the list has a
    /// name,
    /// input parameters, and scope.
    framework_controls: ?[]const FrameworkControl = null,

    /// An optional description of the framework.
    framework_description: ?[]const u8 = null,

    /// The unique name of a framework.
    framework_name: ?[]const u8 = null,

    /// A framework consists of one or more controls. Each control governs a
    /// resource, such as
    /// backup plans, backup selections, backup vaults, or recovery points. You can
    /// also turn
    /// Config recording on or off for each resource. The statuses are:
    ///
    /// * `ACTIVE` when recording is turned on for all resources governed by the
    /// framework.
    ///
    /// * `PARTIALLY_ACTIVE` when recording is turned off for at least one
    /// resource governed by the framework.
    ///
    /// * `INACTIVE` when recording is turned off for all resources governed by
    /// the framework.
    ///
    /// * `UNAVAILABLE` when Backup is unable to validate recording
    /// status at this time.
    framework_status: ?[]const u8 = null,

    /// A customer-chosen string that you can use to distinguish between otherwise
    /// identical
    /// calls to `DescribeFrameworkOutput`. Retrying a successful request with the
    /// same
    /// idempotency token results in a success message with no action taken.
    idempotency_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .deployment_status = "DeploymentStatus",
        .framework_arn = "FrameworkArn",
        .framework_controls = "FrameworkControls",
        .framework_description = "FrameworkDescription",
        .framework_name = "FrameworkName",
        .framework_status = "FrameworkStatus",
        .idempotency_token = "IdempotencyToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFrameworkInput, options: CallOptions) !DescribeFrameworkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "backup");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFrameworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/audit/frameworks/");
    try path_buf.appendSlice(allocator, input.framework_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFrameworkOutput {
    var result: DescribeFrameworkOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeFrameworkOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependencyFailureException")) {
        return .{ .arena = arena, .kind = .{ .dependency_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_exception = .{
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
    if (std.mem.eql(u8, error_code, "MissingParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .missing_parameter_value_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
