const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskRunFilterCriteria = @import("task_run_filter_criteria.zig").TaskRunFilterCriteria;
const TaskRunSortCriteria = @import("task_run_sort_criteria.zig").TaskRunSortCriteria;
const TaskRun = @import("task_run.zig").TaskRun;

pub const GetMLTaskRunsInput = struct {
    /// The filter criteria, in the `TaskRunFilterCriteria` structure, for the task
    /// run.
    filter: ?TaskRunFilterCriteria = null,

    /// The maximum number of results to return.
    max_results: ?i32 = null,

    /// A token for pagination of the results. The default is empty.
    next_token: ?[]const u8 = null,

    /// The sorting criteria, in the `TaskRunSortCriteria` structure, for the task
    /// run.
    sort: ?TaskRunSortCriteria = null,

    /// The unique identifier of the machine learning transform.
    transform_id: []const u8,

    pub const json_field_names = .{
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort = "Sort",
        .transform_id = "TransformId",
    };
};

pub const GetMLTaskRunsOutput = struct {
    /// A pagination token, if more results are available.
    next_token: ?[]const u8 = null,

    /// A list of task runs that are associated with the transform.
    task_runs: ?[]const TaskRun = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .task_runs = "TaskRuns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMLTaskRunsInput, options: CallOptions) !GetMLTaskRunsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMLTaskRunsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetMLTaskRuns");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMLTaskRunsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetMLTaskRunsOutput, body, allocator);
}
