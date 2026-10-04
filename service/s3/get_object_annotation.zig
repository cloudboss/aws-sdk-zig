const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChecksumMode = @import("checksum_mode.zig").ChecksumMode;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const ChecksumType = @import("checksum_type.zig").ChecksumType;
const ReplicationStatus = @import("replication_status.zig").ReplicationStatus;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;

pub const GetObjectAnnotationInput = struct {
    /// The name of the annotation to retrieve.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 512 bytes.
    annotation_name: []const u8,

    /// The name of the bucket that contains the object.
    bucket: []const u8,

    /// Set to `ENABLED` to validate the checksum of the annotation payload on
    /// retrieval.
    checksum_mode: ?ChecksumMode = null,

    /// The account ID of the expected bucket owner. If the bucket is owned by a
    /// different account, the request fails with an HTTP 403 (Access Denied) error.
    expected_bucket_owner: ?[]const u8 = null,

    /// The object key.
    key: []const u8,

    request_payer: ?RequestPayer = null,

    /// The version ID of the object.
    version_id: ?[]const u8 = null,
};

pub const GetObjectAnnotationOutput = struct {
    /// The annotation payload.
    annotation_payload: ?aws.http.StreamingBody = null,

    /// The CRC32 checksum of the annotation payload.
    checksum_crc32: ?[]const u8 = null,

    /// The CRC32C checksum of the annotation payload.
    checksum_crc32_c: ?[]const u8 = null,

    /// The CRC64NVME checksum of the annotation payload.
    checksum_crc64_nvme: ?[]const u8 = null,

    /// The MD5 checksum of the annotation payload.
    checksum_md5: ?[]const u8 = null,

    /// The SHA1 checksum of the annotation payload.
    checksum_sha1: ?[]const u8 = null,

    /// The SHA256 checksum of the annotation payload.
    checksum_sha256: ?[]const u8 = null,

    /// The SHA512 checksum of the annotation payload.
    checksum_sha512: ?[]const u8 = null,

    /// The type of checksum used.
    checksum_type: ?ChecksumType = null,

    /// The XXHASH128 checksum of the annotation payload.
    checksum_xxhash128: ?[]const u8 = null,

    /// The XXHASH3 checksum of the annotation payload.
    checksum_xxhash3: ?[]const u8 = null,

    /// The XXHASH64 checksum of the annotation payload.
    checksum_xxhash64: ?[]const u8 = null,

    /// The size of the annotation payload, in bytes.
    content_length: ?i64 = null,

    /// The entity tag of the annotation.
    e_tag: ?[]const u8 = null,

    /// The date and time the annotation was last modified.
    last_modified: ?i64 = null,

    /// The version ID of the object that the annotation is attached to.
    object_version_id: ?[]const u8 = null,

    /// The replication status of the annotation. Possible values include `PENDING`,
    /// `COMPLETED`, `FAILED`, and `REPLICA`.
    replication_status: ?ReplicationStatus = null,

    request_charged: ?RequestCharged = null,

    /// The server-side encryption algorithm used.
    server_side_encryption: ?ServerSideEncryption = null,

    pub fn deinit(self: *GetObjectAnnotationOutput) void {
        if (self.annotation_payload) |*b| b.deinit();
    }
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetObjectAnnotationInput, options: CallOptions) !GetObjectAnnotationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetObjectAnnotationInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(allocator, "annotation&x-id=GetObjectAnnotation");
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "annotationName=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.annotation_name);
    query_has_prev = true;
    if (input.version_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "versionId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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
    if (input.checksum_mode) |v| {
        try request.headers.put(allocator, "x-amz-checksum-mode", v.wireName());
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
    }
    if (input.request_payer) |v| {
        try request.headers.put(allocator, "x-amz-request-payer", v.wireName());
    }

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetObjectAnnotationOutput {
    var result: GetObjectAnnotationOutput = .{};
    result.annotation_payload = stream_resp.body;
    if (stream_resp.headers.get("x-amz-checksum-crc32")) |value| {
        result.checksum_crc32 = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-crc32c")) |value| {
        result.checksum_crc32_c = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-crc64nvme")) |value| {
        result.checksum_crc64_nvme = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-md5")) |value| {
        result.checksum_md5 = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-sha1")) |value| {
        result.checksum_sha1 = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-sha256")) |value| {
        result.checksum_sha256 = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-sha512")) |value| {
        result.checksum_sha512 = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-type")) |value| {
        result.checksum_type = ChecksumType.fromWireName(value);
    }
    if (stream_resp.headers.get("x-amz-checksum-xxhash128")) |value| {
        result.checksum_xxhash128 = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-xxhash3")) |value| {
        result.checksum_xxhash3 = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-checksum-xxhash64")) |value| {
        result.checksum_xxhash64 = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-length")) |value| {
        result.content_length = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (stream_resp.headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("last-modified")) |value| {
        result.last_modified = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (stream_resp.headers.get("x-amz-object-version-id")) |value| {
        result.object_version_id = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-replication-status")) |value| {
        result.replication_status = ReplicationStatus.fromWireName(value);
    }
    if (stream_resp.headers.get("x-amz-request-charged")) |value| {
        result.request_charged = RequestCharged.fromWireName(value);
    }
    if (stream_resp.headers.get("x-amz-server-side-encryption")) |value| {
        result.server_side_encryption = ServerSideEncryption.fromWireName(value);
    }
    stream_resp.deinitHeaders();

    return result;
}
