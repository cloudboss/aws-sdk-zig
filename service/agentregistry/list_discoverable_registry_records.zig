const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistryRecordFilter = @import("registry_record_filter.zig").RegistryRecordFilter;
const DiscoverableRegistryRecordSummary = @import("discoverable_registry_record_summary.zig").DiscoverableRegistryRecordSummary;

pub const ListDiscoverableRegistryRecordsInput = struct {
    /// The filters to apply to the discoverable registry record list.
    filters: ?[]const RegistryRecordFilter = null,

    /// The maximum number of records to return in a single page. Valid values are 1
    /// through 100.
    max_results: ?i32 = null,

    /// The pagination token returned by a previous request. Use this value to
    /// retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// The identifier of the registry whose discoverable records are listed. You
    /// can provide either the full Amazon Resource Name (ARN) or the registry ID.
    registry_id: []const u8,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .registry_id = "registryId",
    };
};

pub const ListDiscoverableRegistryRecordsOutput = struct {
    /// The pagination token to pass to a subsequent request to retrieve the next
    /// page of results. This field is absent when there are no more results.
    next_token: ?[]const u8 = null,

    /// The page of discoverable registry record summaries.
    registry_records: ?[]const DiscoverableRegistryRecordSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .registry_records = "registryRecords",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDiscoverableRegistryRecordsInput, options: CallOptions) !ListDiscoverableRegistryRecordsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "agent-registry", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDiscoverableRegistryRecordsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("agent-registry", "Agent Registry", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/registries/");
    try path_buf.appendSlice(allocator, input.registry_id);
    try path_buf.appendSlice(allocator, "/discoverable-records-list");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDiscoverableRegistryRecordsOutput {
    const result: ListDiscoverableRegistryRecordsOutput = try aws.json.parseJsonObject(
        ListDiscoverableRegistryRecordsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
