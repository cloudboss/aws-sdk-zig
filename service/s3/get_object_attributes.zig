const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ObjectAttributes = @import("object_attributes.zig").ObjectAttributes;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const Checksum = @import("checksum.zig").Checksum;
const GetObjectAttributesParts = @import("get_object_attributes_parts.zig").GetObjectAttributesParts;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const StorageClass = @import("storage_class.zig").StorageClass;
const serde = @import("serde.zig");

/// Retrieves all of the metadata from an object without returning the object
/// itself. This operation is
/// useful if you're interested only in an object's metadata.
///
/// `GetObjectAttributes` combines the functionality of `HeadObject` and
/// `ListParts`. All of the data returned with both of those individual calls
/// can be returned
/// with a single call to `GetObjectAttributes`.
///
/// **Note:**
///
/// **Directory buckets** - For directory buckets, you must make requests for
/// this API operation to the Zonal endpoint. These endpoints support
/// virtual-hosted-style requests in the format
/// `https://*amzn-s3-demo-bucket*.s3express-*zone-id*.*region-code*.amazonaws.com/*key-name*
/// `. Path-style requests are not supported. For more information about
/// endpoints in Availability Zones, see [Regional and Zonal endpoints for
/// directory buckets in Availability
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/endpoint-directory-buckets-AZ.html) in the
/// *Amazon S3 User Guide*. For more information about endpoints in Local Zones,
/// see [Concepts for directory buckets in Local
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-lzs-for-directory-buckets.html) in the
/// *Amazon S3 User Guide*.
///
/// **Permissions**
///
/// * **General purpose bucket permissions** - To use
/// `GetObjectAttributes`, you must have READ access to the object.
///
/// The other permissions that you need to use this operation depend on whether
/// the bucket is
/// versioned and if a version ID is passed in the `GetObjectAttributes`
/// request.
///
/// * If you pass a version ID in your request, you need both the
/// `s3:GetObjectVersion` and `s3:GetObjectVersionAttributes`
/// permissions.
///
/// * If you do not pass a version ID in your request, you need the
/// `s3:GetObject` and `s3:GetObjectAttributes` permissions.
///
/// For more information, see [Specifying Permissions in a
/// Policy](https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html) in the *Amazon S3 User Guide*.
///
/// If the object that you request does not exist, the error Amazon S3 returns
/// depends on whether
/// you also have the `s3:ListBucket` permission.
///
/// * If you have the `s3:ListBucket` permission on the bucket, Amazon S3
///   returns an
/// HTTP status code `404 Not Found` ("no such key") error.
///
/// * If you don't have the `s3:ListBucket` permission, Amazon S3 returns an
///   HTTP
/// status code `403 Forbidden` ("access denied") error.
///
/// * **Directory bucket permissions** - To grant access to this API operation
///   on a directory bucket, we recommend that you use the [
/// `CreateSession`
/// ](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateSession.html)
/// API operation for session-based authorization. Specifically, you grant the
/// `s3express:CreateSession` permission to the directory bucket in a bucket
/// policy or an IAM identity-based policy. Then, you make the `CreateSession`
/// API call on the bucket to obtain a session token. With the session token in
/// your request header, you can make API requests to this operation. After the
/// session token expires, you make another `CreateSession` API call to generate
/// a new session token for use.
/// Amazon Web Services CLI or SDKs create session and refresh the session token
/// automatically to avoid service interruptions when a session expires. For
/// more information about authorization, see [
/// `CreateSession`
/// ](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateSession.html).
///
/// If
/// the
/// object is encrypted with SSE-KMS, you must also have the
/// `kms:GenerateDataKey` and
/// `kms:Decrypt` permissions in IAM identity-based policies and KMS key
/// policies
/// for the KMS key.
///
/// **Encryption**
///
/// **Note:**
///
/// Encryption request headers, like `x-amz-server-side-encryption`, should not
/// be
/// sent for `HEAD` requests if your object uses server-side encryption with Key
/// Management Service
/// (KMS) keys (SSE-KMS), dual-layer server-side encryption with Amazon Web
/// Services KMS keys (DSSE-KMS), or
/// server-side encryption with Amazon S3 managed encryption keys (SSE-S3). The
/// `x-amz-server-side-encryption` header is used when you `PUT` an object
/// to S3 and want to specify the encryption method. If you include this header
/// in a
/// `GET` request for an object that uses these types of keys, you’ll get an
/// HTTP
/// `400 Bad Request` error. It's because the encryption method can't be changed
/// when
/// you retrieve the object.
///
/// If you encrypted an object when you stored the object in Amazon S3 by using
/// server-side encryption
/// with customer-provided encryption keys (SSE-C), then when you retrieve the
/// metadata from the
/// object, you must use the following headers. These headers provide the server
/// with the encryption
/// key required to retrieve the object's metadata. The headers are:
///
/// * `x-amz-server-side-encryption-customer-algorithm`
///
/// * `x-amz-server-side-encryption-customer-key`
///
/// * `x-amz-server-side-encryption-customer-key-MD5`
///
/// For more information about SSE-C, see [Server-Side Encryption (Using
/// Customer-Provided Encryption
/// Keys)](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the *Amazon S3 User Guide*.
///
/// **Note:**
///
/// **Directory bucket permissions** -
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
/// **Versioning**
///
/// **Directory buckets** - S3 Versioning isn't enabled and supported for
/// directory buckets. For this API operation, only the `null` value of the
/// version ID is supported by directory buckets.
/// You can only specify `null` to the `versionId` query parameter in the
/// request.
///
/// **Conditional request headers**
///
/// Consider the following when using request headers:
///
/// * If both of the `If-Match` and `If-Unmodified-Since` headers are
/// present in the request as follows, then Amazon S3 returns the HTTP status
/// code `200 OK`
/// and the data requested:
///
/// * `If-Match` condition evaluates to `true`.
///
/// * `If-Unmodified-Since` condition evaluates to `false`.
///
/// For more information about conditional requests, see [RFC
/// 7232](https://tools.ietf.org/html/rfc7232).
///
/// * If both of the `If-None-Match` and `If-Modified-Since` headers are
/// present in the request as follows, then Amazon S3 returns the HTTP status
/// code `304 Not
/// Modified`:
///
/// * `If-None-Match` condition evaluates to `false`.
///
/// * `If-Modified-Since` condition evaluates to `true`.
///
/// For more information about conditional requests, see [RFC
/// 7232](https://tools.ietf.org/html/rfc7232).
///
/// **HTTP Host header syntax**
///
/// **Directory buckets ** - The HTTP Host header syntax is `
/// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`.
///
/// The following actions are related to `GetObjectAttributes`:
///
/// *
///   [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html)
///
/// *
///   [GetObjectAcl](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectAcl.html)
///
/// *
///   [GetObjectLegalHold](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectLegalHold.html)
///
/// *
///   [GetObjectLockConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectLockConfiguration.html)
///
/// *
///   [GetObjectRetention](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectRetention.html)
///
/// *
///   [GetObjectTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectTagging.html)
///
/// *
///   [HeadObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_HeadObject.html)
///
/// *
///   [ListParts](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListParts.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const GetObjectAttributesInput = struct {
    /// The name of the bucket that contains the object.
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
    /// **Note:**
    ///
    /// Object Lambda access points are not supported by directory buckets.
    ///
    /// **S3 on Outposts** - When you use this action with S3 on Outposts, you must
    /// direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname
    /// takes the
    /// form `
    /// *AccessPointName*-*AccountId*.*outpostID*.s3-outposts.*Region*.amazonaws.com`. When you use this action with S3 on Outposts, the destination bucket must be the Outposts access point ARN or the access point alias. For more information about S3 on Outposts, see [What is S3 on Outposts?](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the *Amazon S3 User Guide*.
    bucket: []const u8,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// The object key.
    key: []const u8,

    /// Sets the maximum number of parts to return. For more information, see
    /// [Uploading and copying objects using multipart upload
    /// in Amazon S3
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html) in
    /// the *Amazon Simple Storage Service user guide*.
    max_parts: ?i32 = null,

    /// Specifies the fields at the root level that you want returned in the
    /// response. Fields that you do
    /// not specify are not returned.
    object_attributes: []const ObjectAttributes,

    /// Specifies the part after which listing should begin. Only parts with higher
    /// part numbers will be
    /// listed. For more information, see [Uploading and copying objects using
    /// multipart upload
    /// in Amazon S3
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html) in
    /// the *Amazon Simple Storage Service user guide*.
    part_number_marker: ?[]const u8 = null,

    request_payer: ?RequestPayer = null,

    /// Specifies the algorithm to use when encrypting the object (for example,
    /// AES256).
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_algorithm: ?[]const u8 = null,

    /// Specifies the customer-provided encryption key for Amazon S3 to use in
    /// encrypting data. This value is
    /// used to store the object and then it is discarded; Amazon S3 does not store
    /// the encryption key. The key must
    /// be appropriate for use with the algorithm specified in the
    /// `x-amz-server-side-encryption-customer-algorithm` header.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key: ?[]const u8 = null,

    /// Specifies the 128-bit MD5 digest of the encryption key according to RFC
    /// 1321. Amazon S3 uses this header
    /// for a message integrity check to ensure that the encryption key was
    /// transmitted without error.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key_md5: ?[]const u8 = null,

    /// The version ID used to reference a specific version of the object.
    ///
    /// **Note:**
    ///
    /// S3 Versioning isn't enabled and supported for directory buckets. For this
    /// API operation, only the `null` value of the version ID is supported by
    /// directory buckets. You can only specify `null` to the
    /// `versionId` query parameter in the request.
    version_id: ?[]const u8 = null,
};

