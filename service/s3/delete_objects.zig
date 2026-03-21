const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const Delete = @import("delete.zig").Delete;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const DeletedObject = @import("deleted_object.zig").DeletedObject;
const Error = @import("error.zig").Error;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const serde = @import("serde.zig");

pub const DeleteObjectsInput = struct {
    /// The bucket name containing the objects to delete.
    ///
    /// **Directory buckets** - When you use this operation with a directory bucket,
    /// you must use virtual-hosted-style requests in the format `
    /// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`. Path-style
    /// requests are not supported. Directory bucket names must be unique in the
    /// chosen Zone (Availability Zone or Local Zone). Bucket names must follow the
    /// format `
    /// *bucket-base-name*--*zone-id*--x-s3` (for example, `
    /// *amzn-s3-demo-bucket*--*usw2-az1*--x-s3`). For information about bucket
    /// naming
    /// restrictions, see [Directory bucket naming
    /// rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-bucket-naming-rules.html) in the *Amazon S3 User Guide*.
    ///
    /// **Access points** - When you use this action with an access point for
    /// general purpose buckets, you must provide the alias of the access point in
    /// place of the bucket name or specify the access point ARN. When you use this
    /// action with an access point for directory buckets, you must provide the
    /// access point name in place of the bucket name. When using the access point
    /// ARN, you must direct requests to the access point hostname. The access point
    /// hostname takes the form
    /// *AccessPointName*-*AccountId*.s3-accesspoint.*Region*.amazonaws.com. When
    /// using this action with an access point through the Amazon Web Services SDKs,
    /// you provide the access point ARN in place of the bucket name. For more
    /// information about access point ARNs, see [Using access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-access-points.html) in the *Amazon S3 User Guide*.
    ///
    /// Object Lambda access points are not supported by directory buckets.
    ///
    /// **S3 on Outposts** - When you use this action with S3 on Outposts, you must
    /// direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname
    /// takes the
    /// form `
    /// *AccessPointName*-*AccountId*.*outpostID*.s3-outposts.*Region*.amazonaws.com`. When you use this action with S3 on Outposts, the destination bucket must be the Outposts access point ARN or the access point alias. For more information about S3 on Outposts, see [What is S3 on Outposts?](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the *Amazon S3 User Guide*.
    bucket: []const u8,

    /// Specifies whether you want to delete this object even if it has a
    /// Governance-type Object Lock in
    /// place. To use this header, you must have the `s3:BypassGovernanceRetention`
    /// permission.
    ///
    /// This functionality is not supported for directory buckets.
    bypass_governance_retention: ?bool = null,

    /// Indicates the algorithm used to create the checksum for the object when you
    /// use the SDK. This header will not provide any
    /// additional functionality if you don't use the SDK. When you send this
    /// header, there must be a corresponding `x-amz-checksum-*algorithm*
    /// ` or
    /// `x-amz-trailer` header sent. Otherwise, Amazon S3 fails the request with the
    /// HTTP status code `400 Bad Request`.
    ///
    /// For the `x-amz-checksum-*algorithm*
    /// ` header, replace `
    /// *algorithm*
    /// ` with the supported algorithm from the following list:
    ///
    /// * `CRC32`
    ///
    /// * `CRC32C`
    ///
    /// * `CRC64NVME`
    ///
    /// * `SHA1`
    ///
    /// * `SHA256`
    ///
    /// For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    ///
    /// If the individual checksum value you provide through
    /// `x-amz-checksum-*algorithm*
    /// ` doesn't match the checksum algorithm you set through
    /// `x-amz-sdk-checksum-algorithm`, Amazon S3 fails the request with a
    /// `BadDigest` error.
    ///
    /// If you provide an individual checksum, Amazon S3 ignores any provided
    /// `ChecksumAlgorithm`
    /// parameter.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// Container for the request.
    delete: Delete,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// The concatenation of the authentication device's serial number, a space, and
    /// the value that is
    /// displayed on your authentication device. Required to permanently delete a
    /// versioned object if versioning
    /// is configured with MFA delete enabled.
    ///
    /// When performing the `DeleteObjects` operation on an MFA delete enabled
    /// bucket, which
    /// attempts to delete the specified versioned objects, you must include an MFA
    /// token. If you don't provide
    /// an MFA token, the entire request will fail, even if there are non-versioned
    /// objects that you are trying
    /// to delete. If you provide an invalid token, whether there are versioned
    /// object keys in the request or
    /// not, the entire Multi-Object Delete request will fail. For information about
    /// MFA Delete, see [ MFA
    /// Delete](https://docs.aws.amazon.com/AmazonS3/latest/dev/Versioning.html#MultiFactorAuthenticationDelete) in the *Amazon S3 User Guide*.
    ///
    /// This functionality is not supported for directory buckets.
    mfa: ?[]const u8 = null,

    request_payer: ?RequestPayer = null,
};

