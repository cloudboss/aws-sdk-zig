const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListConfigurationSetsInput = struct {
    /// An object that contains filters to apply when listing configuration sets.
    /// You can filter by configuration set name.
    filter: ?[]const aws.map.StringMapEntry = null,

    /// A token returned from a previous call to `ListConfigurationSets` to
    /// indicate the position in the list of configuration sets.
    next_token: ?[]const u8 = null,

    /// The number of results to show in a single call to `ListConfigurationSets`.
    /// If the number of results is larger than the number you specified in this
    /// parameter, then
    /// the response includes a `NextToken` element, which you can use to obtain
    /// additional results.
    page_size: ?i32 = null,

    pub const json_field_names = .{
        .filter = "Filter",
        .next_token = "NextToken",
        .page_size = "PageSize",
    };
};

pub const ListConfigurationSetsOutput = struct {
    /// An array that contains all of the configuration sets in your Amazon SES
    /// account in the
    /// current Amazon Web Services Region.
    configuration_sets: ?[]const []const u8 = null,

    /// A token that indicates that there are additional configuration sets to list.
    /// To view
    /// additional configuration sets, issue another request to
    /// `ListConfigurationSets`, and pass this token in the
    /// `NextToken` parameter.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_sets = "ConfigurationSets",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConfigurationSetsInput, options: CallOptions) !ListConfigurationSetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConfigurationSetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/list-configuration-sets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.page_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PageSize\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConfigurationSetsOutput {
    const result: ListConfigurationSetsOutput = try aws.json.parseJsonObject(
        ListConfigurationSetsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
