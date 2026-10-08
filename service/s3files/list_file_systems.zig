const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListFileSystemsDescription = @import("list_file_systems_description.zig").ListFileSystemsDescription;

pub const ListFileSystemsInput = struct {
    /// Optional filter to list only file systems associated with the specified S3
    /// bucket Amazon Resource Name (ARN). If provided, only file systems that
    /// provide access to this bucket will be returned in the response.
    bucket: ?[]const u8 = null,

    /// The maximum number of file systems to return in a single response. If not
    /// specified, up to 100 file systems are returned.
    max_results: ?i32 = null,

    /// A pagination token returned from a previous call to continue listing file
    /// systems.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListFileSystemsOutput = struct {
    /// An array of file system descriptions.
    file_systems: ?[]const ListFileSystemsDescription = null,

    /// A pagination token to use in a subsequent request if more results are
    /// available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_systems = "fileSystems",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFileSystemsInput, options: CallOptions) !ListFileSystemsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3files", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFileSystemsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3files", "S3Files", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/file-systems";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.bucket) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "bucket=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFileSystemsOutput {
    const result: ListFileSystemsOutput = try aws.json.parseJsonObject(
        ListFileSystemsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
