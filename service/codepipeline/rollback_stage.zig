const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RollbackStageInput = struct {
    /// The name of the pipeline for which the stage will be rolled back.
    pipeline_name: []const u8,

    /// The name of the stage in the pipeline to be rolled back.
    stage_name: []const u8,

    /// The pipeline execution ID for the stage to be rolled back to.
    target_pipeline_execution_id: []const u8,

    pub const json_field_names = .{
        .pipeline_name = "pipelineName",
        .stage_name = "stageName",
        .target_pipeline_execution_id = "targetPipelineExecutionId",
    };
};

pub const RollbackStageOutput = struct {
    /// The execution ID of the pipeline execution for the stage that has been
    /// rolled
    /// back.
    pipeline_execution_id: []const u8,

    pub const json_field_names = .{
        .pipeline_execution_id = "pipelineExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RollbackStageInput, options: CallOptions) !RollbackStageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RollbackStageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.RollbackStage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RollbackStageOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(RollbackStageOutput, body, allocator);
}
