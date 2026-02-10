const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;
const SessionMode = @import("session_mode.zig").SessionMode;
const SessionCredentials = @import("session_credentials.zig").SessionCredentials;

/// Creates a session that establishes temporary security credentials to support
/// fast authentication and
/// authorization for the Zonal endpoint API operations on directory buckets.
/// For more information about Zonal endpoint API operations that
/// include the Availability Zone in the request endpoint, see [S3 Express One
/// Zone
/// APIs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-APIs.html) in the
/// *Amazon S3 User Guide*.
///
/// To make Zonal endpoint API requests on a directory bucket, use the
/// `CreateSession` API
/// operation. Specifically, you grant `s3express:CreateSession` permission to a
/// bucket in
/// a bucket policy or an IAM identity-based policy. Then, you use IAM
/// credentials to make the `CreateSession`
/// API request on the bucket, which returns temporary security credentials that
/// include the access key ID,
/// secret access key, session token, and expiration. These credentials have
/// associated permissions to
/// access the Zonal endpoint API operations. After the session is created, you
/// don’t need to use other policies to grant
/// permissions to each Zonal endpoint API individually. Instead, in your Zonal
/// endpoint API requests, you sign your
/// requests by applying the temporary security credentials of the session to
/// the request headers and
/// following the SigV4 protocol for authentication. You also apply the session
/// token to the
/// `x-amz-s3session-token` request header for authorization. Temporary security
/// credentials
/// are scoped to the bucket and expire after 5 minutes. After the expiration
/// time, any calls that you make
/// with those credentials will fail. You must use IAM credentials again to make
/// a
/// `CreateSession` API request that generates a new set of temporary
/// credentials for use.
/// Temporary credentials cannot be extended or refreshed beyond the original
/// specified interval.
///
/// If you use Amazon Web Services SDKs, SDKs handle the session token refreshes
/// automatically to avoid service
/// interruptions when a session expires. We recommend that you use the Amazon
/// Web Services SDKs to initiate and manage
/// requests to the CreateSession API. For more information, see [Performance
/// guidelines and design
/// patterns](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-optimizing-performance-guidelines-design-patterns.html#s3-express-optimizing-performance-session-authentication) in the
/// *Amazon S3 User Guide*.
///
/// **Note:**
///
/// * You must make requests for this API operation to the Zonal endpoint. These
///   endpoints support virtual-hosted-style requests in the format
///   `https://*bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`.
///   Path-style requests are not supported. For more information about
///   endpoints in Availability Zones, see [Regional and Zonal endpoints for
///   directory buckets in Availability
///   Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/endpoint-directory-buckets-AZ.html) in the
/// *Amazon S3 User Guide*. For more information about endpoints in Local Zones,
/// see [Concepts for directory buckets in Local
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-lzs-for-directory-buckets.html) in the
/// *Amazon S3 User Guide*.
///
/// * **
/// `CopyObject` API operation** - Unlike other
/// Zonal endpoint API operations, the `CopyObject` API operation doesn't use
/// the temporary security
/// credentials returned from the `CreateSession` API operation for
/// authentication and
/// authorization. For information about authentication and authorization of the
/// `CopyObject` API operation on directory buckets, see
/// [CopyObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html).
///
/// * **
/// `HeadBucket` API operation** - Unlike other
/// Zonal endpoint API operations, the `HeadBucket` API operation doesn't use
/// the temporary security
/// credentials returned from the `CreateSession` API operation for
/// authentication and
/// authorization. For information about authentication and authorization of the
/// `HeadBucket` API operation on directory buckets, see
/// [HeadBucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_HeadBucket.html).
///
/// **Permissions**
///
/// To obtain temporary security credentials, you must create a bucket policy or
/// an IAM identity-based policy that
/// grants `s3express:CreateSession` permission to the bucket. In a policy, you
/// can have
/// the `s3express:SessionMode` condition key to control who can create a
/// `ReadWrite` or `ReadOnly` session. For more information about
/// `ReadWrite` or `ReadOnly` sessions, see [
/// `x-amz-create-session-mode`
/// ](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateSession.html#API_CreateSession_RequestParameters). For example policies, see [Example
/// bucket policies for S3 Express One
/// Zone](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-security-iam-example-bucket-policies.html) and [Amazon Web Services Identity
/// and Access Management (IAM) identity-based policies for S3 Express One
/// Zone](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-security-iam-identity-policies.html) in the
/// *Amazon S3 User Guide*.
///
/// To grant cross-account access to Zonal endpoint API operations, the bucket
/// policy should also grant both
/// accounts the `s3express:CreateSession` permission.
///
/// If you want to encrypt objects with SSE-KMS, you must also have the
/// `kms:GenerateDataKey` and the `kms:Decrypt` permissions in IAM
/// identity-based policies and KMS key policies for the target KMS key.
///
/// **Encryption**
///
/// For directory buckets, there are only two supported options for server-side
/// encryption: server-side encryption with Amazon S3 managed keys (SSE-S3)
/// (`AES256`) and server-side encryption with KMS keys (SSE-KMS) (`aws:kms`).
/// We recommend that the bucket's default encryption uses the desired
/// encryption configuration and you don't override the bucket default
/// encryption in your
/// `CreateSession` requests or `PUT` object requests. Then, new objects
/// are automatically encrypted with the desired encryption settings. For more
/// information, see [Protecting data with server-side
/// encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-serv-side-encryption.html) in the *Amazon S3 User Guide*. For more information about the encryption overriding behaviors in directory buckets, see [Specifying server-side encryption with KMS for new object uploads](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-specifying-kms-encryption.html).
///
/// For [Zonal endpoint (object-level) API
/// operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-differences.html#s3-express-differences-api-operations) except [CopyObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html) and [UploadPartCopy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html),
/// you authenticate and authorize requests through
/// [CreateSession](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateSession.html) for low latency.
/// To encrypt new objects in a directory bucket with SSE-KMS, you must specify
/// SSE-KMS as the directory bucket's default encryption configuration with a
/// KMS key (specifically, a [customer managed
/// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-cmk)). Then, when a session is created for Zonal endpoint API operations, new objects are automatically encrypted and decrypted with SSE-KMS and S3 Bucket Keys during the session.
///
/// **Note:**
///
/// Only 1 [customer managed
/// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-cmk) is supported per directory bucket for the lifetime of the bucket. The [Amazon Web Services managed key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk) (`aws/s3`) isn't supported.
/// After you specify SSE-KMS as your bucket's default encryption configuration
/// with a customer managed key, you can't change the customer managed key for
/// the bucket's SSE-KMS configuration.
///
/// In the Zonal endpoint API calls (except
/// [CopyObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html) and [UploadPartCopy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html)) using the REST API,
/// you can't override the values of the encryption settings
/// (`x-amz-server-side-encryption`,
/// `x-amz-server-side-encryption-aws-kms-key-id`,
/// `x-amz-server-side-encryption-context`, and
/// `x-amz-server-side-encryption-bucket-key-enabled`) from the `CreateSession`
/// request.
/// You don't need to explicitly specify these encryption settings values in
/// Zonal endpoint API calls, and
/// Amazon S3 will use the encryption settings values from the `CreateSession`
/// request to protect new objects in the directory bucket.
///
/// **Note:**
///
/// When you use the CLI or the Amazon Web Services SDKs, for `CreateSession`,
/// the session token refreshes automatically to avoid service interruptions
/// when a session expires. The CLI or the Amazon Web Services SDKs use the
/// bucket's default encryption configuration for the
/// `CreateSession` request. It's not supported to override the encryption
/// settings values in the `CreateSession` request.
/// Also, in the Zonal endpoint API calls (except
/// [CopyObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html) and [UploadPartCopy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html)),
/// it's not supported to override the values of the encryption settings from
/// the `CreateSession` request.
///
/// **HTTP Host header syntax**
///
/// **Directory buckets ** - The HTTP Host header syntax is `
/// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`.
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const CreateSessionInput = struct {
    /// The name of the bucket that you create a session for.
    bucket: []const u8,

    /// Specifies whether Amazon S3 should use an S3 Bucket Key for object
    /// encryption with
    /// server-side encryption using KMS keys (SSE-KMS).
    ///
    /// S3 Bucket Keys are always enabled for `GET` and `PUT` operations in a
    /// directory bucket and can’t be disabled. S3 Bucket Keys aren't supported,
    /// when you copy SSE-KMS encrypted objects from general purpose buckets
    /// to directory buckets, from directory buckets to general purpose buckets, or
    /// between directory buckets, through
    /// [CopyObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CopyObject.html), [UploadPartCopy](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPartCopy.html), [the Copy operation in Batch Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-objects-Batch-Ops), or
    /// [the import
    /// jobs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-import-job). In this case, Amazon S3 makes a call to KMS every time a copy request is made for a KMS-encrypted object.
    bucket_key_enabled: ?bool = null,

    /// The server-side encryption algorithm to use when you store objects in the
    /// directory bucket.
    ///
    /// For directory buckets, there are only two supported options for server-side
    /// encryption: server-side encryption with Amazon S3 managed keys (SSE-S3)
    /// (`AES256`) and server-side encryption with KMS keys (SSE-KMS) (`aws:kms`).
    /// By default, Amazon S3 encrypts data with SSE-S3.
    /// For more
    /// information, see [Protecting data with server-side
    /// encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/serv-side-encryption.html) in the *Amazon S3 User Guide*.
    ///
    /// **S3 access points for Amazon FSx ** - When accessing data stored in Amazon
    /// FSx
    /// file systems using S3 access points, the only valid server side encryption
    /// option is `aws:fsx`. All
    /// Amazon FSx file systems have encryption configured by default and are
    /// encrypted at rest. Data is
    /// automatically encrypted before being written to the file system, and
    /// automatically decrypted as it is
    /// read. These processes are handled transparently by Amazon FSx.
    server_side_encryption: ?ServerSideEncryption = null,

    /// Specifies the mode of the session that will be created, either `ReadWrite`
    /// or
    /// `ReadOnly`. By default, a `ReadWrite` session is created. A
    /// `ReadWrite` session is capable of executing all the Zonal endpoint API
    /// operations on a directory bucket. A
    /// `ReadOnly` session is constrained to execute the following Zonal endpoint
    /// API operations:
    /// `GetObject`, `HeadObject`, `ListObjectsV2`,
    /// `GetObjectAttributes`, `ListParts`, and
    /// `ListMultipartUploads`.
    session_mode: ?SessionMode = null,

    /// Specifies the Amazon Web Services KMS Encryption Context as an additional
    /// encryption context to use for object encryption. The value of
    /// this header is a Base64 encoded string of a UTF-8 encoded JSON, which
    /// contains the encryption context as key-value pairs.
    /// This value is stored as object metadata and automatically gets passed on
    /// to Amazon Web Services KMS for future `GetObject` operations on
    /// this object.
    ///
    /// **General purpose buckets** - This value must be explicitly added during
    /// `CopyObject` operations if you want an additional encryption context for
    /// your object. For more information, see [Encryption
    /// context](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingKMSEncryption.html#encryption-context) in the *Amazon S3 User Guide*.
    ///
    /// **Directory buckets** - You can optionally provide an explicit encryption
    /// context value. The value must match the default encryption context - the
    /// bucket Amazon Resource Name (ARN). An additional encryption context value is
    /// not supported.
    ssekms_encryption_context: ?[]const u8 = null,

    /// If you specify `x-amz-server-side-encryption` with `aws:kms`, you must
    /// specify the `
    /// x-amz-server-side-encryption-aws-kms-key-id` header with the ID (Key ID or
    /// Key ARN) of the KMS
    /// symmetric encryption customer managed key to use. Otherwise, you get an HTTP
    /// `400 Bad Request` error. Only use the key ID or key ARN. The key alias
    /// format of the KMS key isn't supported. Also, if the KMS key doesn't exist in
    /// the same
    /// account that't issuing the command, you must use the full Key ARN not the
    /// Key ID.
    ///
    /// Your SSE-KMS configuration can only support 1 [customer managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#customer-cmk) per directory bucket's lifetime.
    /// The [Amazon Web Services managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk) (`aws/s3`) isn't supported.
    ssekms_key_id: ?[]const u8 = null,
};

