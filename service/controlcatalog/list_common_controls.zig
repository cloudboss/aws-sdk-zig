const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CommonControlFilter = @import("common_control_filter.zig").CommonControlFilter;
const CommonControlSummary = @import("common_control_summary.zig").CommonControlSummary;

pub const ListCommonControlsInput = struct {
    /// An optional filter that narrows the results to a specific objective.
    ///
    /// This filter allows you to specify one objective ARN at a time. Passing
    /// multiple ARNs in the `CommonControlFilter` isn’t supported.
    common_control_filter: ?CommonControlFilter = null,

    /// The maximum number of results on a page or for an API request call.
    max_results: ?i32 = null,

    /// The pagination token that's used to fetch the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .common_control_filter = "CommonControlFilter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListCommonControlsOutput = struct {
    /// The list of common controls that the `ListCommonControls` API returns.
    common_controls: ?[]const CommonControlSummary = null,

    /// The pagination token that's used to fetch the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .common_controls = "CommonControls",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCommonControlsInput, options: CallOptions) !ListCommonControlsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "controlcatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCommonControlsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("controlcatalog", "ControlCatalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/common-controls";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.common_control_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CommonControlFilter\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCommonControlsOutput {
    var result: ListCommonControlsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListCommonControlsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
