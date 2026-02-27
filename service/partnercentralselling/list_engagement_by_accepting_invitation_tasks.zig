const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ListTasksSortBase = @import("list_tasks_sort_base.zig").ListTasksSortBase;
const TaskStatus = @import("task_status.zig").TaskStatus;
const ListEngagementByAcceptingInvitationTaskSummary = @import("list_engagement_by_accepting_invitation_task_summary.zig").ListEngagementByAcceptingInvitationTaskSummary;

pub const ListEngagementByAcceptingInvitationTasksInput = struct {
    /// Specifies the catalog related to the request. Valid values are:
    ///
    /// * AWS: Retrieves the request from the production AWS environment.
    /// * Sandbox: Retrieves the request from a sandbox environment used for testing
    ///   or development purposes.
    catalog: []const u8,

    /// Filters tasks by the identifiers of the engagement invitations they are
    /// processing.
    engagement_invitation_identifier: ?[]const []const u8 = null,

    /// Use this parameter to control the number of items returned in each request,
    /// which can be useful for performance tuning and managing large result sets.
    max_results: ?i32 = null,

    /// Use this parameter for pagination when the result set spans multiple pages.
    /// This value is obtained from the NextToken field in the response of a
    /// previous call to this API.
    next_token: ?[]const u8 = null,

    /// Filters tasks by the identifiers of the opportunities they created or are
    /// associated with.
    opportunity_identifier: ?[]const []const u8 = null,

    /// Specifies the sorting criteria for the returned results. This allows you to
    /// order the tasks based on specific attributes.
    sort: ?ListTasksSortBase = null,

    /// Filters tasks by their unique identifiers. Use this when you want to
    /// retrieve information about specific tasks.
    task_identifier: ?[]const []const u8 = null,

    /// Filters the tasks based on their current status. This allows you to focus on
    /// tasks in specific states.
    task_status: ?[]const TaskStatus = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .engagement_invitation_identifier = "EngagementInvitationIdentifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .opportunity_identifier = "OpportunityIdentifier",
        .sort = "Sort",
        .task_identifier = "TaskIdentifier",
        .task_status = "TaskStatus",
    };
};

pub const ListEngagementByAcceptingInvitationTasksOutput = struct {
    /// A token used for pagination to retrieve the next page of results.If there
    /// are more results available, this field will contain a token that can be used
    /// in a subsequent API call to retrieve the next page. If there are no more
    /// results, this field will be null or an empty string.
    next_token: ?[]const u8 = null,

    /// An array of `EngagementByAcceptingInvitationTaskSummary` objects, each
    /// representing a task that matches the specified filters. The array may be
    /// empty if no tasks match the criteria.
    task_summaries: ?[]const ListEngagementByAcceptingInvitationTaskSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .task_summaries = "TaskSummaries",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEngagementByAcceptingInvitationTasksInput, options: Options) !ListEngagementByAcceptingInvitationTasksOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ListEngagementByAcceptingInvitationTasksInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AWSPartnerCentralSelling.ListEngagementByAcceptingInvitationTasks");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListEngagementByAcceptingInvitationTasksOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListEngagementByAcceptingInvitationTasksOutput, body, alloc);
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
