const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortOrder = @import("sort_order.zig").SortOrder;
const PipelineExecutionStep = @import("pipeline_execution_step.zig").PipelineExecutionStep;

pub const ListPipelineExecutionStepsInput = struct {
    /// The maximum number of pipeline execution steps to return in the response.
    max_results: ?i32 = null,

    /// If the result of the previous `ListPipelineExecutionSteps` request was
    /// truncated, the response includes a `NextToken`. To retrieve the next set of
    /// pipeline execution steps, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the pipeline execution.
    pipeline_execution_arn: ?[]const u8 = null,

    /// The field by which to sort results. The default is `CreatedTime`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .pipeline_execution_arn = "PipelineExecutionArn",
        .sort_order = "SortOrder",
    };
};

pub const ListPipelineExecutionStepsOutput = struct {
    /// If the result of the previous `ListPipelineExecutionSteps` request was
    /// truncated, the response includes a `NextToken`. To retrieve the next set of
    /// pipeline execution steps, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// A list of `PipeLineExecutionStep` objects. Each `PipeLineExecutionStep`
    /// consists of StepName, StartTime, EndTime, StepStatus, and Metadata. Metadata
    /// is an object with properties for each job that contains relevant information
    /// about the job created by the step.
    pipeline_execution_steps: ?[]const PipelineExecutionStep = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .pipeline_execution_steps = "PipelineExecutionSteps",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPipelineExecutionStepsInput, options: CallOptions) !ListPipelineExecutionStepsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPipelineExecutionStepsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListPipelineExecutionSteps");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPipelineExecutionStepsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPipelineExecutionStepsOutput, body, allocator);
}
