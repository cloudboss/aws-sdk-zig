const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Outpost = @import("outpost.zig").Outpost;

pub const ListOutpostsWithS3Input = struct {
    /// The maximum number of Outposts to return. The limit is 100.
    max_results: ?i32 = null,

    /// When you can get additional results from the `ListOutpostsWithS3` call, a
    /// `NextToken` parameter is returned in the output. You can then pass in a
    /// subsequent command to the `NextToken` parameter to continue listing
    /// additional Outposts.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListOutpostsWithS3Output = struct {
    /// Returns a token that you can use to call `ListOutpostsWithS3` again and
    /// receive additional results, if there are any.
    next_token: ?[]const u8 = null,

    /// Returns the list of Outposts that have the following characteristics:
    ///
    /// * outposts that have S3 provisioned
    ///
    /// * outposts that are `Active` (not pending any provisioning nor
    ///   decommissioned)
    ///
    /// * outposts to which the the calling Amazon Web Services account has access
    outposts: ?[]const Outpost = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .outposts = "Outposts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListOutpostsWithS3Input, options: CallOptions) !ListOutpostsWithS3Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3-outposts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListOutpostsWithS3Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-outposts", "S3Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/S3Outposts/ListOutpostsWithS3";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListOutpostsWithS3Output {
    var result: ListOutpostsWithS3Output = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListOutpostsWithS3Output, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
