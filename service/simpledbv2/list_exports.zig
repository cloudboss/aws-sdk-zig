const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportSummary = @import("export_summary.zig").ExportSummary;

pub const ListExportsInput = struct {
    /// The name of the domain to filter exports. If not provided, exports for all
    /// the domains will be listed.
    domain_name: ?[]const u8 = null,

    /// The maximum number of exports to return in a single response.
    max_results: ?i32 = null,

    /// A pagination token used to retrieve the next page of results. This token is
    /// obtained from
    /// the nextToken field in the previous ListExportsResponse. Leave empty for the
    /// first request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListExportsOutput = struct {
    /// List of export summaries containing export ARN, status, request timestamp,
    /// and associated domain name.
    export_summaries: ?[]const ExportSummary = null,

    /// A pagination token indicating that more results are available. To retrieve
    /// the next page
    /// of results, provide this token in a subsequent ListExports request. If null
    /// or empty, there are no
    /// more results to retrieve.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .export_summaries = "exportSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExportsInput, options: CallOptions) !ListExportsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sdb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListExportsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sdb", "SimpleDBv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/ListExports";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.domain_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"domainName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListExportsOutput {
    const result: ListExportsOutput = try aws.json.parseJsonObject(
        ListExportsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
