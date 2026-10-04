const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FolderMetadata = @import("folder_metadata.zig").FolderMetadata;

pub const GetFolderInput = struct {
    /// Amazon WorkDocs authentication token. Not required when using Amazon Web
    /// Services administrator credentials to access the API.
    authentication_token: ?[]const u8 = null,

    /// The ID of the folder.
    folder_id: []const u8,

    /// Set to TRUE to include custom metadata in the response.
    include_custom_metadata: ?bool = null,

    pub const json_field_names = .{
        .authentication_token = "AuthenticationToken",
        .folder_id = "FolderId",
        .include_custom_metadata = "IncludeCustomMetadata",
    };
};

pub const GetFolderOutput = struct {
    /// The custom metadata on the folder.
    custom_metadata: ?[]const aws.map.StringMapEntry = null,

    /// The metadata of the folder.
    metadata: ?FolderMetadata = null,

    pub const json_field_names = .{
        .custom_metadata = "CustomMetadata",
        .metadata = "Metadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFolderInput, options: CallOptions) !GetFolderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFolderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workdocs", "WorkDocs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/v1/folders/");
    try path_buf.appendSlice(allocator, input.folder_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_custom_metadata) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeCustomMetadata=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFolderOutput {
    var result: GetFolderOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetFolderOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
