const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateMapRunInput = struct {
    /// The Amazon Resource Name (ARN) of a Map Run.
    map_run_arn: []const u8,

    /// The maximum number of child workflow executions that can be specified to run
    /// in parallel for the Map Run at the same time.
    max_concurrency: ?i32 = null,

    /// The maximum number of failed items before the Map Run fails.
    tolerated_failure_count: ?i64 = null,

    /// The maximum percentage of failed items before the Map Run fails.
    tolerated_failure_percentage: ?f32 = null,

    pub const json_field_names = .{
        .map_run_arn = "mapRunArn",
        .max_concurrency = "maxConcurrency",
        .tolerated_failure_count = "toleratedFailureCount",
        .tolerated_failure_percentage = "toleratedFailurePercentage",
    };
};

pub const UpdateMapRunOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMapRunInput, options: CallOptions) !UpdateMapRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "states", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMapRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("states", "SFN", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.UpdateMapRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMapRunOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
