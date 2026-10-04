const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteCustomMetadataInput = struct {
    /// Amazon WorkDocs authentication token. Not required when using Amazon Web
    /// Services administrator credentials to access the API.
    authentication_token: ?[]const u8 = null,

    /// Flag to indicate removal of all custom metadata properties from the
    /// specified
    /// resource.
    delete_all: ?bool = null,

    /// List of properties to remove.
    keys: ?[]const []const u8 = null,

    /// The ID of the resource, either a document or folder.
    resource_id: []const u8,

    /// The ID of the version, if the custom metadata is being deleted from a
    /// document
    /// version.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication_token = "AuthenticationToken",
        .delete_all = "DeleteAll",
        .keys = "Keys",
        .resource_id = "ResourceId",
        .version_id = "VersionId",
    };
};

pub const DeleteCustomMetadataOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteCustomMetadataInput, options: CallOptions) !DeleteCustomMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteCustomMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workdocs", "WorkDocs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/v1/resources/");
    try path_buf.appendSlice(allocator, input.resource_id);
    try path_buf.appendSlice(allocator, "/customMetadata");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.delete_all) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "deleteAll=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.keys) |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "keys=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item);
            query_has_prev = true;
        }
    }
    if (input.version_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "versionId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteCustomMetadataOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteCustomMetadataOutput = .{};

    return result;
}
