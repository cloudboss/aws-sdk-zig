const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SigningPlatform = @import("signing_platform.zig").SigningPlatform;

pub const ListSigningPlatformsInput = struct {
    /// The category type of a signing platform.
    category: ?[]const u8 = null,

    /// The maximum number of results to be returned by this operation.
    max_results: ?i32 = null,

    /// Value for specifying the next set of paginated results to return. After you
    /// receive a
    /// response with truncated results, use this parameter in a subsequent request.
    /// Set it to
    /// the value of `nextToken` from the response that you just received.
    next_token: ?[]const u8 = null,

    /// Any partner entities connected to a signing platform.
    partner: ?[]const u8 = null,

    /// The validation template that is used by the target signing platform.
    target: ?[]const u8 = null,

    pub const json_field_names = .{
        .category = "category",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .partner = "partner",
        .target = "target",
    };
};

pub const ListSigningPlatformsOutput = struct {
    /// Value for specifying the next set of paginated results to return.
    next_token: ?[]const u8 = null,

    /// A list of all platforms that match the request parameters.
    platforms: ?[]const SigningPlatform = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .platforms = "platforms",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSigningPlatformsInput, options: CallOptions) !ListSigningPlatformsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "signer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSigningPlatformsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signer", "signer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/signing-platforms";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.category) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "category=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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
    if (input.partner) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "partner=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.target) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "target=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSigningPlatformsOutput {
    const result: ListSigningPlatformsOutput = try aws.json.parseJsonObject(
        ListSigningPlatformsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
