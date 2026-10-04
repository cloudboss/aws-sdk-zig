const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const Sort = @import("sort.zig").Sort;
const ChangeSetSummaryListItem = @import("change_set_summary_list_item.zig").ChangeSetSummaryListItem;

pub const ListChangeSetsInput = struct {
    /// The catalog related to the request. Fixed value: `AWSMarketplace`
    catalog: []const u8,

    /// An array of filter objects.
    filter_list: ?[]const Filter = null,

    /// The maximum number of results returned by a single call. This value must be
    /// provided
    /// in the next call to retrieve the next set of results. By default, this value
    /// is
    /// 20.
    max_results: ?i32 = null,

    /// The token value retrieved from a previous call to access the next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// An object that contains two attributes, `SortBy` and
    /// `SortOrder`.
    sort: ?Sort = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .filter_list = "FilterList",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort = "Sort",
    };
};

pub const ListChangeSetsOutput = struct {
    /// Array of `ChangeSetSummaryListItem` objects.
    change_set_summary_list: ?[]const ChangeSetSummaryListItem = null,

    /// The value of the next token, if it exists. Null if there are no more
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_set_summary_list = "ChangeSetSummaryList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListChangeSetsInput, options: CallOptions) !ListChangeSetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aws-marketplace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListChangeSetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("catalog.marketplace", "Marketplace Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListChangeSets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Catalog\":");
    try aws.json.writeValue(@TypeOf(input.catalog), input.catalog, allocator, &body_buf);
    has_prev = true;
    if (input.filter_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterList\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Sort\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListChangeSetsOutput {
    var result: ListChangeSetsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListChangeSetsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
