const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const DescribeTagsInput = struct {
    /// The ID of the file system whose tag set you want to retrieve.
    file_system_id: []const u8,

    /// (Optional) An opaque pagination token returned from a previous
    /// `DescribeTags` operation (String). If present, it specifies to continue the
    /// list
    /// from where the previous call left off.
    marker: ?[]const u8 = null,

    /// (Optional) The maximum number of file system tags to return in the response.
    /// Currently,
    /// this number is automatically set to
    /// 100, and other values are ignored. The response is paginated at 100 per page
    /// if you have more than 100 tags.
    max_items: ?i32 = null,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .marker = "Marker",
        .max_items = "MaxItems",
    };
};

pub const DescribeTagsOutput = struct {
    /// If the request included a `Marker`, the response returns that value in this
    /// field.
    marker: ?[]const u8 = null,

    /// If a value is present, there are more tags to return. In a subsequent
    /// request, you can
    /// provide the value of `NextMarker` as the value of the `Marker` parameter
    /// in your next request to retrieve the next set of tags.
    next_marker: ?[]const u8 = null,

    /// Returns tags associated with the file system as an array of `Tag` objects.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .next_marker = "NextMarker",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTagsInput, options: CallOptions) !DescribeTagsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTagsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2015-02-01/tags/");
    try path_buf.appendSlice(allocator, input.file_system_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTagsOutput {
    const result: DescribeTagsOutput = try aws.json.parseJsonObject(
        DescribeTagsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
