const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const ConfigurationManagerSummary = @import("configuration_manager_summary.zig").ConfigurationManagerSummary;

pub const ListConfigurationManagersInput = struct {
    /// Filters the results returned by the request.
    filters: ?[]const Filter = null,

    /// Specifies the maximum number of configuration managers that are returned by
    /// the
    /// request.
    max_items: ?i32 = null,

    /// The token to use when requesting a specific set of items from a list.
    starting_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_items = "MaxItems",
        .starting_token = "StartingToken",
    };
};

pub const ListConfigurationManagersOutput = struct {
    /// The configuration managers returned by the request.
    configuration_managers_list: ?[]const ConfigurationManagerSummary = null,

    /// The token to use when requesting the next set of configuration managers. If
    /// there
    /// are no additional operations to return, the string is empty.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_managers_list = "ConfigurationManagersList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConfigurationManagersInput, options: CallOptions) !ListConfigurationManagersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-quicksetup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConfigurationManagersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-quicksetup", "SSM QuickSetup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listConfigurationManagers";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_items) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxItems\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.starting_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StartingToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConfigurationManagersOutput {
    var result: ListConfigurationManagersOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListConfigurationManagersOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
