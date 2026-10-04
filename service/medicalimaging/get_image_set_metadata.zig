const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetImageSetMetadataInput = struct {
    /// The data store identifier.
    datastore_id: []const u8,

    /// The image set identifier.
    image_set_id: []const u8,

    /// The image set version identifier.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .datastore_id = "datastoreId",
        .image_set_id = "imageSetId",
        .version_id = "versionId",
    };
};

pub const GetImageSetMetadataOutput = struct {
    /// The compression format in which image set metadata attributes are returned.
    content_encoding: ?[]const u8 = null,

    /// The format in which the study metadata is returned to the customer. Default
    /// is `text/plain`.
    content_type: ?[]const u8 = null,

    /// The blob containing the aggregated metadata information for the image set.
    image_set_metadata_blob: aws.http.StreamingBody = undefined,

    pub fn deinit(self: *GetImageSetMetadataOutput) void {
        self.image_set_metadata_blob.deinit();
    }

    pub const json_field_names = .{
        .content_encoding = "contentEncoding",
        .content_type = "contentType",
        .image_set_metadata_blob = "imageSetMetadataBlob",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetImageSetMetadataInput, options: CallOptions) !GetImageSetMetadataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medical-imaging", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetImageSetMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medical-imaging", "Medical Imaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datastore/");
    try path_buf.appendSlice(allocator, input.datastore_id);
    try path_buf.appendSlice(allocator, "/imageSet/");
    try path_buf.appendSlice(allocator, input.image_set_id);
    try path_buf.appendSlice(allocator, "/getImageSetMetadata");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.version_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "version=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetImageSetMetadataOutput {
    var result: GetImageSetMetadataOutput = .{};
    result.image_set_metadata_blob = stream_resp.body;
    if (stream_resp.headers.get("content-encoding")) |value| {
        result.content_encoding = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    stream_resp.deinitHeaders();

    return result;
}
