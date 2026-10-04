const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AbortMultipartReadSetUploadInput = struct {
    /// The sequence store ID for the store involved in the multipart upload.
    sequence_store_id: []const u8,

    /// The ID for the multipart upload.
    upload_id: []const u8,

    pub const json_field_names = .{
        .sequence_store_id = "sequenceStoreId",
        .upload_id = "uploadId",
    };
};

pub const AbortMultipartReadSetUploadOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AbortMultipartReadSetUploadInput, options: CallOptions) !AbortMultipartReadSetUploadOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AbortMultipartReadSetUploadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sequencestore/");
    try path_buf.appendSlice(allocator, input.sequence_store_id);
    try path_buf.appendSlice(allocator, "/upload/");
    try path_buf.appendSlice(allocator, input.upload_id);
    try path_buf.appendSlice(allocator, "/abort");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AbortMultipartReadSetUploadOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: AbortMultipartReadSetUploadOutput = .{};

    return result;
}
