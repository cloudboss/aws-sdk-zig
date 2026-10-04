const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessPoint = @import("access_point.zig").AccessPoint;
const serde = @import("serde.zig");

pub const ListAccessPointsForDirectoryBucketsInput = struct {
    /// The Amazon Web Services account ID that owns the access points.
    account_id: []const u8,

    /// The name of the directory bucket associated with the access points you want
    /// to list.
    directory_bucket: ?[]const u8 = null,

    /// The maximum number of access points that you would like returned in the
    /// `ListAccessPointsForDirectoryBuckets` response. If the directory bucket is
    /// associated with more than this number of access points, the results include
    /// the pagination token `NextToken`. Make another call using the `NextToken` to
    /// retrieve more results.
    max_results: ?i32 = null,

    /// If `NextToken` is returned, there are more access points available than
    /// requested in the `maxResults` value. The value of `NextToken` is a
    /// unique pagination token for each page. Make the call again using the
    /// returned token to
    /// retrieve the next page. Keep all other arguments unchanged. Each pagination
    /// token expires
    /// after 24 hours.
    next_token: ?[]const u8 = null,
};

pub const ListAccessPointsForDirectoryBucketsOutput = struct {
    /// Contains identification and configuration information for one or more access
    /// points associated with the directory bucket.
    access_point_list: ?[]const AccessPoint = null,

    /// If `NextToken` is returned, there are more access points available than
    /// requested in the `maxResults` value. The value of `NextToken` is a
    /// unique pagination token for each page. Make the call again using the
    /// returned token to
    /// retrieve the next page. Keep all other arguments unchanged. Each pagination
    /// token expires
    /// after 24 hours.
    next_token: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAccessPointsForDirectoryBucketsInput, options: CallOptions) !ListAccessPointsForDirectoryBucketsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAccessPointsForDirectoryBucketsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v20180820/accesspointfordirectory";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.directory_bucket) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "directoryBucket=");
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
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAccessPointsForDirectoryBucketsOutput {
    var result: ListAccessPointsForDirectoryBucketsOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessPointList")) {
                    result.access_point_list = try serde.deserializeAccessPointList(allocator, &reader, "AccessPoint");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}
