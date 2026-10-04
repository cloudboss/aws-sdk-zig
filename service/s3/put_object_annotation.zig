const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const ChecksumType = @import("checksum_type.zig").ChecksumType;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;

pub const PutObjectAnnotationInput = struct {
    /// The name of the annotation.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 512 bytes.
    annotation_name: []const u8,

    /// The annotation payload. Must be between 1 byte and 1 MiB in size, and must
    /// be valid UTF-8
    /// encoded text. If the payload contains invalid UTF-8 bytes, the request fails
    /// with HTTP 415
    /// (Unsupported Media Type). To store binary data, encode the payload using
    /// Base64 before
    /// uploading.
    annotation_payload: []const u8,

    /// The name of the bucket that contains the object.
    bucket: []const u8,

    /// The checksum algorithm to use. Supported values: `CRC32`, `CRC32C`,
    /// `CRC64NVME`, `SHA1`, `SHA256`, `SHA512`, `MD5`, `XXHASH64`, `XXHASH3`,
    /// `XXHASH128`.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// Base64-encoded CRC32 checksum of the annotation payload.
    checksum_crc32: ?[]const u8 = null,

    /// Base64-encoded CRC32C checksum of the annotation payload.
    checksum_crc32_c: ?[]const u8 = null,

    /// Base64-encoded CRC64NVME checksum of the annotation payload.
    checksum_crc64_nvme: ?[]const u8 = null,

    /// Base64-encoded MD5 checksum of the annotation payload.
    checksum_md5: ?[]const u8 = null,

    /// Base64-encoded SHA1 checksum of the annotation payload.
    checksum_sha1: ?[]const u8 = null,

    /// Base64-encoded SHA256 checksum of the annotation payload.
    checksum_sha256: ?[]const u8 = null,

    /// Base64-encoded SHA512 checksum of the annotation payload.
    checksum_sha512: ?[]const u8 = null,

    /// Base64-encoded XXHASH128 checksum of the annotation payload.
    checksum_xxhash128: ?[]const u8 = null,

    /// Base64-encoded XXHASH3 checksum of the annotation payload.
    checksum_xxhash3: ?[]const u8 = null,

    /// Base64-encoded XXHASH64 checksum of the annotation payload.
    checksum_xxhash64: ?[]const u8 = null,

    /// Base64-encoded MD5 digest of the message.
    content_md5: ?[]const u8 = null,

    /// The account ID of the expected bucket owner. If the bucket is owned by a
    /// different account, the request fails with an HTTP 403 (Access Denied) error.
    expected_bucket_owner: ?[]const u8 = null,

    /// The object key.
    key: []const u8,

    /// If specified, the operation only succeeds if the object's ETag matches the
    /// provided value.
    object_if_match: ?[]const u8 = null,

    request_payer: ?RequestPayer = null,

    /// The version ID of the object to attach the annotation to.
    version_id: ?[]const u8 = null,
};