pub const GetObjectAttributesOutput = struct {
    /// The checksum or digest of the object.
    checksum: ?Checksum = null,

    /// Specifies whether the object retrieved was (`true`) or was not (`false`) a
    /// delete marker. If `false`, this response header does not appear in the
    /// response. To learn
    /// more about delete markers, see [Working with delete
    /// markers](https://docs.aws.amazon.com/AmazonS3/latest/userguide/DeleteMarker.html).
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    delete_marker: ?bool = null,

    /// An ETag is an opaque identifier assigned by a web server to a specific
    /// version of a resource found
    /// at a URL.
    e_tag: ?[]const u8 = null,

    /// Date and time when the object was last modified.
    last_modified: ?i64 = null,

    /// A collection of parts associated with a multipart upload.
    object_parts: ?GetObjectAttributesParts = null,

    /// The size of the object in bytes.
    object_size: ?i64 = null,

    request_charged: ?RequestCharged = null,

    /// Provides the storage class information of the object. Amazon S3 returns this
    /// header for all objects
    /// except for S3 Standard storage class objects.
    ///
    /// For more information, see [Storage
    /// Classes](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html).
    ///
    /// **Note:**
    ///
    /// **Directory buckets** -
    /// Directory buckets only support `EXPRESS_ONEZONE` (the S3 Express One Zone
    /// storage class) in Availability Zones and `ONEZONE_IA` (the S3 One
    /// Zone-Infrequent Access storage class) in Dedicated Local Zones.
    storage_class: ?StorageClass = null,

    /// The version ID of the object.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    version_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetObjectAttributesOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetObjectAttributesInput, options: Options) !GetObjectAttributesOutput {
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetObjectAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("s3", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.bucket);
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.key);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(alloc, "attributes");
    query_has_prev = true;
    if (input.version_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "versionId=");
        try appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
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
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-expected-bucket-owner", v);
    }
    if (input.max_parts) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-max-parts", num_str);
        }
    }
    try request.headers.put(alloc, "x-amz-object-attributes", input.object_attributes);
    if (input.part_number_marker) |v| {
        try request.headers.put(alloc, "x-amz-part-number-marker", v);
    }
    if (input.request_payer) |v| {
        try request.headers.put(alloc, "x-amz-request-payer", @tagName(v));
    }
    if (input.sse_customer_algorithm) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption-customer-algorithm", v);
    }
    if (input.sse_customer_key) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption-customer-key", v);
    }
    if (input.sse_customer_key_md5) |v| {
        try request.headers.put(alloc, "x-amz-server-side-encryption-customer-key-MD5", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetObjectAttributesOutput {
    var result: GetObjectAttributesOutput = .{};
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
                if (std.mem.eql(u8, e.local, "Checksum")) {
                    result.checksum = try serde.deserializeChecksum(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ETag")) {
                    result.e_tag = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ObjectParts")) {
                    result.object_parts = try serde.deserializeGetObjectAttributesParts(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ObjectSize")) {
                    result.object_size = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = std.meta.stringToEnum(StorageClass, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("x-amz-delete-marker")) |value| {
        result.delete_marker = std.mem.eql(u8, value, "true");
    }
    if (headers.get("last-modified")) |value| {
        result.last_modified = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = std.meta.stringToEnum(RequestCharged, value);
    }
    if (headers.get("x-amz-version-id")) |value| {
        result.version_id = try alloc.dupe(u8, value);
    }

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
