const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConditionType = @import("condition_type.zig").ConditionType;

pub const OverrideStageConditionInput = struct {
    /// The type of condition to override for the stage, such as entry conditions,
    /// failure
    /// conditions, or success conditions.
    condition_type: ConditionType,

    /// The ID of the pipeline execution for the override.
    pipeline_execution_id: []const u8,

    /// The name of the pipeline with the stage that will override the condition.
    pipeline_name: []const u8,

    /// The name of the stage for the override.
    stage_name: []const u8,

    pub const json_field_names = .{
        .condition_type = "conditionType",
        .pipeline_execution_id = "pipelineExecutionId",
        .pipeline_name = "pipelineName",
        .stage_name = "stageName",
    };
};

pub const OverrideStageConditionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: OverrideStageConditionInput, options: CallOptions) !OverrideStageConditionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: OverrideStageConditionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.OverrideStageCondition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !OverrideStageConditionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
