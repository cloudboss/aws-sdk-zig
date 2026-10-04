const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListUpdatesInput = struct {
    /// The names of the installed add-ons that have available updates.
    addon_name: ?[]const u8 = null,

    /// The name of the capability for which you want to list updates.
    capability_name: ?[]const u8 = null,

    /// The maximum number of results, returned in paginated output. You receive
    /// `maxResults` in a single page, along with a `nextToken`
    /// response element. You can see the remaining results of the initial request
    /// by sending
    /// another request with the returned `nextToken` value. This value can be
    /// between 1 and 100. If you don't use this parameter,
    /// 100 results and a `nextToken` value, if applicable, are
    /// returned.
    max_results: ?i32 = null,

    /// The name of the Amazon EKS cluster to list updates for.
    name: []const u8,

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

    /// The name of the Amazon EKS managed node group to list updates for.
    nodegroup_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .addon_name = "addonName",
        .capability_name = "capabilityName",
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .nodegroup_name = "nodegroupName",
    };
};

pub const ListUpdatesOutput = struct {
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

    /// A list of all the updates for the specified cluster and Region.
    update_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .update_ids = "updateIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListUpdatesInput, options: CallOptions) !ListUpdatesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListUpdatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/updates");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.addon_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "addonName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.capability_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "capabilityName=");
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
    if (input.nodegroup_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nodegroupName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListUpdatesOutput {
    const result: ListUpdatesOutput = try aws.json.parseJsonObject(
        ListUpdatesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
