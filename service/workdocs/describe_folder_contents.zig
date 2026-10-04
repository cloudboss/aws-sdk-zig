const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OrderType = @import("order_type.zig").OrderType;
const ResourceSortType = @import("resource_sort_type.zig").ResourceSortType;
const FolderContentType = @import("folder_content_type.zig").FolderContentType;
const DocumentMetadata = @import("document_metadata.zig").DocumentMetadata;
const FolderMetadata = @import("folder_metadata.zig").FolderMetadata;

pub const DescribeFolderContentsInput = struct {
    /// Amazon WorkDocs authentication token. Not required when using Amazon Web
    /// Services administrator credentials to access the API.
    authentication_token: ?[]const u8 = null,

    /// The ID of the folder.
    folder_id: []const u8,

    /// The contents to include. Specify "INITIALIZED" to include initialized
    /// documents.
    include: ?[]const u8 = null,

    /// The maximum number of items to return with this call.
    limit: ?i32 = null,

    /// The marker for the next set of results. This marker was received from a
    /// previous
    /// call.
    marker: ?[]const u8 = null,

    /// The order for the contents of the folder.
    order: ?OrderType = null,

    /// The sorting criteria.
    sort: ?ResourceSortType = null,

    /// The type of items.
    @"type": ?FolderContentType = null,

    pub const json_field_names = .{
        .authentication_token = "AuthenticationToken",
        .folder_id = "FolderId",
        .include = "Include",
        .limit = "Limit",
        .marker = "Marker",
        .order = "Order",
        .sort = "Sort",
        .@"type" = "Type",
    };
};

pub const DescribeFolderContentsOutput = struct {
    /// The documents in the specified folder.
    documents: ?[]const DocumentMetadata = null,

    /// The subfolders in the specified folder.
    folders: ?[]const FolderMetadata = null,

    /// The marker to use when requesting the next set of results. If there are no
    /// additional results, the string is empty.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .documents = "Documents",
        .folders = "Folders",
        .marker = "Marker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFolderContentsInput, options: CallOptions) !DescribeFolderContentsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workdocs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFolderContentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workdocs", "WorkDocs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/v1/folders/");
    try path_buf.appendSlice(allocator, input.folder_id);
    try path_buf.appendSlice(allocator, "/contents");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "include=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.limit) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "limit=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.order) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "order=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.sort) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sort=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.@"type") |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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
    if (input.authentication_token) |v| {
        try request.headers.put(allocator, "Authentication", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFolderContentsOutput {
    const result: DescribeFolderContentsOutput = try aws.json.parseJsonObject(
        DescribeFolderContentsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
