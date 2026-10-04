const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StageState = @import("stage_state.zig").StageState;

pub const GetPipelineStateInput = struct {
    /// The name of the pipeline about which you want to get information.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};

pub const GetPipelineStateOutput = struct {
    /// The date and time the pipeline was created, in timestamp format.
    created: ?i64 = null,

    /// The name of the pipeline for which you want to get the state.
    pipeline_name: ?[]const u8 = null,

    /// The version number of the pipeline.
    ///
    /// A newly created pipeline is always assigned a version number of
    /// `1`.
    pipeline_version: ?i32 = null,

    /// A list of the pipeline stage output information, including stage name,
    /// state, most
    /// recent run details, whether the stage is disabled, and other data.
    stage_states: ?[]const StageState = null,

    /// The date and time the pipeline was last updated, in timestamp format.
    updated: ?i64 = null,

    pub const json_field_names = .{
        .created = "created",
        .pipeline_name = "pipelineName",
        .pipeline_version = "pipelineVersion",
        .stage_states = "stageStates",
        .updated = "updated",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPipelineStateInput, options: CallOptions) !GetPipelineStateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPipelineStateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.GetPipelineState");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPipelineStateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPipelineStateOutput, body, allocator);
}
