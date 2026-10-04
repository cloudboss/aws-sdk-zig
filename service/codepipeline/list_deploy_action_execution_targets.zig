const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TargetFilter = @import("target_filter.zig").TargetFilter;
const DeployActionExecutionTarget = @import("deploy_action_execution_target.zig").DeployActionExecutionTarget;

pub const ListDeployActionExecutionTargetsInput = struct {
    /// The execution ID for the deploy action.
    action_execution_id: []const u8,

    /// Filters the targets for a specified deploy action.
    filters: ?[]const TargetFilter = null,

    /// The maximum number of results to return in a single call. To retrieve the
    /// remaining
    /// results, make another call with the returned nextToken value.
    max_results: ?i32 = null,

    /// An identifier that was returned from the previous list action types call,
    /// which can be
    /// used to return the next set of action types in the list.
    next_token: ?[]const u8 = null,

    /// The name of the pipeline with the deploy action.
    pipeline_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_execution_id = "actionExecutionId",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .pipeline_name = "pipelineName",
    };
};

pub const ListDeployActionExecutionTargetsOutput = struct {
    /// An identifier that was returned from the previous list action types call,
    /// which can be
    /// used to return the next set of action types in the list.
    next_token: ?[]const u8 = null,

    /// The targets for the deploy action.
    targets: ?[]const DeployActionExecutionTarget = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .targets = "targets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDeployActionExecutionTargetsInput, options: CallOptions) !ListDeployActionExecutionTargetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDeployActionExecutionTargetsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.ListDeployActionExecutionTargets");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDeployActionExecutionTargetsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDeployActionExecutionTargetsOutput, body, allocator);
}
