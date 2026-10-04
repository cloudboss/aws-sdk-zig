const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EdgeDirection = @import("edge_direction.zig").EdgeDirection;
const SortOrder = @import("sort_order.zig").SortOrder;
const LineageNodeSummary = @import("lineage_node_summary.zig").LineageNodeSummary;

pub const ListLineageNodeHistoryInput = struct {
    /// The direction of the data lineage node refers to the lineage node having
    /// neighbors in that direction. For example, if direction is `UPSTREAM`, the
    /// `ListLineageNodeHistory` API responds with historical versions with upstream
    /// neighbors only.
    direction: ?EdgeDirection = null,

    /// The ID of the domain where you want to list the history of the specified
    /// data lineage node.
    domain_identifier: []const u8,

    /// Specifies whether the action is to return data lineage node history from the
    /// time after the event timestamp.
    event_timestamp_gte: ?i64 = null,

    /// Specifies whether the action is to return data lineage node history from the
    /// time prior of the event timestamp.
    event_timestamp_lte: ?i64 = null,

    /// The ID of the data lineage node whose history you want to list.
    identifier: []const u8,

    /// The maximum number of history items to return in a single call to
    /// ListLineageNodeHistory. When the number of memberships to be listed is
    /// greater than the value of MaxResults, the response contains a NextToken
    /// value that you can use in a subsequent call to ListLineageNodeHistory to
    /// list the next set of items.
    max_results: ?i32 = null,

    /// When the number of history items is greater than the default value for the
    /// MaxResults parameter, or if you explicitly specify a value for MaxResults
    /// that is less than the number of items, the response includes a pagination
    /// token named NextToken. You can specify this NextToken value in a subsequent
    /// call to ListLineageNodeHistory to list the next set of items.
    next_token: ?[]const u8 = null,

    /// The order by which you want data lineage node history to be sorted.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .direction = "direction",
        .domain_identifier = "domainIdentifier",
        .event_timestamp_gte = "eventTimestampGTE",
        .event_timestamp_lte = "eventTimestampLTE",
        .identifier = "identifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_order = "sortOrder",
    };
};

pub const ListLineageNodeHistoryOutput = struct {
    /// When the number of history items is greater than the default value for the
    /// MaxResults parameter, or if you explicitly specify a value for MaxResults
    /// that is less than the number of items, the response includes a pagination
    /// token named NextToken. You can specify this NextToken value in a subsequent
    /// call to ListLineageNodeHistory to list the next set of items.
    next_token: ?[]const u8 = null,

    /// The nodes returned by the ListLineageNodeHistory action.
    nodes: ?[]const LineageNodeSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .nodes = "nodes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLineageNodeHistoryInput, options: CallOptions) !ListLineageNodeHistoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLineageNodeHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/lineage/nodes/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/history");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.direction) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "direction=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.event_timestamp_gte) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "timestampGTE=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.event_timestamp_lte) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "timestampLTE=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.sort_order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortOrder=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLineageNodeHistoryOutput {
    const result: ListLineageNodeHistoryOutput = try aws.json.parseJsonObject(
        ListLineageNodeHistoryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
