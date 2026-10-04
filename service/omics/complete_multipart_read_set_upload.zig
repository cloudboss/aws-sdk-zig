const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CompleteReadSetUploadPartListItem = @import("complete_read_set_upload_part_list_item.zig").CompleteReadSetUploadPartListItem;

pub const CompleteMultipartReadSetUploadInput = struct {
    /// The individual uploads or parts of a multipart upload.
    parts: []const CompleteReadSetUploadPartListItem,

    /// The sequence store ID for the store involved in the multipart upload.
    sequence_store_id: []const u8,

    /// The ID for the multipart upload.
    upload_id: []const u8,

    pub const json_field_names = .{
        .parts = "parts",
        .sequence_store_id = "sequenceStoreId",
        .upload_id = "uploadId",
    };
};

pub const CompleteMultipartReadSetUploadOutput = struct {
    /// The read set ID created for an uploaded read set.
    read_set_id: []const u8,

    pub const json_field_names = .{
        .read_set_id = "readSetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CompleteMultipartReadSetUploadInput, options: CallOptions) !CompleteMultipartReadSetUploadOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CompleteMultipartReadSetUploadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sequencestore/");
    try path_buf.appendSlice(allocator, input.sequence_store_id);
    try path_buf.appendSlice(allocator, "/upload/");
    try path_buf.appendSlice(allocator, input.upload_id);
    try path_buf.appendSlice(allocator, "/complete");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"parts\":");
    try aws.json.writeValue(@TypeOf(input.parts), input.parts, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CompleteMultipartReadSetUploadOutput {
    var result: CompleteMultipartReadSetUploadOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CompleteMultipartReadSetUploadOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
