const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowRunDetail = @import("workflow_run_detail.zig").WorkflowRunDetail;
const RunType = @import("run_type.zig").RunType;

pub const GetWorkflowRunInput = struct {
    /// The unique identifier of the workflow run to retrieve.
    run_id: []const u8,

    /// The Amazon Resource Name (ARN) of the workflow that contains the run.
    workflow_arn: []const u8,

    pub const json_field_names = .{
        .run_id = "RunId",
        .workflow_arn = "WorkflowArn",
    };
};

pub const GetWorkflowRunOutput = struct {
    /// Parameters that were overridden for this specific workflow run.
    override_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Detailed information about the workflow run execution, including timing,
    /// status, and task instances.
    run_detail: ?WorkflowRunDetail = null,

    /// The unique identifier of this workflow run.
    run_id: ?[]const u8 = null,

    /// The type of workflow run. Values are `ON_DEMAND` (manually triggered) or
    /// `SCHEDULED` (automatically triggered by schedule).
    run_type: ?RunType = null,

    /// The Amazon Resource Name (ARN) of the workflow that contains this run.
    workflow_arn: ?[]const u8 = null,

    /// The version of the workflow that is used for this run.
    workflow_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .override_parameters = "OverrideParameters",
        .run_detail = "RunDetail",
        .run_id = "RunId",
        .run_type = "RunType",
        .workflow_arn = "WorkflowArn",
        .workflow_version = "WorkflowVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowRunInput, options: CallOptions) !GetWorkflowRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkflowRunInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMWAAServerless.GetWorkflowRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkflowRunOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetWorkflowRunOutput, body, allocator);
}
