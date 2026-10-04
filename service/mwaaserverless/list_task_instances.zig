const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskInstanceSummary = @import("task_instance_summary.zig").TaskInstanceSummary;

pub const ListTaskInstancesInput = struct {
    /// The maximum number of task instances to return in a single response.
    max_results: ?i32 = null,

    /// The pagination token you need to use to retrieve the next set of results.
    /// This value is returned from a previous call to `ListTaskInstances`.
    next_token: ?[]const u8 = null,

    /// The unique identifier of the workflow run for which you want a list of task
    /// instances.
    run_id: []const u8,

    /// The Amazon Resource Name (ARN) of the workflow that contains the run.
    workflow_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .run_id = "RunId",
        .workflow_arn = "WorkflowArn",
    };
};

pub const ListTaskInstancesOutput = struct {
    /// The pagination token you need to use to retrieve the next set of results.
    /// This value is null if there are no more results.
    next_token: ?[]const u8 = null,

    /// A list of task instance summaries for the specified workflow run.
    task_instances: ?[]const TaskInstanceSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .task_instances = "TaskInstances",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTaskInstancesInput, options: CallOptions) !ListTaskInstancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "airflow-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTaskInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("airflow-serverless", "MWAA Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMWAAServerless.ListTaskInstances");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTaskInstancesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTaskInstancesOutput, body, allocator);
}
