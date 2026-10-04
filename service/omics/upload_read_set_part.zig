const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReadSetPartSource = @import("read_set_part_source.zig").ReadSetPartSource;

pub const UploadReadSetPartInput = struct {
    /// The number of the part being uploaded.
    part_number: i32,

    /// The source file for an upload part.
    part_source: ReadSetPartSource,

    /// The read set data to upload for a part.
    payload: []const u8,

    /// The Sequence Store ID used for the multipart upload.
    sequence_store_id: []const u8,

    /// The ID for the initiated multipart upload.
    upload_id: []const u8,

    pub const json_field_names = .{
        .part_number = "partNumber",
        .part_source = "partSource",
        .payload = "payload",
        .sequence_store_id = "sequenceStoreId",
        .upload_id = "uploadId",
    };
};

pub const UploadReadSetPartOutput = struct {
    /// An identifier used to confirm that parts are being added to the intended
    /// upload.
    checksum: []const u8,

    pub const json_field_names = .{
        .checksum = "checksum",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UploadReadSetPartInput, options: CallOptions) !UploadReadSetPartOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UploadReadSetPartInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sequencestore/");
    try path_buf.appendSlice(allocator, input.sequence_store_id);
    try path_buf.appendSlice(allocator, "/upload/");
    try path_buf.appendSlice(allocator, input.upload_id);
    try path_buf.appendSlice(allocator, "/part");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "partNumber=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.part_number}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "partSource=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.part_source.wireName());
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body = input.payload;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UploadReadSetPartOutput {
    const result: UploadReadSetPartOutput = try aws.json.parseJsonObject(
        UploadReadSetPartOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
