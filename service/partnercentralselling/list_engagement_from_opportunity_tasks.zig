const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListTasksSortBase = @import("list_tasks_sort_base.zig").ListTasksSortBase;
const TaskStatus = @import("task_status.zig").TaskStatus;
const ListEngagementFromOpportunityTaskSummary = @import("list_engagement_from_opportunity_task_summary.zig").ListEngagementFromOpportunityTaskSummary;

pub const ListEngagementFromOpportunityTasksInput = struct {
    /// Specifies the catalog related to the request. Valid values are:
    ///
    /// * AWS: Retrieves the request from the production AWS environment.
    /// * Sandbox: Retrieves the request from a sandbox environment used for testing
    ///   or development purposes.
    catalog: []const u8,

    /// Filters tasks by the identifiers of the engagements they created or are
    /// associated with.
    engagement_identifier: ?[]const []const u8 = null,

    /// Specifies the maximum number of results to return in a single page of the
    /// response.Use this parameter to control the number of items returned in each
    /// request, which can be useful for performance tuning and managing large
    /// result sets.
    max_results: ?i32 = null,

    /// The token for requesting the next page of results. This value is obtained
    /// from the NextToken field in the response of a previous call to this API. Use
    /// this parameter for pagination when the result set spans multiple pages.
    next_token: ?[]const u8 = null,

    /// The identifier of the original opportunity associated with this task.
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
        .engagement_identifier = "EngagementIdentifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .opportunity_identifier = "OpportunityIdentifier",
        .sort = "Sort",
        .task_identifier = "TaskIdentifier",
        .task_status = "TaskStatus",
    };
};

pub const ListEngagementFromOpportunityTasksOutput = struct {
    /// A token used for pagination to retrieve the next page of results. If there
    /// are more results available, this field will contain a token that can be used
    /// in a subsequent API call to retrieve the next page. If there are no more
    /// results, this field will be null or an empty string.
    next_token: ?[]const u8 = null,

    /// TaskSummaries An array of TaskSummary objects containing details about each
    /// task.
    task_summaries: ?[]const ListEngagementFromOpportunityTaskSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .task_summaries = "TaskSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEngagementFromOpportunityTasksInput, options: CallOptions) !ListEngagementFromOpportunityTasksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListEngagementFromOpportunityTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.ListEngagementFromOpportunityTasks");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEngagementFromOpportunityTasksOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListEngagementFromOpportunityTasksOutput, body, allocator);
}
