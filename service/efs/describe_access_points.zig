const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessPointDescription = @import("access_point_description.zig").AccessPointDescription;

pub const DescribeAccessPointsInput = struct {
    /// (Optional) Specifies an EFS access point to describe in the response;
    /// mutually
    /// exclusive with `FileSystemId`.
    access_point_id: ?[]const u8 = null,

    /// (Optional) If you provide a `FileSystemId`, EFS returns all access
    /// points for that file system; mutually exclusive with `AccessPointId`.
    file_system_id: ?[]const u8 = null,

    /// (Optional) When retrieving all access points for a file system,
    /// you can optionally specify the `MaxItems` parameter to limit the number of
    /// objects returned in a response.
    /// The default value is 100.
    max_results: ?i32 = null,

    /// `NextToken` is present if the response is paginated. You can use
    /// `NextMarker` in the subsequent request to fetch the next page of access
    /// point descriptions.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_point_id = "AccessPointId",
        .file_system_id = "FileSystemId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeAccessPointsOutput = struct {
    /// An array of access point descriptions.
    access_points: ?[]const AccessPointDescription = null,

    /// Present if there are more access points than returned in the response.
    /// You can use the NextMarker in the subsequent request to fetch the additional
    /// descriptions.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_points = "AccessPoints",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAccessPointsInput, options: CallOptions) !DescribeAccessPointsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticfilesystem", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAccessPointsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-02-01/access-points";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.access_point_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "AccessPointId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.file_system_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "FileSystemId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAccessPointsOutput {
    const result: DescribeAccessPointsOutput = try aws.json.parseJsonObject(
        DescribeAccessPointsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
