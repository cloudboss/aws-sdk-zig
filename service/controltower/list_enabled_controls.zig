const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnabledControlFilter = @import("enabled_control_filter.zig").EnabledControlFilter;
const EnabledControlSummary = @import("enabled_control_summary.zig").EnabledControlSummary;

pub const ListEnabledControlsInput = struct {
    /// An input filter for the `ListEnabledControls` API that lets you select the
    /// types of control operations to view.
    filter: ?EnabledControlFilter = null,

    /// Specifies whether to include enabled controls from child organizational
    /// units and child accounts in the response.
    include_children: ?bool = null,

    /// How many results to return per API call.
    max_results: ?i32 = null,

    /// The token to continue the list from a previous API call with the same
    /// parameters.
    next_token: ?[]const u8 = null,

    /// The ARN of the target. The value depends on the target type:
    ///
    /// * Organizational unit (OU) – Specify the ARN of the OU.
    /// * Account – Specify the ARN of the account.
    ///
    /// For information on how to find the `targetIdentifier`, see [the overview
    /// page](https://docs.aws.amazon.com/controltower/latest/APIReference/Welcome.html).
    target_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "filter",
        .include_children = "includeChildren",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .target_identifier = "targetIdentifier",
    };
};

pub const ListEnabledControlsOutput = struct {
    /// Lists the controls enabled by Amazon Web Services Control Tower on the
    /// specified organizational unit and the accounts it contains.
    enabled_controls: ?[]const EnabledControlSummary = null,

    /// Retrieves the next page of results. If the string is empty, the response is
    /// the end of the results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled_controls = "enabledControls",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEnabledControlsInput, options: CallOptions) !ListEnabledControlsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEnabledControlsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("controltower", "ControlTower", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-enabled-controls";

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
    if (input.target_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"targetIdentifier\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEnabledControlsOutput {
    const result: ListEnabledControlsOutput = try aws.json.parseJsonObject(
        ListEnabledControlsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
