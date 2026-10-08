const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegistryRecordSummary = @import("registry_record_summary.zig").RegistryRecordSummary;

pub const SearchDiscoverableRegistryRecordsInput = struct {
    /// An optional structured JSON metadata filter that narrows the search results.
    /// Supports the field-level operators `$eq`, `$ne`, and `$in`, and the logical
    /// operators `$and` and `$or` on filterable fields.
    ///
    /// Specifies additional filtering on custom metadata fields using the
    /// `customMetadata.{key}` prefix. For example, to filter by a custom metadata
    /// field: `{"customMetadata.environment": {"$eq": "production"}}`. For a
    /// Boolean field, you can also use a native JSON boolean value, for example:
    /// `{"customMetadata.requiresApproval": {"$eq": true}}`.
    filters: ?[]const u8 = null,

    /// The maximum number of results to return. Valid values are 1 through 20. The
    /// default value is 10.
    max_results: ?i32 = null,

    /// The registry identifiers to search within. Currently, you must specify
    /// exactly one registry identifier. You can provide either the full Amazon Web
    /// Services Resource Name (ARN) or the registry ID.
    registry_ids: []const []const u8,

    /// The natural language query to search for matching registry records.
    search_query: []const u8,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .registry_ids = "registryIds",
        .search_query = "searchQuery",
    };
};

pub const SearchDiscoverableRegistryRecordsOutput = struct {
    /// The registry records that match the search query, ordered by relevance.
    registry_records: ?[]const RegistryRecordSummary = null,

    pub const json_field_names = .{
        .registry_records = "registryRecords",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchDiscoverableRegistryRecordsInput, options: CallOptions) !SearchDiscoverableRegistryRecordsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchDiscoverableRegistryRecordsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("agent-registry", "Agent Registry", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/discoverable-records-search";

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"registryIds\":");
    try aws.json.writeValue(@TypeOf(input.registry_ids), input.registry_ids, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"searchQuery\":");
    try aws.json.writeValue(@TypeOf(input.search_query), input.search_query, allocator, &body_buf);
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchDiscoverableRegistryRecordsOutput {
    const result: SearchDiscoverableRegistryRecordsOutput = try aws.json.parseJsonObject(
        SearchDiscoverableRegistryRecordsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
