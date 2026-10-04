const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubscriberResource = @import("subscriber_resource.zig").SubscriberResource;

pub const ListSubscribersInput = struct {
    /// The maximum number of accounts for which the configuration is displayed.
    max_results: ?i32 = null,

    /// If nextToken is returned, there are more results available. You can repeat
    /// the call
    /// using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListSubscribersOutput = struct {
    /// If nextToken is returned, there are more results available. You can repeat
    /// the call
    /// using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// The subscribers available for the specified Security Lake account ID.
    subscribers: ?[]const SubscriberResource = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .subscribers = "subscribers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSubscribersInput, options: CallOptions) !ListSubscribersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securitylake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSubscribersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securitylake", "SecurityLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/subscribers";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSubscribersOutput {
    const result: ListSubscribersOutput = try aws.json.parseJsonObject(
        ListSubscribersOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
