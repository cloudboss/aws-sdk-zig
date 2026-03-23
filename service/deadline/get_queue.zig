const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const QueueBlockedReason = @import("queue_blocked_reason.zig").QueueBlockedReason;
const DefaultQueueBudgetAction = @import("default_queue_budget_action.zig").DefaultQueueBudgetAction;
const JobAttachmentSettings = @import("job_attachment_settings.zig").JobAttachmentSettings;
const JobRunAsUser = @import("job_run_as_user.zig").JobRunAsUser;
const QueueStatus = @import("queue_status.zig").QueueStatus;

pub const GetQueueInput = struct {
    /// The farm ID of the farm in the queue.
    farm_id: []const u8,

    /// The queue ID for the queue to retrieve.
    queue_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .queue_id = "queueId",
    };
};

pub const GetQueueOutput = struct {
    /// The storage profile IDs for the queue.
    allowed_storage_profile_ids: ?[]const []const u8 = null,

    /// The reason the queue was blocked.
    blocked_reason: ?QueueBlockedReason = null,

    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The default action taken on a queue if a budget wasn't configured.
    default_budget_action: DefaultQueueBudgetAction,

    /// The description of the queue.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    description: ?[]const u8 = null,

    /// The display name of the queue.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    display_name: []const u8,

    /// The farm ID for the queue.
    farm_id: []const u8,

    /// The job attachment settings for the queue.
    job_attachment_settings: ?JobAttachmentSettings = null,

    /// The jobs in the queue ran as this specified POSIX user.
    job_run_as_user: ?JobRunAsUser = null,

    /// The queue ID.
    queue_id: []const u8,

    /// A list of the required file system location names in the queue.
    required_file_system_location_names: ?[]const []const u8 = null,

    /// The IAM role ARN.
    role_arn: ?[]const u8 = null,

    /// The status of the queue.
    ///
    /// * `ACTIVE`–The queue is active.
    /// * `SCHEDULING`–The queue is scheduling.
    /// * `SCHEDULING_BLOCKED`–The queue scheduling is blocked. See the provided
    ///   reason.
    status: QueueStatus,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .allowed_storage_profile_ids = "allowedStorageProfileIds",
        .blocked_reason = "blockedReason",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .default_budget_action = "defaultBudgetAction",
        .description = "description",
        .display_name = "displayName",
        .farm_id = "farmId",
        .job_attachment_settings = "jobAttachmentSettings",
        .job_run_as_user = "jobRunAsUser",
        .queue_id = "queueId",
        .required_file_system_location_names = "requiredFileSystemLocationNames",
        .role_arn = "roleArn",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQueueInput, options: CallOptions) !GetQueueOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "deadline");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQueueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/queues/");
    try path_buf.appendSlice(allocator, input.queue_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQueueOutput {
    var result: GetQueueOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetQueueOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
