const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataTableSearchCriteria = @import("data_table_search_criteria.zig").DataTableSearchCriteria;
const DataTableSearchFilter = @import("data_table_search_filter.zig").DataTableSearchFilter;
const DataTable = @import("data_table.zig").DataTable;

pub const SearchDataTablesInput = struct {
    /// The unique identifier for the Amazon Connect instance to search within.
    instance_id: []const u8,

    /// The maximum number of data tables to return in one page of results.
    max_results: ?i32 = null,

    /// Specify the pagination token from a previous request to retrieve the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// Search criteria including string conditions for matching table names,
    /// descriptions, or resource IDs. Supports
    /// STARTS_WITH, CONTAINS, and EXACT comparison types.
    search_criteria: ?DataTableSearchCriteria = null,

    /// Optional filters to apply to the search results, such as tag-based filtering
    /// for attribute-based access
    /// control.
    search_filter: ?DataTableSearchFilter = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .search_criteria = "SearchCriteria",
        .search_filter = "SearchFilter",
    };
};

pub const SearchDataTablesOutput = struct {
    /// The approximate number of data tables that matched the search criteria.
    approximate_total_count: ?i64 = null,

    /// An array of data tables matching the search criteria with the same structure
    /// as DescribeTable except Version,
    /// VersionDescription, and LockVersion are omitted.
    data_tables: ?[]const DataTable = null,

    /// Specify the pagination token from a previous request to retrieve the next
    /// page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .approximate_total_count = "ApproximateTotalCount",
        .data_tables = "DataTables",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchDataTablesInput, options: CallOptions) !SearchDataTablesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchDataTablesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/search-data-tables";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstanceId\":");
    try aws.json.writeValue(@TypeOf(input.instance_id), input.instance_id, allocator, &body_buf);
    has_prev = true;
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
    if (input.search_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SearchCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.search_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SearchFilter\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchDataTablesOutput {
    const result: SearchDataTablesOutput = try aws.json.parseJsonObject(
        SearchDataTablesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
