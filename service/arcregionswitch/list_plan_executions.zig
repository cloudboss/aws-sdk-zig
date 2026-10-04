const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExecutionState = @import("execution_state.zig").ExecutionState;
const AbbreviatedExecution = @import("abbreviated_execution.zig").AbbreviatedExecution;

pub const ListPlanExecutionsInput = struct {
    /// The number of objects that you want to return with this call.
    max_results: ?i32 = null,

    /// Specifies that you want to receive the next page of results. Valid only if
    /// you received a `nextToken` response in the previous request. If you did, it
    /// indicates that more output is available. Set this parameter to the value
    /// provided by the previous call's `nextToken` response to request the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// The ARN for the plan.
    plan_arn: []const u8,

    /// The state of the plan execution. For example, the plan execution might be In
    /// Progress.
    state: ?ExecutionState = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .plan_arn = "planArn",
        .state = "state",
    };
};

pub const ListPlanExecutionsOutput = struct {
    /// The items in the plan execution to return.
    items: ?[]const AbbreviatedExecution = null,

    /// Specifies that you want to receive the next page of results. Valid only if
    /// you received a `nextToken` response in the previous request. If you did, it
    /// indicates that more output is available. Set this parameter to the value
    /// provided by the previous call's `nextToken` response to request the next
    /// page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPlanExecutionsInput, options: CallOptions) !ListPlanExecutionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "arc-region-switch", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPlanExecutionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("arc-region-switch", "ARC Region switch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ArcRegionSwitch.ListPlanExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPlanExecutionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPlanExecutionsOutput, body, allocator);
}
