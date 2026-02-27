const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AwsSubmission = @import("aws_submission.zig").AwsSubmission;
const Tag = @import("tag.zig").Tag;
const ReasonCode = @import("reason_code.zig").ReasonCode;
const TaskStatus = @import("task_status.zig").TaskStatus;

pub const StartEngagementFromOpportunityTaskInput = struct {
    aws_submission: AwsSubmission,

    /// Specifies the catalog in which the engagement is tracked. Acceptable values
    /// include `AWS` for production and `Sandbox` for testing environments.
    catalog: []const u8,

    /// A unique token provided by the client to help ensure the idempotency of the
    /// request. It helps prevent the same task from being performed multiple times.
    client_token: []const u8,

    /// The unique identifier of the opportunity from which the engagement task is
    /// to be initiated. This helps ensure that the task is applied to the correct
    /// opportunity.
    identifier: []const u8,

    /// A map of the key-value pairs of the tag or tags to assign.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aws_submission = "AwsSubmission",
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .identifier = "Identifier",
        .tags = "Tags",
    };
};

pub const StartEngagementFromOpportunityTaskOutput = struct {
    /// The identifier of the newly created Engagement. Only populated if TaskStatus
    /// is COMPLETE.
    engagement_id: ?[]const u8 = null,

    /// The identifier of the new Engagement invitation. Only populated if
    /// TaskStatus is COMPLETE.
    engagement_invitation_id: ?[]const u8 = null,

    /// If the task fails, this field contains a detailed message describing the
    /// failure and possible recovery steps.
    message: ?[]const u8 = null,

    /// Returns the original opportunity identifier passed in the request, which is
    /// the unique identifier for the opportunity created in the partner’s system.
    opportunity_id: ?[]const u8 = null,

    /// Indicates the reason for task failure using an enumerated code.
    reason_code: ?ReasonCode = null,

    /// The identifier of the resource snapshot job created to add the opportunity
    /// resource snapshot to the Engagement. Only populated if TaskStatus is
    /// COMPLETE
    resource_snapshot_job_id: ?[]const u8 = null,

    /// The timestamp indicating when the task was initiated. The format follows RFC
    /// 3339 section 5.6.
    start_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the task, used for tracking and managing
    /// the task within AWS.
    task_arn: ?[]const u8 = null,

    /// The unique identifier of the task, used to track the task’s progress. This
    /// value follows a specific pattern: `^oit-[0-9a-z]{13}$`.
    task_id: ?[]const u8 = null,

    /// Indicates the current status of the task. Valid values include
    /// `IN_PROGRESS`, `COMPLETE`, and `FAILED`.
    task_status: ?TaskStatus = null,

    pub const json_field_names = .{
        .engagement_id = "EngagementId",
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartEngagementFromOpportunityTaskInput, options: Options) !StartEngagementFromOpportunityTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "partnercentralselling");

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

fn serializeRequest(alloc: std.mem.Allocator, input: StartEngagementFromOpportunityTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentralselling", "PartnerCentral Selling", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AWSPartnerCentralSelling.StartEngagementFromOpportunityTask");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartEngagementFromOpportunityTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartEngagementFromOpportunityTaskOutput, body, alloc);
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
