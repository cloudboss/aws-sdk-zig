const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;

/// This operation configures default encryption and Amazon S3 Bucket Keys for
/// an existing bucket. You can also [block encryption
/// types](https://docs.aws.amazon.com/AmazonS3/latest/API/API_BlockedEncryptionTypes.html) using this operation.
///
/// **Note:**
///
/// **Directory buckets ** - For directory buckets, you must make requests for
/// this API operation to the Regional endpoint. These endpoints support
/// path-style requests in the format
/// `https://s3express-control.*region-code*.amazonaws.com/*bucket-name*
/// `. Virtual-hosted-style requests aren't supported.
/// For more information about endpoints in Availability Zones, see [Regional
/// and Zonal endpoints for directory buckets in Availability
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/endpoint-directory-buckets-AZ.html) in the
/// *Amazon S3 User Guide*. For more information about endpoints in Local Zones,
/// see [Concepts for directory buckets in Local
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-lzs-for-directory-buckets.html) in the
/// *Amazon S3 User Guide*.
///
/// By default, all buckets have a default encryption configuration that uses
/// server-side encryption
/// with Amazon S3 managed keys (SSE-S3).
///
/// **Note:**
///
/// * **General purpose buckets**
///
/// * You can optionally configure default encryption for a bucket by using
///   server-side
/// encryption with Key Management Service (KMS) keys (SSE-KMS) or dual-layer
/// server-side encryption with
/// Amazon Web Services KMS keys (DSSE-KMS). If you specify default encryption
/// by using SSE-KMS, you can also
/// configure [Amazon S3 Bucket
/// Keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-key.html). For
/// information about the bucket default encryption feature, see [Amazon S3
/// Bucket Default
/// Encryption](https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html) in the *Amazon S3 User Guide*.
///
/// * If you use PutBucketEncryption to set your [default bucket
///   encryption](https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html) to
/// SSE-KMS, you should verify that your KMS key ID is correct. Amazon S3
/// doesn't validate the
/// KMS key ID provided in PutBucketEncryption requests.
///
/// * **Directory buckets ** - You can optionally configure
/// default encryption for a bucket by using server-side encryption with Key
/// Management Service (KMS) keys
/// (SSE-KMS).
///
/// * We recommend that the bucket's default encryption uses the desired
///   encryption
/// configuration and you don't override the bucket default encryption in your
/// `CreateSession` requests or `PUT` object requests. Then, new objects
/// are automatically encrypted with the desired encryption settings.
/// For more information about the encryption overriding behaviors in directory
/// buckets, see [Specifying server-side encryption with KMS for new object
/// uploads](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-specifying-kms-encryption.html).
///
/// * Your SSE-KMS configuration can only support 1 [customer managed
///   key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-cmk) per directory bucket's lifetime.
/// The [Amazon Web Services managed
/// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk) (`aws/s3`) isn't supported.
///
/// * S3 Bucket Keys are always enabled for `GET` and `PUT` operations in a
///   directory bucket and can’t be disabled. S3 Bucket Keys aren't supported,
///   when you copy SSE-KMS encrypted objects from general purpose buckets
/// to directory buckets, from directory buckets to general purpose buckets, or
/// between directory buckets, through
/// [CopyObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html), [UploadPartCopy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html), [the Copy operation in Batch Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-objects-Batch-Ops), or
/// [the import
/// jobs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-import-job). In this case, Amazon S3 makes a call to KMS every time a copy request is made for a KMS-encrypted object.
///
/// * When you specify an [KMS customer managed
///   key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-cmk) for encryption in your directory bucket, only use the key ID or key ARN. The key alias format of the KMS key isn't supported.
///
/// * For directory buckets, if you use PutBucketEncryption to set your [default
///   bucket
/// encryption](https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html) to SSE-KMS, Amazon S3 validates the KMS key ID provided in
/// PutBucketEncryption requests.
///
/// **Important:**
///
/// If you're specifying a customer managed KMS key, we recommend using a fully
/// qualified KMS key
/// ARN. If you use a KMS key alias instead, then KMS resolves the key within
/// the requester’s account.
/// This behavior can result in data that's encrypted with a KMS key that
/// belongs to the requester, and
/// not the bucket owner.
///
/// Also, this action requires Amazon Web Services Signature Version 4. For more
/// information, see [ Authenticating
/// Requests (Amazon Web Services Signature Version
/// 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html).
///
/// **Permissions**
///
/// * **General purpose bucket permissions** - The
/// `s3:PutEncryptionConfiguration` permission is required in a policy. The
/// bucket
/// owner has this permission by default. The bucket owner can grant this
/// permission to others.
/// For more information about permissions, see [Permissions Related to Bucket
/// Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources) and [Managing Access Permissions to Your
/// Amazon S3
/// Resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-access-control.html) in the *Amazon S3 User Guide*.
///
/// * **Directory bucket permissions** - To grant access to
/// this API operation, you must have the `s3express:PutEncryptionConfiguration`
/// permission in an IAM identity-based policy instead of a bucket policy.
/// Cross-account access to this API operation isn't supported. This operation
/// can only be performed by the Amazon Web Services account that owns the
/// resource.
/// For more information about directory bucket policies and permissions, see
/// [Amazon Web Services Identity and Access Management (IAM) for S3 Express One
/// Zone](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-security-iam.html) in the *Amazon S3 User Guide*.
///
/// To set a directory bucket default encryption with SSE-KMS, you must also
/// have the
/// `kms:GenerateDataKey` and the `kms:Decrypt` permissions in IAM
/// identity-based policies and KMS key policies for the target KMS key.
///
/// **HTTP Host header syntax**
///
/// **Directory buckets ** - The HTTP Host header syntax is
/// `s3express-control.*region-code*.amazonaws.com`.
///
/// The following operations are related to `PutBucketEncryption`:
///
/// *
///   [GetBucketEncryption](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketEncryption.html)
///
/// *
///   [DeleteBucketEncryption](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketEncryption.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const PutBucketEncryptionInput = struct {
    /// Specifies default encryption for a bucket using server-side encryption with
    /// different key
    /// options.
    ///
    /// **Directory buckets ** - When you use this operation with a directory
    /// bucket, you must use path-style requests in the format
    /// `https://s3express-control.*region-code*.amazonaws.com/*bucket-name*
    /// `. Virtual-hosted-style requests aren't supported. Directory bucket names
    /// must be unique in the chosen Zone (Availability Zone or Local Zone). Bucket
    /// names must also follow the format `
    /// *bucket-base-name*--*zone-id*--x-s3` (for example, `
    /// *DOC-EXAMPLE-BUCKET*--*usw2-az1*--x-s3`). For information about bucket
    /// naming restrictions, see [Directory bucket naming
    /// rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-bucket-naming-rules.html) in the *Amazon S3 User Guide*
    bucket: []const u8,

    /// Indicates the algorithm used to create the checksum for the request when you
    /// use the SDK. This header will not provide any
    /// additional functionality if you don't use the SDK. When you send this
    /// header, there must be a corresponding `x-amz-checksum` or
    /// `x-amz-trailer` header sent. Otherwise, Amazon S3 fails the request with the
    /// HTTP status code `400 Bad Request`. For more
    /// information, see [Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html) in
    /// the *Amazon S3 User Guide*.
    ///
    /// If you provide an individual checksum, Amazon S3 ignores any provided
    /// `ChecksumAlgorithm`
    /// parameter.
    ///
    /// **Note:**
    ///
    /// For directory buckets, when you use Amazon Web Services SDKs, `CRC32` is the
    /// default checksum algorithm that's used for performance.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// The Base64 encoded 128-bit `MD5` digest of the server-side encryption
    /// configuration.
    ///
    /// For requests made using the Amazon Web Services Command Line Interface (CLI)
    /// or Amazon Web Services SDKs, this field is calculated automatically.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    content_md5: ?[]const u8 = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    ///
    /// **Note:**
    ///
    /// For directory buckets, this header is not supported in this API operation.
    /// If you specify this header, the request fails with the HTTP status code
    /// `501 Not Implemented`.
    expected_bucket_owner: ?[]const u8 = null,

    server_side_encryption_configuration: ServerSideEncryptionConfiguration,
};

