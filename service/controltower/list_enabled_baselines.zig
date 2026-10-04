const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnabledBaselineFilter = @import("enabled_baseline_filter.zig").EnabledBaselineFilter;
const EnabledBaselineSummary = @import("enabled_baseline_summary.zig").EnabledBaselineSummary;

pub const ListEnabledBaselinesInput = struct {
    /// A filter applied on the `ListEnabledBaseline` operation. Allowed filters are
    /// `baselineIdentifiers` and `targetIdentifiers`. The filter can be applied for
    /// either, or both.
    filter: ?EnabledBaselineFilter = null,

    /// A value that can be set to include the child enabled baselines in responses.
    /// The default value is false.
    include_children: ?bool = null,

    /// The maximum number of results to be shown.
    max_results: ?i32 = null,

    /// A pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "filter",
        .include_children = "includeChildren",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListEnabledBaselinesOutput = struct {
    /// Retuens a list of summaries of `EnabledBaseline` resources.
    enabled_baselines: ?[]const EnabledBaselineSummary = null,

    /// A pagination token.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled_baselines = "enabledBaselines",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEnabledBaselinesInput, options: CallOptions) !ListEnabledBaselinesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "controltower", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEnabledBaselinesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("controltower", "ControlTower", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-enabled-baselines";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_children) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"includeChildren\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEnabledBaselinesOutput {
    var result: ListEnabledBaselinesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListEnabledBaselinesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
