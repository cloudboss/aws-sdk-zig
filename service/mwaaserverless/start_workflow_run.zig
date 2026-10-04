const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowRunStatus = @import("workflow_run_status.zig").WorkflowRunStatus;

pub const StartWorkflowRunInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. This token prevents duplicate workflow run
    /// requests.
    client_token: ?[]const u8 = null,

    /// Optional parameters to override default workflow parameters for this
    /// specific run. These parameters are passed to the workflow during execution
    /// and can be used to customize behavior without modifying the workflow
    /// definition. Parameters are made available as environment variables to tasks
    /// and you can reference them within the YAML workflow definition using
    /// standard parameter substitution syntax.
    override_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the workflow you want to run.
    workflow_arn: []const u8,

    /// Optional. The specific version of the workflow to execute. If not specified,
    /// the latest version is used.
    workflow_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .override_parameters = "OverrideParameters",
        .workflow_arn = "WorkflowArn",
        .workflow_version = "WorkflowVersion",
    };
};

pub const StartWorkflowRunOutput = struct {
    /// The unique identifier of the newly started workflow run.
    run_id: ?[]const u8 = null,

    /// The timestamp when the workflow run was started, in ISO 8601 date-time
    /// format.
    started_at: ?i64 = null,

    /// The initial status of the workflow run. This is typically `STARTING` when
    /// you first create the run.
    status: ?WorkflowRunStatus = null,

    pub const json_field_names = .{
        .run_id = "RunId",
        .started_at = "StartedAt",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartWorkflowRunInput, options: CallOptions) !StartWorkflowRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartWorkflowRunInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMWAAServerless.StartWorkflowRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartWorkflowRunOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartWorkflowRunOutput, body, allocator);
}