pub const PutBucketEncryptionOutput = struct {

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const PutBucketEncryptionOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: PutBucketEncryptionInput, options: Options) !PutBucketEncryptionOutput {
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
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutBucketEncryptionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("s3", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.bucket);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(alloc, "encryption");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.checksum_algorithm) |v| {
        try request.headers.put(alloc, "x-amz-sdk-checksum-algorithm", @tagName(v));
    }
    if (input.content_md5) |v| {
        try request.headers.put(alloc, "Content-MD5", v);
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-expected-bucket-owner", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !PutBucketEncryptionOutput {
    _ = body;
    _ = status;
    const result: PutBucketEncryptionOutput = .{ .allocator = alloc };

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestId") orelse "";

    if (std.mem.eql(u8, error_code, "AccessDenied")) {
        return .{ .access_denied = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyExists")) {
        return .{ .bucket_already_exists = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "BucketAlreadyOwnedByYou")) {
        return .{ .bucket_already_owned_by_you = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionTypeMismatch")) {
        return .{ .encryption_type_mismatch = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "IdempotencyParameterMismatch")) {
        return .{ .idempotency_parameter_mismatch = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidObjectState")) {
        return .{ .invalid_object_state = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequest")) {
        return .{ .invalid_request = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "InvalidWriteOffset")) {
        return .{ .invalid_write_offset = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchBucket")) {
        return .{ .no_such_bucket = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchKey")) {
        return .{ .no_such_key = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchUpload")) {
        return .{ .no_such_upload = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "NotFound")) {
        return .{ .not_found = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ObjectAlreadyInActiveTierError")) {
        return .{ .object_already_in_active_tier_error = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "ObjectNotInActiveTierError")) {
        return .{ .object_not_in_active_tier_error = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }
    if (std.mem.eql(u8, error_code, "TooManyParts")) {
        return .{ .too_many_parts = .{
            .message = error_message,
            .request_id = request_id,
        } };
    }

    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendXmlEscaped(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            '&' => try buf.appendSlice(alloc, "&amp;"),
            '<' => try buf.appendSlice(alloc, "&lt;"),
            '>' => try buf.appendSlice(alloc, "&gt;"),
            else => try buf.append(alloc, c),
        }
    }
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
