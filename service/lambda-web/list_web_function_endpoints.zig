const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const FunctionEndpointSummary = @import("function_endpoint_summary.zig").FunctionEndpointSummary;

pub const ListWebFunctionEndpointsInput = struct {
    /// A list of filters to apply to the results. Supported filter names:
    /// `authType`, `autoDeploymentMode`, `endpointType`, `state`, and
    /// `updateStatus`.
    filters: ?[]const Filter = null,

    /// The name of the web function. You can specify the function name or the
    /// function ARN. The length constraint applies only to the full ARN. If you
    /// specify only the function name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// The maximum number of results to return in a single call. Minimum value of
    /// 1, maximum value of 50. Default is 50.
    max_results: ?i32 = null,

    /// The pagination token that's returned by a previous request to retrieve the
    /// next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "filters",
        .function_name = "functionName",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListWebFunctionEndpointsOutput = struct {
    /// A list of endpoint summaries for the web function.
    endpoints: ?[]const FunctionEndpointSummary = null,

    /// The pagination token that's included if more results are available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoints = "endpoints",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWebFunctionEndpointsInput, options: CallOptions) !ListWebFunctionEndpointsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWebFunctionEndpointsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-03-07/web-functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/list-endpoints");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWebFunctionEndpointsOutput {
    const result: ListWebFunctionEndpointsOutput = try aws.json.parseJsonObject(
        ListWebFunctionEndpointsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
