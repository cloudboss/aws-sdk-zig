const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileSystemDescription = @import("file_system_description.zig").FileSystemDescription;

pub const DescribeFileSystemsInput = struct {
    /// (Optional) Restricts the list to the file system with this creation token
    /// (String). You
    /// specify a creation token when you create an Amazon EFS file system.
    creation_token: ?[]const u8 = null,

    /// (Optional) ID of the file system whose description you want to retrieve
    /// (String).
    file_system_id: ?[]const u8 = null,

    /// (Optional) Opaque pagination token returned from a previous
    /// `DescribeFileSystems` operation (String). If present, specifies to continue
    /// the
    /// list from where the returning call had left off.
    marker: ?[]const u8 = null,

    /// (Optional) Specifies the maximum number of file systems to return in the
    /// response
    /// (integer). This number is automatically set to 100. The response is
    /// paginated at 100 per page if you have more than 100 file systems.
    max_items: ?i32 = null,

    pub const json_field_names = .{
        .creation_token = "CreationToken",
        .file_system_id = "FileSystemId",
        .marker = "Marker",
        .max_items = "MaxItems",
    };
};

pub const DescribeFileSystemsOutput = struct {
    /// An array of file system descriptions.
    file_systems: ?[]const FileSystemDescription = null,

    /// Present if provided by caller in the request (String).
    marker: ?[]const u8 = null,

    /// Present if there are more file systems than returned in the response
    /// (String). You can
    /// use the `NextMarker` in the subsequent request to fetch the descriptions.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_systems = "FileSystems",
        .marker = "Marker",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFileSystemsInput, options: CallOptions) !DescribeFileSystemsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFileSystemsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-02-01/file-systems";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.creation_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "CreationToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.file_system_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "FileSystemId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxItems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFileSystemsOutput {
    var result: DescribeFileSystemsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeFileSystemsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
