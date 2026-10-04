const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ExecuteOpenCypherQueryInput = struct {
    /// The openCypher query string to be executed.
    open_cypher_query: []const u8,

    /// The openCypher query parameters for query execution. See [Examples of
    /// openCypher parameterized
    /// queries](https://docs.aws.amazon.com/neptune/latest/userguide/opencypher-parameterized-queries.html) for more information.
    parameters: ?[]const u8 = null,

    pub const json_field_names = .{
        .open_cypher_query = "openCypherQuery",
        .parameters = "parameters",
    };
};

pub const ExecuteOpenCypherQueryOutput = struct {
    /// The openCypherquery results.
    results: []const u8,

    pub const json_field_names = .{
        .results = "results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecuteOpenCypherQueryInput, options: CallOptions) !ExecuteOpenCypherQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-db", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ExecuteOpenCypherQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/opencypher";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"openCypherQuery\":");
    try aws.json.writeValue(@TypeOf(input.open_cypher_query), input.open_cypher_query, allocator, &body_buf);
    has_prev = true;
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameters\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecuteOpenCypherQueryOutput {
    var result: ExecuteOpenCypherQueryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ExecuteOpenCypherQueryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
