const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProfileSummary = @import("profile_summary.zig").ProfileSummary;

pub const ListProfilesInput = struct {
    /// The maximum number of objects that you want to return for this request. If
    /// more objects are available, in the response,
    /// a `NextToken` value, which you can use in a subsequent call to get the next
    /// batch of objects, is provided.
    ///
    /// If you don't specify a value for `MaxResults`, up to 100 objects are
    /// returned.
    max_results: ?i32 = null,

    /// For the first call to this list request, omit this value.
    ///
    /// When you request a list of objects, at most the number of objects specified
    /// by `MaxResults` is returned.
    /// If more objects are available for retrieval, a `NextToken` value is returned
    /// in the response.
    /// To retrieve the next batch of objects, use the token that was returned for
    /// the prior request in your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListProfilesOutput = struct {
    /// If more than `MaxResults` resource associations match the specified
    /// criteria, you can submit another
    /// `ListProfiles` request to get the next group of results. In the next
    /// request, specify the value of `NextToken` from the previous response.
    next_token: ?[]const u8 = null,

    /// Summary information about the Profiles.
    profile_summaries: ?[]const ProfileSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .profile_summaries = "ProfileSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProfilesInput, options: CallOptions) !ListProfilesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53profiles", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProfilesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53profiles", "Route53Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/profiles";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProfilesOutput {
    var result: ListProfilesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListProfilesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
