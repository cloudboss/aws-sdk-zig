const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OpenCypherExplainMode = @import("open_cypher_explain_mode.zig").OpenCypherExplainMode;

pub const ExecuteOpenCypherExplainQueryInput = struct {
    /// The openCypher `explain` mode. Can be one of: `static`, `dynamic`, or
    /// `details`.
    explain_mode: OpenCypherExplainMode,

    /// The openCypher query string.
    open_cypher_query: []const u8,

    /// The openCypher query parameters.
    parameters: ?[]const u8 = null,

    pub const json_field_names = .{
        .explain_mode = "explainMode",
        .open_cypher_query = "openCypherQuery",
        .parameters = "parameters",
    };
};

pub const ExecuteOpenCypherExplainQueryOutput = struct {
    /// A text blob containing the openCypher `explain` results.
    results: []const u8,

    pub const json_field_names = .{
        .results = "results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecuteOpenCypherExplainQueryInput, options: CallOptions) !ExecuteOpenCypherExplainQueryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExecuteOpenCypherExplainQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/opencypher/explain";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"explainMode\":");
    try aws.json.writeValue(@TypeOf(input.explain_mode), input.explain_mode, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecuteOpenCypherExplainQueryOutput {
    var result: ExecuteOpenCypherExplainQueryOutput = .{
        .results = "",
    };
    errdefer {
        allocator.free(result.results);
    }
    result.results = try allocator.dupe(u8, body);
    _ = status;
    _ = headers;

    return result;
}
