const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GraphSummaryType = @import("graph_summary_type.zig").GraphSummaryType;
const RDFGraphSummaryValueMap = @import("rdf_graph_summary_value_map.zig").RDFGraphSummaryValueMap;

pub const GetRDFGraphSummaryInput = struct {
    /// Mode can take one of two values: `BASIC` (the default), and `DETAILED`.
    mode: ?GraphSummaryType = null,

    pub const json_field_names = .{
        .mode = "mode",
    };
};

pub const GetRDFGraphSummaryOutput = struct {
    /// Payload for an RDF graph summary response
    payload: ?RDFGraphSummaryValueMap = null,

    /// The HTTP return code of the request. If the request succeeded, the code is
    /// 200.
    status_code: ?i32 = null,

    pub const json_field_names = .{
        .payload = "payload",
        .status_code = "statusCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRDFGraphSummaryInput, options: CallOptions) !GetRDFGraphSummaryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRDFGraphSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/rdf/statistics/summary";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.mode) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "mode=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRDFGraphSummaryOutput {
    var result: GetRDFGraphSummaryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRDFGraphSummaryOutput, body, allocator);
    }
    result.status_code = @intCast(status);
    _ = headers;

    return result;
}
