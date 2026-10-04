const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FunctionScalingConfig = @import("function_scaling_config.zig").FunctionScalingConfig;
const State = @import("state.zig").State;

pub const PutFunctionScalingConfigInput = struct {
    /// The name or ARN of the Lambda function.
    function_name: []const u8,

    /// The scaling configuration to apply to the function, including minimum and
    /// maximum execution environment limits.
    function_scaling_config: ?FunctionScalingConfig = null,

    /// Specify a version or alias to set the scaling configuration for a published
    /// version of the function.
    qualifier: []const u8,

    pub const json_field_names = .{
        .function_name = "FunctionName",
        .function_scaling_config = "FunctionScalingConfig",
        .qualifier = "Qualifier",
    };
};

pub const PutFunctionScalingConfigOutput = struct {
    /// The current state of the function after applying the scaling configuration.
    function_state: ?State = null,

    pub const json_field_names = .{
        .function_state = "FunctionState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutFunctionScalingConfigInput, options: CallOptions) !PutFunctionScalingConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutFunctionScalingConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-11-30/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/function-scaling-config");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "Qualifier=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.qualifier);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.function_scaling_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FunctionScalingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutFunctionScalingConfigOutput {
    const result: PutFunctionScalingConfigOutput = try aws.json.parseJsonObject(
        PutFunctionScalingConfigOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
