const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListSecurityRequirementPackFilter = @import("list_security_requirement_pack_filter.zig").ListSecurityRequirementPackFilter;
const SecurityRequirementPackSummary = @import("security_requirement_pack_summary.zig").SecurityRequirementPackSummary;

pub const ListSecurityRequirementPacksInput = struct {
    /// The filter criteria for listing security requirement packs.
    filter: ?ListSecurityRequirementPackFilter = null,

    /// The maximum number of results to return in a single request.
    max_results: ?i32 = null,

    /// The pagination token from a previous request to retrieve the next page of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListSecurityRequirementPacksOutput = struct {
    /// The pagination token to use in a subsequent request to retrieve the next
    /// page of results.
    next_token: ?[]const u8 = null,

    /// The list of security requirement pack summaries.
    security_requirement_pack_summaries: ?[]const SecurityRequirementPackSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .security_requirement_pack_summaries = "securityRequirementPackSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSecurityRequirementPacksInput, options: CallOptions) !ListSecurityRequirementPacksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSecurityRequirementPacksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListSecurityRequirementPacks";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filter\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSecurityRequirementPacksOutput {
    const result: ListSecurityRequirementPacksOutput = try aws.json.parseJsonObject(
        ListSecurityRequirementPacksOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
