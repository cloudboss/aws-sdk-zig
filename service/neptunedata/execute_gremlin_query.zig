const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GremlinQueryStatusAttributes = @import("gremlin_query_status_attributes.zig").GremlinQueryStatusAttributes;

pub const ExecuteGremlinQueryInput = struct {
    /// Using this API, you can run Gremlin queries in string format much as you can
    /// using the HTTP endpoint. The interface is compatible with whatever Gremlin
    /// version your DB cluster is using (see the [Tinkerpop client
    /// section](https://docs.aws.amazon.com/neptune/latest/userguide/access-graph-gremlin-client.html#best-practices-gremlin-java-latest) to determine which Gremlin releases your engine version supports).
    gremlin_query: []const u8,

    /// If non-null, the query results are returned in a serialized response message
    /// in the format specified by this parameter. See the
    /// [GraphSON](https://tinkerpop.apache.org/docs/current/reference/#_graphson)
    /// section in the TinkerPop documentation for a list of the formats that are
    /// currently supported.
    serializer: ?[]const u8 = null,

    pub const json_field_names = .{
        .gremlin_query = "gremlinQuery",
        .serializer = "serializer",
    };
};

pub const ExecuteGremlinQueryOutput = struct {
    /// Metadata about the Gremlin query.
    meta: ?[]const u8 = null,

    /// The unique identifier of the Gremlin query.
    request_id: ?[]const u8 = null,

    /// The Gremlin query output from the server.
    result: ?[]const u8 = null,

    /// The status of the Gremlin query.
    status: ?GremlinQueryStatusAttributes = null,

    pub const json_field_names = .{
        .meta = "meta",
        .request_id = "requestId",
        .result = "result",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExecuteGremlinQueryInput, options: CallOptions) !ExecuteGremlinQueryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ExecuteGremlinQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/gremlin";

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
    if (input.serializer) |v| {
        try request.headers.put(allocator, "accept", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExecuteGremlinQueryOutput {
    const result: ExecuteGremlinQueryOutput = try aws.json.parseJsonObject(
        ExecuteGremlinQueryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
