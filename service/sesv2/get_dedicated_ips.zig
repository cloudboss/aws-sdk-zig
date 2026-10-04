const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DedicatedIp = @import("dedicated_ip.zig").DedicatedIp;

pub const GetDedicatedIpsInput = struct {
    /// A token returned from a previous call to `GetDedicatedIps` to indicate the
    /// position of the dedicated IP pool in the list of IP pools.
    next_token: ?[]const u8 = null,

    /// The number of results to show in a single call to `GetDedicatedIpsRequest`.
    /// If the number of results is larger than the number you specified in this
    /// parameter, then
    /// the response includes a `NextToken` element, which you can use to obtain
    /// additional results.
    page_size: ?i32 = null,

    /// The name of the IP pool that the dedicated IP address is associated with.
    pool_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .page_size = "PageSize",
        .pool_name = "PoolName",
    };
};

pub const GetDedicatedIpsOutput = struct {
    /// A list of dedicated IP addresses that are associated with your Amazon Web
    /// Services account.
    dedicated_ips: ?[]const DedicatedIp = null,

    /// A token that indicates that there are additional dedicated IP addresses to
    /// list. To
    /// view additional addresses, issue another request to `GetDedicatedIps`,
    /// passing this token in the `NextToken` parameter.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .dedicated_ips = "DedicatedIps",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDedicatedIpsInput, options: CallOptions) !GetDedicatedIpsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDedicatedIpsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/dedicated-ips";

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
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.pool_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "PoolName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDedicatedIpsOutput {
    const result: GetDedicatedIpsOutput = try aws.json.parseJsonObject(
        GetDedicatedIpsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
