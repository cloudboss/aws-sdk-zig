const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ExecuteGremlinProfileQueryInput = struct {
    /// If non-zero, causes the results string to be truncated at that number of
    /// characters. If set to zero, the string contains all the results.
    chop: ?i32 = null,

    /// The Gremlin query string to profile.
    gremlin_query: []const u8,

    /// If this flag is set to `TRUE`, the results include a detailed report of all
    /// index operations that took place during query execution and serialization.
    index_ops: ?bool = null,

    /// If this flag is set to `TRUE`, the query results are gathered and displayed
    /// as part of the profile report. If `FALSE`, only the result count is
    /// displayed.
    results: ?bool = null,

    /// If non-null, the gathered results are returned in a serialized response
    /// message in the format specified by this parameter. See [Gremlin profile API
    /// in
    /// Neptune](https://docs.aws.amazon.com/neptune/latest/userguide/gremlin-profile-api.html) for more information.
    serializer: ?[]const u8 = null,

    pub const json_field_names = .{
        .chop = "chop",
        .gremlin_query = "gremlinQuery",
        .index_ops = "indexOps",
        .results = "results",
        .serializer = "serializer",
    };
};

pub const ExecuteGremlinProfileQueryOutput = struct {
    /// A text blob containing the Gremlin Profile result. See [Gremlin profile API
    /// in
    /// Neptune](https://docs.aws.amazon.com/neptune/latest/userguide/gremlin-profile-api.html) for details.
    output: ?[]const u8 = null,

    pub const json_field_names = .{
        .output = "output",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecuteGremlinProfileQueryInput, options: CallOptions) !ExecuteGremlinProfileQueryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExecuteGremlinProfileQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/gremlin/profile";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.chop) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"chop\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"gremlinQuery\":");
    try aws.json.writeValue(@TypeOf(input.gremlin_query), input.gremlin_query, allocator, &body_buf);
    has_prev = true;
    if (input.index_ops) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"indexOps\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"results\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.serializer) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serializer\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecuteGremlinProfileQueryOutput {
    var result: ExecuteGremlinProfileQueryOutput = .{};
    errdefer {
        if (result.output) |value| allocator.free(value);
    }
    if (body.len > 0) {
        result.output = try allocator.dupe(u8, body);
    }
    _ = status;
    _ = headers;

    return result;
}