pub const DeleteObjectsOutput = struct {
    /// Container element for a successful delete. It identifies the object that was
    /// successfully
    /// deleted.
    deleted: ?[]const DeletedObject = null,

    /// Container for a failed delete action that describes the object that Amazon
    /// S3 attempted to delete and the
    /// error it encountered.
    errors: ?[]const Error = null,

    request_charged: ?RequestCharged = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteObjectsInput, options: CallOptions) !DeleteObjectsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "s3");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteObjectsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "delete");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    try body_buf.appendSlice(allocator, "<Delete xmlns=" ++ &[_]u8{0x22} ++ "http://s3.amazonaws.com/doc/2006-03-01/" ++ &[_]u8{0x22} ++ ">");
    try serde.serializeDelete(allocator, &body_buf, input.delete);
    try body_buf.appendSlice(allocator, "</Delete>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    const body_for_md5: []const u8 = if (@TypeOf(body) == ?[]const u8) (body orelse "") else body;
    if (body_for_md5.len > 0) {
        var md5_digest: [16]u8 = undefined;
        std.crypto.hash.Md5.hash(body_for_md5, &md5_digest, .{});
        const md5_len = std.base64.standard.Encoder.calcSize(md5_digest.len);
        const md5_b64 = try allocator.alloc(u8, md5_len);
        _ = std.base64.standard.Encoder.encode(md5_b64, &md5_digest);
        try request.headers.put(allocator, "Content-MD5", md5_b64);
    }
    if (input.bypass_governance_retention) |v| {
        try request.headers.put(allocator, "x-amz-bypass-governance-retention", if (v) "true" else "false");
    }
    if (input.checksum_algorithm) |v| {
        try request.headers.put(allocator, "x-amz-sdk-checksum-algorithm", v.wireName());
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
    }
    if (input.mfa) |v| {
        try request.headers.put(allocator, "x-amz-mfa", v);
    }
    if (input.request_payer) |v| {
        try request.headers.put(allocator, "x-amz-request-payer", v.wireName());
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteObjectsOutput {
    var result: DeleteObjectsOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var deleted_list: std.ArrayList(DeletedObject) = .{};
    var errors_list: std.ArrayList(Error) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Deleted")) {
                    try deleted_list.append(allocator, try serde.deserializeDeletedObject(allocator, &reader));
                } else if (std.mem.eql(u8, e.local, "Error")) {
                    try errors_list.append(allocator, try serde.deserializeError(allocator, &reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    result.deleted = if (deleted_list.items.len > 0) try deleted_list.toOwnedSlice(allocator) else null;
    result.errors = if (errors_list.items.len > 0) try errors_list.toOwnedSlice(allocator) else null;
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = RequestCharged.fromWireName(value);
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "AccessDenied")) {
        return .{ .arena = arena, .kind = .{ .access_denied = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyOwnedByYou")) {
        return .{ .arena = arena, .kind = .{ .bucket_already_owned_by_you = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionTypeMismatch")) {
        return .{ .arena = arena, .kind = .{ .encryption_type_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyParameterMismatch")) {
        return .{ .arena = arena, .kind = .{ .idempotency_parameter_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidObjectState")) {
        return .{ .arena = arena, .kind = .{ .invalid_object_state = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequest")) {
        return .{ .arena = arena, .kind = .{ .invalid_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidWriteOffset")) {
        return .{ .arena = arena, .kind = .{ .invalid_write_offset = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchBucket")) {
        return .{ .arena = arena, .kind = .{ .no_such_bucket = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchKey")) {
        return .{ .arena = arena, .kind = .{ .no_such_key = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchUpload")) {
        return .{ .arena = arena, .kind = .{ .no_such_upload = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFound")) {
        return .{ .arena = arena, .kind = .{ .not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ObjectAlreadyInActiveTierError")) {
        return .{ .arena = arena, .kind = .{ .object_already_in_active_tier_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ObjectNotInActiveTierError")) {
        return .{ .arena = arena, .kind = .{ .object_not_in_active_tier_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyParts")) {
        return .{ .arena = arena, .kind = .{ .too_many_parts = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
