const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProspectingFromEngagementTaskSort = @import("prospecting_from_engagement_task_sort.zig").ProspectingFromEngagementTaskSort;
const ProspectingTaskSummary = @import("prospecting_task_summary.zig").ProspectingTaskSummary;

pub const ListProspectingFromEngagementTasksInput = struct {
    /// Specifies the catalog to list tasks from. Specify `AWS` for production
    /// environments and `Sandbox` for testing and development purposes.
    catalog: []const u8,

    /// The maximum number of results to return in a single page. If additional
    /// results exist, the response includes a `NextToken` value for retrieving the
    /// next page. If omitted, the API uses a service-defined default page size.
    max_results: ?i32 = null,

    /// The pagination token from a previous call to this API. Include this value to
    /// retrieve the next page of results. If omitted, the first page is returned.
    next_token: ?[]const u8 = null,

    /// Specifies the field and order used to sort the returned tasks. If omitted,
    /// tasks are returned in the default sort order.
    sort: ?ProspectingFromEngagementTaskSort = null,

    /// Filters tasks to include only those that started after the specified
    /// timestamp. Use this with `StartBefore` to define a start-time range for your
    /// query. The format follows ISO 8601 date-time notation.
    start_after: ?i64 = null,

    /// Filters tasks to include only those that started before the specified
    /// timestamp. Use this with `StartAfter` to define a start-time range for your
    /// query. The format follows ISO 8601 date-time notation.
    start_before: ?i64 = null,

    /// Filters the results to include only the tasks with the specified
    /// identifiers. Provide up to 10 task IDs to narrow the list to specific tasks.
    /// If omitted, tasks are not filtered by identifier.
    task_identifier: ?[]const []const u8 = null,

    /// Filters the results to include only tasks with the specified names. Provide
    /// up to 10 task names to narrow the list. If omitted, tasks are not filtered
    /// by name.
    task_name: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort = "Sort",
        .start_after = "StartAfter",
        .start_before = "StartBefore",
        .task_identifier = "TaskIdentifier",
        .task_name = "TaskName",
    };
};

pub const ListProspectingFromEngagementTasksOutput = struct {
    /// A pagination token used to retrieve the next page of results. If this field
    /// is present, pass its value as `NextToken` in the next call. If absent or
    /// empty, there are no further pages.
    next_token: ?[]const u8 = null,

    /// Prospecting task summaries matching the specified filters. Each summary
    /// includes the task identifier, name, status counters, and timing information.
    /// If no tasks match the filter criteria, the list is empty.
    task_summaries: ?[]const ProspectingTaskSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .task_summaries = "TaskSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProspectingFromEngagementTasksInput, options: CallOptions) !ListProspectingFromEngagementTasksOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProspectingFromEngagementTasksInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.ListProspectingFromEngagementTasks");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProspectingFromEngagementTasksOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListProspectingFromEngagementTasksOutput, body, allocator);
}
