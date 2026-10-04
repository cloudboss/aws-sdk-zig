const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BlacklistEntry = @import("blacklist_entry.zig").BlacklistEntry;

pub const GetBlacklistReportsInput = struct {
    /// A list of IP addresses that you want to retrieve blacklist information
    /// about. You can
    /// only specify the dedicated IP addresses that you use to send email using
    /// Amazon SES or
    /// Amazon Pinpoint.
    blacklist_item_names: []const []const u8,

    pub const json_field_names = .{
        .blacklist_item_names = "BlacklistItemNames",
    };
};

pub const GetBlacklistReportsOutput = struct {
    /// An object that contains information about a blacklist that one of your
    /// dedicated IP
    /// addresses appears on.
    blacklist_report: ?[]const aws.map.MapEntry([]const BlacklistEntry) = null,

    pub const json_field_names = .{
        .blacklist_report = "BlacklistReport",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBlacklistReportsInput, options: CallOptions) !GetBlacklistReportsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBlacklistReportsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/deliverability-dashboard/blacklist-report";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    for (input.blacklist_item_names) |item| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "BlacklistItemNames=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBlacklistReportsOutput {
    const result: GetBlacklistReportsOutput = try aws.json.parseJsonObject(
        GetBlacklistReportsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
