const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogSourceResource = @import("log_source_resource.zig").LogSourceResource;
const LogSource = @import("log_source.zig").LogSource;

pub const ListLogSourcesInput = struct {
    /// The list of Amazon Web Services accounts for which log sources are
    /// displayed.
    accounts: ?[]const []const u8 = null,

    /// The maximum number of accounts for which the log sources are displayed.
    max_results: ?i32 = null,

    /// If nextToken is returned, there are more results available. You can repeat
    /// the call
    /// using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// The list of Regions for which log sources are displayed.
    regions: ?[]const []const u8 = null,

    /// The list of sources for which log sources are displayed.
    sources: ?[]const LogSourceResource = null,

    pub const json_field_names = .{
        .accounts = "accounts",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .regions = "regions",
        .sources = "sources",
    };
};

pub const ListLogSourcesOutput = struct {
    /// If nextToken is returned, there are more results available. You can repeat
    /// the call
    /// using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// The list of log sources in your organization that send data to the data
    /// lake.
    sources: ?[]const LogSource = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .sources = "sources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLogSourcesInput, options: CallOptions) !ListLogSourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securitylake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLogSourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securitylake", "SecurityLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/datalake/logsources/list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.accounts) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accounts\":");
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
    if (input.regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"regions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sources\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLogSourcesOutput {
    const result: ListLogSourcesOutput = try aws.json.parseJsonObject(
        ListLogSourcesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
