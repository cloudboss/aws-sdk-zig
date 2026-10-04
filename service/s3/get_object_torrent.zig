const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const RequestCharged = @import("request_charged.zig").RequestCharged;

pub const GetObjectTorrentInput = struct {
    /// The name of the bucket containing the object for which to get the torrent
    /// files.
    bucket: []const u8,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// The object key for which to get the information.
    key: []const u8,

    request_payer: ?RequestPayer = null,
};

pub const GetObjectTorrentOutput = struct {
    /// A Bencoded dictionary as defined by the BitTorrent specification
    body: ?aws.http.StreamingBody = null,

    request_charged: ?RequestCharged = null,

    pub fn deinit(self: *GetObjectTorrentOutput) void {
        if (self.body) |*b| b.deinit();
    }
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetObjectTorrentInput, options: CallOptions) !GetObjectTorrentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetObjectTorrentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.key);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "torrent");
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
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
    }
    if (input.request_payer) |v| {
        try request.headers.put(allocator, "x-amz-request-payer", v.wireName());
    }

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetObjectTorrentOutput {
    _ = allocator;
    var result: GetObjectTorrentOutput = .{};
    result.body = stream_resp.body;
    if (stream_resp.headers.get("x-amz-request-charged")) |value| {
        result.request_charged = RequestCharged.fromWireName(value);
    }
    stream_resp.deinitHeaders();

    return result;
}
