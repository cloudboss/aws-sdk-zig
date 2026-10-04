const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListAccessEntriesInput = struct {
    /// The ARN of an `AccessPolicy`. When you specify an access policy ARN,
    /// only the access entries associated to that access policy are returned. For a
    /// list of
    /// available policy ARNs, use `ListAccessPolicies`.
    associated_policy_arn: ?[]const u8 = null,

    /// The name of your cluster.
    cluster_name: []const u8,

    /// The maximum number of results, returned in paginated output. You receive
    /// `maxResults` in a single page, along with a `nextToken`
    /// response element. You can see the remaining results of the initial request
    /// by sending
    /// another request with the returned `nextToken` value. This value can be
    /// between 1 and 100. If you don't use this parameter,
    /// 100 results and a `nextToken` value, if applicable, are
    /// returned.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated request, where
    /// `maxResults` was used and
    /// the results exceeded the value of that parameter. Pagination continues from
    /// the end of
    /// the previous results that returned the `nextToken` value. This value is null
    /// when there are no more results to return.
    ///
    /// This token should be treated as an opaque identifier that is used only to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .associated_policy_arn = "associatedPolicyArn",
        .cluster_name = "clusterName",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListAccessEntriesOutput = struct {
    /// The list of access entries that exist for the cluster.
    access_entries: ?[]const []const u8 = null,

    /// The `nextToken` value returned from a previous paginated request, where
    /// `maxResults` was used and
    /// the results exceeded the value of that parameter. Pagination continues from
    /// the end of
    /// the previous results that returned the `nextToken` value. This value is null
    /// when there are no more results to return.
    ///
    /// This token should be treated as an opaque identifier that is used only to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_entries = "accessEntries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAccessEntriesInput, options: CallOptions) !ListAccessEntriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAccessEntriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/access-entries");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.associated_policy_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "associatedPolicyArn=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAccessEntriesOutput {
    const result: ListAccessEntriesOutput = try aws.json.parseJsonObject(
        ListAccessEntriesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
