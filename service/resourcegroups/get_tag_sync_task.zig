const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ResourceQuery = @import("resource_query.zig").ResourceQuery;
const TagSyncTaskStatus = @import("tag_sync_task_status.zig").TagSyncTaskStatus;

pub const GetTagSyncTaskInput = struct {
    /// The Amazon resource name (ARN) of the tag-sync task.
    task_arn: []const u8,

    pub const json_field_names = .{
        .task_arn = "TaskArn",
    };
};

pub const GetTagSyncTaskOutput = struct {
    /// The timestamp of when the tag-sync task was created.
    created_at: ?i64 = null,

    /// The specific error message in cases where the tag-sync task status
    /// is `ERROR`.
    error_message: ?[]const u8 = null,

    /// The Amazon resource name (ARN) of the application group.
    group_arn: ?[]const u8 = null,

    /// The name of the application group.
    group_name: ?[]const u8 = null,

    resource_query: ?ResourceQuery = null,

    /// The Amazon resource name (ARN) of the role assumed by Resource Groups to tag
    /// and untag resources on your behalf.
    ///
    /// For more information about this role, review [Tag-sync required
    /// permissions](https://docs.aws.amazon.com/servicecatalog/latest/arguide/app-tag-sync.html#tag-sync-role).
    role_arn: ?[]const u8 = null,

    /// The status of the tag-sync task.
    ///
    /// Valid values include:
    ///
    /// * `ACTIVE` - The tag-sync task is actively managing resources in
    /// the application by adding or removing the `awsApplication` tag from
    /// resources
    /// when they are tagged or untagged with the specified tag key-value pair.
    ///
    /// * `ERROR` - The tag-sync task is not actively managing resources
    /// in the application. Review the `ErrorMessage` for more information about
    /// resolving the error.
    status: ?TagSyncTaskStatus = null,

    /// The tag key.
    tag_key: ?[]const u8 = null,

    /// The tag value.
    tag_value: ?[]const u8 = null,

    /// The Amazon resource name (ARN) of the tag-sync task.
    task_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .error_message = "ErrorMessage",
        .group_arn = "GroupArn",
        .group_name = "GroupName",
        .resource_query = "ResourceQuery",
        .role_arn = "RoleArn",
        .status = "Status",
        .tag_key = "TagKey",
        .tag_value = "TagValue",
        .task_arn = "TaskArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTagSyncTaskInput, options: CallOptions) !GetTagSyncTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "resource-groups");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTagSyncTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-groups", "Resource Groups", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/get-tag-sync-task";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TaskArn\":");
    try aws.json.writeValue(@TypeOf(input.task_arn), input.task_arn, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTagSyncTaskOutput {
    var result: GetTagSyncTaskOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTagSyncTaskOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MethodNotAllowedException")) {
        return .{ .arena = arena, .kind = .{ .method_not_allowed_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
