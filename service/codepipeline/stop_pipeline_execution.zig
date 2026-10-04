const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StopPipelineExecutionInput = struct {
    /// Use this option to stop the pipeline execution by abandoning, rather than
    /// finishing,
    /// in-progress actions.
    ///
    /// This option can lead to failed or out-of-sequence tasks.
    abandon: ?bool = null,

    /// The ID of the pipeline execution to be stopped in the current stage. Use the
    /// `GetPipelineState` action to retrieve the current
    /// pipelineExecutionId.
    pipeline_execution_id: []const u8,

    /// The name of the pipeline to stop.
    pipeline_name: []const u8,

    /// Use this option to enter comments, such as the reason the pipeline was
    /// stopped.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .abandon = "abandon",
        .pipeline_execution_id = "pipelineExecutionId",
        .pipeline_name = "pipelineName",
        .reason = "reason",
    };
};

pub const StopPipelineExecutionOutput = struct {
    /// The unique system-generated ID of the pipeline execution that was stopped.
    pipeline_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .pipeline_execution_id = "pipelineExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopPipelineExecutionInput, options: CallOptions) !StopPipelineExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codepipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopPipelineExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codepipeline", "CodePipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.StopPipelineExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopPipelineExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StopPipelineExecutionOutput, body, allocator);
}
