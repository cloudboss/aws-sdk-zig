const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ExecuteGremlinExplainQueryInput = struct {
    /// The Gremlin explain query string.
    gremlin_query: []const u8,

    pub const json_field_names = .{
        .gremlin_query = "gremlinQuery",
    };
};

pub const ExecuteGremlinExplainQueryOutput = struct {
    /// A text blob containing the Gremlin explain result, as described in [Tuning
    /// Gremlin
    /// queries](https://docs.aws.amazon.com/neptune/latest/userguide/gremlin-traversal-tuning.html).
    output: ?[]const u8 = null,

    pub const json_field_names = .{
        .output = "output",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecuteGremlinExplainQueryInput, options: CallOptions) !ExecuteGremlinExplainQueryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExecuteGremlinExplainQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/gremlin/explain";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"gremlinQuery\":");
    try aws.json.writeValue(@TypeOf(input.gremlin_query), input.gremlin_query, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecuteGremlinExplainQueryOutput {
    var result: ExecuteGremlinExplainQueryOutput = .{};
    if (body.len > 0) {
        result.output = try allocator.dupe(u8, body);
    }
    _ = status;
    _ = headers;

    return result;
}
