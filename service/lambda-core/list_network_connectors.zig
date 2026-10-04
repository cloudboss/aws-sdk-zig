const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NetworkConnectorState = @import("network_connector_state.zig").NetworkConnectorState;
const NetworkConnectorSummary = @import("network_connector_summary.zig").NetworkConnectorSummary;

pub const ListNetworkConnectorsInput = struct {
    /// The pagination token from a previous `ListNetworkConnectors` response. Use
    /// this value to retrieve the next page of results.
    marker: ?[]const u8 = null,

    /// The maximum number of connectors to return per page. Valid range: 1 to 100.
    max_items: ?i32 = null,

    /// Optional filter to return only connectors in the specified state (for
    /// example, `ACTIVE` or `FAILED`).
    state: ?NetworkConnectorState = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .max_items = "MaxItems",
        .state = "State",
    };
};

pub const ListNetworkConnectorsOutput = struct {
    /// A list of network connector summaries for the current page of results.
    network_connectors: ?[]const NetworkConnectorSummary = null,

    /// The pagination token to include in a subsequent request to retrieve the next
    /// page. This value is null when there are no more results.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .network_connectors = "NetworkConnectors",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNetworkConnectorsInput, options: CallOptions) !ListNetworkConnectorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListNetworkConnectorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Core", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2026-04-04/network-connectors";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxItems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.state) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "State=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNetworkConnectorsOutput {
    const result: ListNetworkConnectorsOutput = try aws.json.parseJsonObject(
        ListNetworkConnectorsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
