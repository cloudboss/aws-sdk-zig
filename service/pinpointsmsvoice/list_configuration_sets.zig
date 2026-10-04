const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListConfigurationSetsInput = struct {
    /// A token returned from a previous call to the API that indicates the position
    /// in the list of results.
    next_token: ?[]const u8 = null,

    /// Used to specify the number of items that should be returned in the response.
    page_size: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .page_size = "PageSize",
    };
};

pub const ListConfigurationSetsOutput = struct {
    /// An object that contains a list of configuration sets for your account in the
    /// current region.
    configuration_sets: ?[]const []const u8 = null,

    /// A token returned from a previous call to ListConfigurationSets to indicate
    /// the position in the list of configuration sets.
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sms-voice", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("sms-voice.pinpoint", "Pinpoint SMS Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/sms-voice/configuration-sets";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.page_size) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "PageSize=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConfigurationSetsOutput {
    var result: ListConfigurationSetsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListConfigurationSetsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