pub const PutObjectAnnotationOutput = struct {
    /// The name of the annotation.
    annotation_name: ?[]const u8 = null,

    /// The CRC32 checksum of the stored annotation.
    checksum_crc32: ?[]const u8 = null,

    /// The CRC32C checksum of the stored annotation.
    checksum_crc32_c: ?[]const u8 = null,

    /// The CRC64NVME checksum of the stored annotation.
    checksum_crc64_nvme: ?[]const u8 = null,

    /// The MD5 checksum of the stored annotation.
    checksum_md5: ?[]const u8 = null,

    /// The SHA1 checksum of the stored annotation.
    checksum_sha1: ?[]const u8 = null,

    /// The SHA256 checksum of the stored annotation.
    checksum_sha256: ?[]const u8 = null,

    /// The SHA512 checksum of the stored annotation.
    checksum_sha512: ?[]const u8 = null,

    /// The type of checksum used.
    checksum_type: ?ChecksumType = null,

    /// The XXHASH128 checksum of the stored annotation.
    checksum_xxhash128: ?[]const u8 = null,

    /// The XXHASH3 checksum of the stored annotation.
    checksum_xxhash3: ?[]const u8 = null,

    /// The XXHASH64 checksum of the stored annotation.
    checksum_xxhash64: ?[]const u8 = null,

    /// The entity tag of the annotation.
    e_tag: ?[]const u8 = null,

    /// The object key.
    key: ?[]const u8 = null,

    /// The version ID of the object that the annotation was attached to.
    object_version_id: ?[]const u8 = null,

    request_charged: ?RequestCharged = null,

    /// The server-side encryption algorithm used to encrypt the annotation.
    server_side_encryption: ?ServerSideEncryption = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutObjectAnnotationInput, options: CallOptions) !PutObjectAnnotationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutObjectAnnotationInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(allocator, "annotation");
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

    const body = input.annotation_payload;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    if (input.checksum_algorithm) |v| {
        try request.headers.put(allocator, "x-amz-sdk-checksum-algorithm", v.wireName());
    }
    if (input.checksum_crc32) |v| {
        try request.headers.put(allocator, "x-amz-checksum-crc32", v);
    }
    if (input.checksum_crc32_c) |v| {
        try request.headers.put(allocator, "x-amz-checksum-crc32c", v);
    }
    if (input.checksum_crc64_nvme) |v| {
        try request.headers.put(allocator, "x-amz-checksum-crc64nvme", v);
    }
    if (input.checksum_md5) |v| {
        try request.headers.put(allocator, "x-amz-checksum-md5", v);
    }
    if (input.checksum_sha1) |v| {
        try request.headers.put(allocator, "x-amz-checksum-sha1", v);
    }
    if (input.checksum_sha256) |v| {
        try request.headers.put(allocator, "x-amz-checksum-sha256", v);
    }
    if (input.checksum_sha512) |v| {
        try request.headers.put(allocator, "x-amz-checksum-sha512", v);
    }
    if (input.checksum_xxhash128) |v| {
        try request.headers.put(allocator, "x-amz-checksum-xxhash128", v);
    }
    if (input.checksum_xxhash3) |v| {
        try request.headers.put(allocator, "x-amz-checksum-xxhash3", v);
    }
    if (input.checksum_xxhash64) |v| {
        try request.headers.put(allocator, "x-amz-checksum-xxhash64", v);
    }
    if (input.content_md5) |v| {
        try request.headers.put(allocator, "Content-MD5", v);
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
    }
    if (input.object_if_match) |v| {
        try request.headers.put(allocator, "x-amz-object-if-match", v);
    }
    if (input.request_payer) |v| {
        try request.headers.put(allocator, "x-amz-request-payer", v.wireName());
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutObjectAnnotationOutput {
    var result: PutObjectAnnotationOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnnotationName")) {
                    result.annotation_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("x-amz-checksum-crc32")) |value| {
        result.checksum_crc32 = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-crc32c")) |value| {
        result.checksum_crc32_c = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-crc64nvme")) |value| {
        result.checksum_crc64_nvme = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-md5")) |value| {
        result.checksum_md5 = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-sha1")) |value| {
        result.checksum_sha1 = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-sha256")) |value| {
        result.checksum_sha256 = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-sha512")) |value| {
        result.checksum_sha512 = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-type")) |value| {
        result.checksum_type = ChecksumType.fromWireName(value);
    }
    if (headers.get("x-amz-checksum-xxhash128")) |value| {
        result.checksum_xxhash128 = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-xxhash3")) |value| {
        result.checksum_xxhash3 = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-xxhash64")) |value| {
        result.checksum_xxhash64 = try allocator.dupe(u8, value);
    }
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-object-version-id")) |value| {
        result.object_version_id = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = RequestCharged.fromWireName(value);
    }
    if (headers.get("x-amz-server-side-encryption")) |value| {
        result.server_side_encryption = ServerSideEncryption.fromWireName(value);
    }

    return result;
}
