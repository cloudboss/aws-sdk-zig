const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapabilitySummary = @import("capability_summary.zig").CapabilitySummary;

pub const ListCapabilitiesInput = struct {
    /// The name of the Amazon EKS cluster for which you want to list capabilities.
    cluster_name: []const u8,

    /// The maximum number of results to return in a single call. To retrieve the
    /// remaining results, make another call with the returned `nextToken` value. If
    /// you don't specify a value, the default is 100 results.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated request, where
    /// `maxResults` was used and the results exceeded the value of that parameter.
    /// Pagination continues from the end of the previous results that returned the
    /// `nextToken` value. This value is null when there are no more results to
    /// return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListCapabilitiesOutput = struct {
    /// A list of capability summary objects, each containing basic information
    /// about a capability including its name, ARN, type, status, version, and
    /// timestamps.
    capabilities: ?[]const CapabilitySummary = null,

    /// The `nextToken` value to include in a future `ListCapabilities` request.
    /// When the results of a `ListCapabilities` request exceed `maxResults`, you
    /// can use this value to retrieve the next page of results. This value is null
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCapabilitiesInput, options: CallOptions) !ListCapabilitiesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCapabilitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/capabilities");
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCapabilitiesOutput {
    const result: ListCapabilitiesOutput = try aws.json.parseJsonObject(
        ListCapabilitiesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
