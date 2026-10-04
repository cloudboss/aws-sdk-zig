const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PackageVersionHistory = @import("package_version_history.zig").PackageVersionHistory;

pub const GetPackageVersionHistoryInput = struct {
    /// An optional parameter that specifies the maximum number of results to
    /// return. You can use
    /// `nextToken` to get the next page of results.
    max_results: ?i32 = null,

    /// If your initial `GetPackageVersionHistory` operation returns a
    /// `nextToken`, you can include the returned `nextToken` in subsequent
    /// `GetPackageVersionHistory` operations, which returns results in the next
    /// page.
    next_token: ?[]const u8 = null,

    /// The unique identifier of the package.
    package_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .package_id = "PackageID",
    };
};

pub const GetPackageVersionHistoryOutput = struct {
    /// When `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page. Send the request
    /// again using
    /// the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// The unique identifier of the package.
    package_id: ?[]const u8 = null,

    /// A list of package versions, along with their creation time and commit
    /// message.
    package_version_history_list: ?[]const PackageVersionHistory = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .package_id = "PackageID",
        .package_version_history_list = "PackageVersionHistoryList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPackageVersionHistoryInput, options: CallOptions) !GetPackageVersionHistoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPackageVersionHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/packages/");
    try path_buf.appendSlice(allocator, input.package_id);
    try path_buf.appendSlice(allocator, "/history");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPackageVersionHistoryOutput {
    var result: GetPackageVersionHistoryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetPackageVersionHistoryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
