const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StageTransitionType = @import("stage_transition_type.zig").StageTransitionType;

pub const EnableStageTransitionInput = struct {
    /// The name of the pipeline in which you want to enable the flow of artifacts
    /// from one
    /// stage to another.
    pipeline_name: []const u8,

    /// The name of the stage where you want to enable the transition of artifacts,
    /// either
    /// into the stage (inbound) or from that stage to the next stage (outbound).
    stage_name: []const u8,

    /// Specifies whether artifacts are allowed to enter the stage and be processed
    /// by the
    /// actions in that stage (inbound) or whether already processed artifacts are
    /// allowed to
    /// transition to the next stage (outbound).
    transition_type: StageTransitionType,

    pub const json_field_names = .{
        .pipeline_name = "pipelineName",
        .stage_name = "stageName",
        .transition_type = "transitionType",
    };
};

pub const EnableStageTransitionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: EnableStageTransitionInput, options: CallOptions) !EnableStageTransitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: EnableStageTransitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.EnableStageTransition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !EnableStageTransitionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
