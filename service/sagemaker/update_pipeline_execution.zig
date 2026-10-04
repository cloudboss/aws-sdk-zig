const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParallelismConfiguration = @import("parallelism_configuration.zig").ParallelismConfiguration;

pub const UpdatePipelineExecutionInput = struct {
    /// This configuration, if specified, overrides the parallelism configuration of
    /// the parent pipeline for this specific run.
    parallelism_configuration: ?ParallelismConfiguration = null,

    /// The Amazon Resource Name (ARN) of the pipeline execution.
    pipeline_execution_arn: []const u8,

    /// The description of the pipeline execution.
    pipeline_execution_description: ?[]const u8 = null,

    /// The display name of the pipeline execution.
    pipeline_execution_display_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .parallelism_configuration = "ParallelismConfiguration",
        .pipeline_execution_arn = "PipelineExecutionArn",
        .pipeline_execution_description = "PipelineExecutionDescription",
        .pipeline_execution_display_name = "PipelineExecutionDisplayName",
    };
};

pub const UpdatePipelineExecutionOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated pipeline execution.
    pipeline_execution_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .pipeline_execution_arn = "PipelineExecutionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePipelineExecutionInput, options: CallOptions) !UpdatePipelineExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePipelineExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdatePipelineExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePipelineExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdatePipelineExecutionOutput, body, allocator);
}
