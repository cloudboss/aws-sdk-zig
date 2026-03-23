const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;
const ReasonCode = @import("reason_code.zig").ReasonCode;
const TaskStatus = @import("task_status.zig").TaskStatus;

pub const StartEngagementByAcceptingInvitationTaskInput = struct {
    /// Specifies the catalog related to the task. Use `AWS` for production
    /// engagements and `Sandbox` for testing scenarios.
    catalog: []const u8,

    /// A unique, case-sensitive identifier provided by the client that helps to
    /// ensure the idempotency of the request. This can be a random or meaningful
    /// string but must be unique for each request.
    client_token: []const u8,

    /// Specifies the unique identifier of the `EngagementInvitation` to be
    /// accepted. Providing the correct identifier helps ensure that the correct
    /// engagement is processed.
    identifier: []const u8,

    /// A map of the key-value pairs of the tag or tags to assign.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .identifier = "Identifier",
        .tags = "Tags",
    };
};

pub const StartEngagementByAcceptingInvitationTaskOutput = struct {
    /// Returns the identifier of the engagement invitation that was accepted and
    /// used to create the opportunity.
    engagement_invitation_id: ?[]const u8 = null,

    /// If the task fails, this field contains a detailed message describing the
    /// failure and possible recovery steps.
    message: ?[]const u8 = null,

    /// Returns the original opportunity identifier passed in the request. This is
    /// the unique identifier for the opportunity.
    opportunity_id: ?[]const u8 = null,

    /// Indicates the reason for task failure using an enumerated code.
    reason_code: ?ReasonCode = null,

    /// The identifier of the Resource Snapshot Job created as part of this task.
    resource_snapshot_job_id: ?[]const u8 = null,

    /// The timestamp indicating when the task was initiated. The format follows RFC
    /// 3339 section 5.6.
    start_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the task, used for tracking and managing
    /// the task within AWS.
    task_arn: ?[]const u8 = null,

    /// The unique identifier of the task, used to track the task’s progress.
    task_id: ?[]const u8 = null,

    /// Indicates the current status of the task.
    task_status: ?TaskStatus = null,

    pub const json_field_names = .{
        .engagement_invitation_id = "EngagementInvitationId",
        .message = "Message",
        .opportunity_id = "OpportunityId",
        .reason_code = "ReasonCode",
        .resource_snapshot_job_id = "ResourceSnapshotJobId",
        .start_time = "StartTime",
        .task_arn = "TaskArn",
        .task_id = "TaskId",
        .task_status = "TaskStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartEngagementByAcceptingInvitationTaskInput, options: CallOptions) !StartEngagementByAcceptingInvitationTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentral");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartEngagementByAcceptingInvitationTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.StartEngagementByAcceptingInvitationTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartEngagementByAcceptingInvitationTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartEngagementByAcceptingInvitationTaskOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
