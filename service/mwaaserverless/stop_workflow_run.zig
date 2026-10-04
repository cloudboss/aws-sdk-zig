const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowRunStatus = @import("workflow_run_status.zig").WorkflowRunStatus;

pub const StopWorkflowRunInput = struct {
    /// The unique identifier of the workflow run to stop.
    run_id: []const u8,

    /// The Amazon Resource Name (ARN) of the workflow that contains the run you
    /// want to stop.
    workflow_arn: []const u8,

    pub const json_field_names = .{
        .run_id = "RunId",
        .workflow_arn = "WorkflowArn",
    };
};

pub const StopWorkflowRunOutput = struct {
    /// The unique identifier of the stopped workflow run.
    run_id: ?[]const u8 = null,

    /// The status of the workflow run after the stop operation. This is typically
    /// `STOPPING` or `STOPPED`.
    status: ?WorkflowRunStatus = null,

    /// The Amazon Resource Name (ARN) of the workflow that contains the stopped
    /// run.
    workflow_arn: ?[]const u8 = null,

    /// The version of the workflow that was stopped.
    workflow_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .run_id = "RunId",
        .status = "Status",
        .workflow_arn = "WorkflowArn",
        .workflow_version = "WorkflowVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopWorkflowRunInput, options: CallOptions) !StopWorkflowRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StopWorkflowRunInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMWAAServerless.StopWorkflowRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopWorkflowRunOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StopWorkflowRunOutput, body, allocator);
}
