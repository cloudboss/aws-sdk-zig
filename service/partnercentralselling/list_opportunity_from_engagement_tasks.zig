const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ListTasksSortBase = @import("list_tasks_sort_base.zig").ListTasksSortBase;
const TaskStatus = @import("task_status.zig").TaskStatus;
const ListOpportunityFromEngagementTaskSummary = @import("list_opportunity_from_engagement_task_summary.zig").ListOpportunityFromEngagementTaskSummary;

pub const ListOpportunityFromEngagementTasksInput = struct {
    /// Specifies the catalog related to the request. Valid values are `AWS` for
    /// production environments and `Sandbox` for testing or development purposes.
    /// The catalog determines which environment the task data is retrieved from.
    catalog: []const u8,

    /// Filters tasks by the identifiers of the engagement contexts associated with
    /// the opportunity creation. Use this to find tasks related to specific
    /// contextual information within engagements that are being converted to
    /// opportunities.
    context_identifier: ?[]const []const u8 = null,

    /// Filters tasks by the identifiers of the engagements from which opportunities
    /// are being created. Use this to find all opportunity creation tasks
    /// associated with a specific engagement.
    engagement_identifier: ?[]const []const u8 = null,

    /// Specifies the maximum number of results to return in a single page of the
    /// response. Use this parameter to control the number of items returned in each
    /// request, which can be useful for performance tuning and managing large
    /// result sets.
    max_results: ?i32 = null,

    /// The token for requesting the next page of results. This value is obtained
    /// from the NextToken field in the response of a previous call to this API. Use
    /// this parameter for pagination when the result set spans multiple pages.
    next_token: ?[]const u8 = null,

    /// Filters tasks by the identifiers of the opportunities they created or are
    /// associated with. Use this to find tasks related to specific opportunity
    /// creation processes.
    opportunity_identifier: ?[]const []const u8 = null,

    sort: ?ListTasksSortBase = null,

    /// Filters tasks by their unique identifiers. Use this when you want to
    /// retrieve information about specific tasks. Provide the task ID to get
    /// details about a particular opportunity creation task.
    task_identifier: ?[]const []const u8 = null,

    /// Filters the tasks based on their current status. This allows you to focus on
    /// tasks in specific states. Valid values are `COMPLETE` for tasks that have
    /// finished successfully, `INPROGRESS` for tasks that are currently running,
    /// and `FAILED` for tasks that have encountered an error and failed to
    /// complete.
    task_status: ?[]const TaskStatus = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .context_identifier = "ContextIdentifier",
        .engagement_identifier = "EngagementIdentifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .opportunity_identifier = "OpportunityIdentifier",
        .sort = "Sort",
        .task_identifier = "TaskIdentifier",
        .task_status = "TaskStatus",
    };
};

pub const ListOpportunityFromEngagementTasksOutput = struct {
    /// A token used for pagination to retrieve the next page of results. If there
    /// are more results available, this field will contain a token that can be used
    /// in a subsequent API call to retrieve the next page. If there are no more
    /// results, this field will be null or an empty string.
    next_token: ?[]const u8 = null,

    /// An array of `ListOpportunityFromEngagementTaskSummary` objects, each
    /// representing a task that matches the specified filters. The array may be
    /// empty if no tasks match the criteria.
    task_summaries: ?[]const ListOpportunityFromEngagementTaskSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .task_summaries = "TaskSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOpportunityFromEngagementTasksInput, options: CallOptions) !ListOpportunityFromEngagementTasksOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOpportunityFromEngagementTasksInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.ListOpportunityFromEngagementTasks");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOpportunityFromEngagementTasksOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListOpportunityFromEngagementTasksOutput, body, allocator);
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
