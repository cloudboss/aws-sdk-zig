const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListTargetsFilter = @import("list_targets_filter.zig").ListTargetsFilter;
const TargetSummary = @import("target_summary.zig").TargetSummary;

pub const ListTargetsInput = struct {
    /// The filters to use to return information by service or resource type. Valid
    /// filters
    /// include target type, target address, and target status.
    ///
    /// A filter with the same name can appear more than once when used with OR
    /// statements. Filters with different names should be applied with AND
    /// statements.
    filters: ?[]const ListTargetsFilter = null,

    /// A non-negative integer used to limit the number of returned results. The
    /// maximum number of
    /// results that can be returned is 100.
    max_results: ?i32 = null,

    /// An enumeration token that, when provided in a request, returns the next
    /// batch of the
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListTargetsOutput = struct {
    /// An enumeration token that can be used in a request to return the next batch
    /// of
    /// results.
    next_token: ?[]const u8 = null,

    /// The list of notification rule targets.
    targets: ?[]const TargetSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .targets = "Targets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTargetsInput, options: CallOptions) !ListTargetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codestar-notifications", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTargetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codestar-notifications", "codestar notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listTargets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTargetsOutput {
    const result: ListTargetsOutput = try aws.json.parseJsonObject(
        ListTargetsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
