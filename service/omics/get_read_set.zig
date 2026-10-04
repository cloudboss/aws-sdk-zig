const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReadSetFile = @import("read_set_file.zig").ReadSetFile;

pub const GetReadSetInput = struct {
    /// The file to retrieve.
    file: ?ReadSetFile = null,

    /// The read set's ID.
    id: []const u8,

    /// The part number to retrieve.
    part_number: i32,

    /// The read set's sequence store ID.
    sequence_store_id: []const u8,

    pub const json_field_names = .{
        .file = "file",
        .id = "id",
        .part_number = "partNumber",
        .sequence_store_id = "sequenceStoreId",
    };
};

pub const GetReadSetOutput = struct {
    /// The read set file payload.
    payload: ?aws.http.StreamingBody = null,

    pub fn deinit(self: *GetReadSetOutput) void {
        if (self.payload) |*b| b.deinit();
    }

    pub const json_field_names = .{
        .payload = "payload",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetReadSetInput, options: CallOptions) !GetReadSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    errdefer stream_resp.deinit();
    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetReadSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sequencestore/");
    try path_buf.appendSlice(allocator, input.sequence_store_id);
    try path_buf.appendSlice(allocator, "/readset/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.file) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "file=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "partNumber=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.part_number}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
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

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetReadSetOutput {
    _ = allocator;
    var result: GetReadSetOutput = .{};
    result.payload = stream_resp.body;
    stream_resp.deinitHeaders();

    return result;
}
