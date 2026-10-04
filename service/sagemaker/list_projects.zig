const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProjectSortBy = @import("project_sort_by.zig").ProjectSortBy;
const ProjectSortOrder = @import("project_sort_order.zig").ProjectSortOrder;
const ProjectSummary = @import("project_summary.zig").ProjectSummary;

pub const ListProjectsInput = struct {
    /// A filter that returns the projects that were created after a specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns the projects that were created before a specified
    /// time.
    creation_time_before: ?i64 = null,

    /// The maximum number of projects to return in the response.
    max_results: ?i32 = null,

    /// A filter that returns the projects whose name contains a specified string.
    name_contains: ?[]const u8 = null,

    /// If the result of the previous `ListProjects` request was truncated, the
    /// response includes a `NextToken`. To retrieve the next set of projects, use
    /// the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field by which to sort results. The default is `CreationTime`.
    sort_by: ?ProjectSortBy = null,

    /// The sort order for results. The default is `Ascending`.
    sort_order: ?ProjectSortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListProjectsOutput = struct {
    /// If the result of the previous `ListCompilationJobs` request was truncated,
    /// the response includes a `NextToken`. To retrieve the next set of model
    /// compilation jobs, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// A list of summaries of projects.
    project_summary_list: ?[]const ProjectSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .project_summary_list = "ProjectSummaryList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProjectsInput, options: CallOptions) !ListProjectsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProjectsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListProjects");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProjectsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListProjectsOutput, body, allocator);
}
