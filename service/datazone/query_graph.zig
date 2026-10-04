const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdditionalAttributes = @import("additional_attributes.zig").AdditionalAttributes;
const MatchClause = @import("match_clause.zig").MatchClause;
const ResultItem = @import("result_item.zig").ResultItem;

pub const QueryGraphInput = struct {
    /// Additional details on the queried entity that can be requested in the
    /// response.
    additional_attributes: ?AdditionalAttributes = null,

    /// The identifier of the Amazon DataZone domain.
    domain_identifier: []const u8,

    /// List of query match clauses.
    match: []const MatchClause,

    /// The maximum number of entities to return in a single call to `QueryGraph`.
    /// When the number of entities to be listed is greater than the value of
    /// `MaxResults`, the response contains a `NextToken` value that you can use in
    /// a subsequent call to `QueryGraph` to list the next set of entities.
    max_results: ?i32 = null,

    /// When the number of entities is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of entities, the response includes
    /// a pagination token named `NextToken`. You can specify this `NextToken` value
    /// in a subsequent call to `QueryGraph` to list the next set of entities.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_attributes = "additionalAttributes",
        .domain_identifier = "domainIdentifier",
        .match = "match",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const QueryGraphOutput = struct {
    /// The results of the `QueryGraph` action.
    items: ?[]const ResultItem = null,

    /// When the number of entities is greater than the default value for the
    /// `MaxResults` parameter, or if you explicitly specify a value for
    /// `MaxResults` that is less than the number of entities, the response includes
    /// a pagination token named `NextToken`. You can specify this `NextToken` value
    /// in a subsequent call to `QueryGraph` to list the next set of entities.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: QueryGraphInput, options: CallOptions) !QueryGraphOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: QueryGraphInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/graph/query");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"additionalAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"match\":");
    try aws.json.writeValue(@TypeOf(input.match), input.match, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !QueryGraphOutput {
    const result: QueryGraphOutput = try aws.json.parseJsonObject(
        QueryGraphOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
