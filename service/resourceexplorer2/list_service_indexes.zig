const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Index = @import("index.zig").Index;

pub const ListServiceIndexesInput = struct {
    /// The maximum number of index results to return in a single response. Valid
    /// values are between `1` and `100`.
    max_results: ?i32 = null,

    /// The pagination token from a previous `ListServiceIndexes` response. Use this
    /// token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// A list of Amazon Web Services Regions to include in the search for indexes.
    /// If not specified, indexes from all Regions are returned.
    regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .regions = "Regions",
    };
};

pub const ListServiceIndexesOutput = struct {
    /// A list of `Index` objects that describe the Resource Explorer indexes found
    /// in the specified Regions.
    indexes: ?[]const Index = null,

    /// The pagination token to use in a subsequent `ListServiceIndexes` request to
    /// retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .indexes = "Indexes",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceIndexesInput, options: CallOptions) !ListServiceIndexesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-explorer-2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServiceIndexesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-explorer-2", "Resource Explorer 2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListServiceIndexes";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Regions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServiceIndexesOutput {
    const result: ListServiceIndexesOutput = try aws.json.parseJsonObject(
        ListServiceIndexesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