pub const CreateSessionOutput = struct {
    /// Indicates whether to use an S3 Bucket Key for server-side encryption
    /// with KMS keys (SSE-KMS).
    bucket_key_enabled: ?bool = null,

    /// The established temporary security credentials for the created session.
    credentials: SessionCredentials,

    /// The server-side encryption algorithm used when you store objects in the
    /// directory bucket.
    ///
    /// **Note:**
    ///
    /// When accessing data stored in Amazon FSx file systems using S3 access
    /// points, the only valid server side
    /// encryption option is `aws:fsx`.
    server_side_encryption: ?ServerSideEncryption = null,

    /// If present, indicates the Amazon Web Services KMS Encryption Context to use
    /// for object encryption. The value of
    /// this header is a Base64 encoded string of a UTF-8 encoded JSON, which
    /// contains the encryption context as key-value pairs.
    /// This value is stored as object metadata and automatically gets
    /// passed on to Amazon Web Services KMS for future `GetObject`
    /// operations on this object.
    ssekms_encryption_context: ?[]const u8 = null,

    /// If you specify `x-amz-server-side-encryption` with `aws:kms`, this header
    /// indicates the ID of the KMS
    /// symmetric encryption customer managed key that was used for object
    /// encryption.
    ssekms_key_id: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateSessionOutput) void {
        if (self.ssekms_encryption_context) |v| {
            self.allocator.free(v);
        }
        if (self.ssekms_key_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateSessionInput, options: Options) !CreateSessionOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateSessionInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(alloc, "session");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.bucket_key_enabled) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption-bucket-key-enabled", if (v) "true" else "false");
    }
    if (input.server_side_encryption) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption", @tagName(v));
    }
    if (input.session_mode) |v| {
        try request.headers.put(alloc, "x-amz-create-session-mode", @tagName(v));
    }
    if (input.ssekms_encryption_context) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption-context", v);
    }
    if (input.ssekms_key_id) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption-aws-kms-key-id", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !CreateSessionOutput {
    _ = body;
    _ = status;
    const result: CreateSessionOutput = .{ .allocator = alloc };

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
