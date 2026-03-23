const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ChecksumMode = @import("checksum_mode.zig").ChecksumMode;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const ArchiveStatus = @import("archive_status.zig").ArchiveStatus;
const ChecksumType = @import("checksum_type.zig").ChecksumType;
const ObjectLockLegalHoldStatus = @import("object_lock_legal_hold_status.zig").ObjectLockLegalHoldStatus;
const ObjectLockMode = @import("object_lock_mode.zig").ObjectLockMode;
const ReplicationStatus = @import("replication_status.zig").ReplicationStatus;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const ServerSideEncryption = @import("server_side_encryption.zig").ServerSideEncryption;
const StorageClass = @import("storage_class.zig").StorageClass;
const serde = @import("serde.zig");

pub const HeadObjectInput = struct {
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
    /// Object Lambda access points are not supported by directory buckets.
    ///
    /// **S3 on Outposts** - When you use this action with S3 on Outposts, you must
    /// direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname
    /// takes the
    /// form `
    /// *AccessPointName*-*AccountId*.*outpostID*.s3-outposts.*Region*.amazonaws.com`. When you use this action with S3 on Outposts, the destination bucket must be the Outposts access point ARN or the access point alias. For more information about S3 on Outposts, see [What is S3 on Outposts?](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the *Amazon S3 User Guide*.
    bucket: []const u8,

    /// To retrieve the checksum, this parameter must be enabled.
    ///
    /// **General purpose buckets** -
    /// If you enable checksum mode and the object is uploaded with a
    /// [checksum](https://docs.aws.amazon.com/AmazonS3/latest/API/API_Checksum.html) and encrypted with
    /// an Key Management Service (KMS) key, you must have permission to use the
    /// `kms:Decrypt` action to
    /// retrieve the checksum.
    ///
    /// **Directory buckets** - If you enable `ChecksumMode`
    /// and the object is encrypted with Amazon Web Services Key Management Service
    /// (Amazon Web Services KMS), you must also have the
    /// `kms:GenerateDataKey` and `kms:Decrypt` permissions in IAM identity-based
    /// policies and KMS key policies for the KMS key to retrieve the checksum of
    /// the object.
    checksum_mode: ?ChecksumMode = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// Return the object only if its entity tag (ETag) is the same as the one
    /// specified; otherwise, return
    /// a 412 (precondition failed) error.
    ///
    /// If both of the `If-Match` and `If-Unmodified-Since` headers are present in
    /// the
    /// request as follows:
    ///
    /// * `If-Match` condition evaluates to `true`, and;
    ///
    /// * `If-Unmodified-Since` condition evaluates to `false`;
    ///
    /// Then Amazon S3 returns `200 OK` and the data requested.
    ///
    /// For more information about conditional requests, see [RFC
    /// 7232](https://tools.ietf.org/html/rfc7232).
    if_match: ?[]const u8 = null,

    /// Return the object only if it has been modified since the specified time;
    /// otherwise, return a 304
    /// (not modified) error.
    ///
    /// If both of the `If-None-Match` and `If-Modified-Since` headers are present
    /// in
    /// the request as follows:
    ///
    /// * `If-None-Match` condition evaluates to `false`, and;
    ///
    /// * `If-Modified-Since` condition evaluates to `true`;
    ///
    /// Then Amazon S3 returns the `304 Not Modified` response code.
    ///
    /// For more information about conditional requests, see [RFC
    /// 7232](https://tools.ietf.org/html/rfc7232).
    if_modified_since: ?i64 = null,

    /// Return the object only if its entity tag (ETag) is different from the one
    /// specified; otherwise,
    /// return a 304 (not modified) error.
    ///
    /// If both of the `If-None-Match` and `If-Modified-Since` headers are present
    /// in
    /// the request as follows:
    ///
    /// * `If-None-Match` condition evaluates to `false`, and;
    ///
    /// * `If-Modified-Since` condition evaluates to `true`;
    ///
    /// Then Amazon S3 returns the `304 Not Modified` response code.
    ///
    /// For more information about conditional requests, see [RFC
    /// 7232](https://tools.ietf.org/html/rfc7232).
    if_none_match: ?[]const u8 = null,

    /// Return the object only if it has not been modified since the specified time;
    /// otherwise, return a 412
    /// (precondition failed) error.
    ///
    /// If both of the `If-Match` and `If-Unmodified-Since` headers are present in
    /// the
    /// request as follows:
    ///
    /// * `If-Match` condition evaluates to `true`, and;
    ///
    /// * `If-Unmodified-Since` condition evaluates to `false`;
    ///
    /// Then Amazon S3 returns `200 OK` and the data requested.
    ///
    /// For more information about conditional requests, see [RFC
    /// 7232](https://tools.ietf.org/html/rfc7232).
    if_unmodified_since: ?i64 = null,

    /// The object key.
    key: []const u8,

    /// Part number of the object being read. This is a positive integer between 1
    /// and 10,000. Effectively
    /// performs a 'ranged' HEAD request for the part specified. Useful querying
    /// about the size of the part and
    /// the number of parts in this object.
    part_number: ?i32 = null,

    /// HeadObject returns only the metadata for an object. If the Range is
    /// satisfiable, only the
    /// `ContentLength` is affected in the response. If the Range is not
    /// satisfiable, S3 returns a
    /// `416 - Requested Range Not Satisfiable` error.
    range: ?[]const u8 = null,

    request_payer: ?RequestPayer = null,

    /// Sets the `Cache-Control` header of the response.
    response_cache_control: ?[]const u8 = null,

    /// Sets the `Content-Disposition` header of the response.
    response_content_disposition: ?[]const u8 = null,

    /// Sets the `Content-Encoding` header of the response.
    response_content_encoding: ?[]const u8 = null,

    /// Sets the `Content-Language` header of the response.
    response_content_language: ?[]const u8 = null,

    /// Sets the `Content-Type` header of the response.
    response_content_type: ?[]const u8 = null,

    /// Sets the `Expires` header of the response.
    response_expires: ?i64 = null,

    /// Specifies the algorithm to use when encrypting the object (for example,
    /// AES256).
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
    /// This functionality is not supported for directory buckets.
    sse_customer_key: ?[]const u8 = null,

    /// Specifies the 128-bit MD5 digest of the encryption key according to RFC
    /// 1321. Amazon S3 uses this header
    /// for a message integrity check to ensure that the encryption key was
    /// transmitted without error.
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key_md5: ?[]const u8 = null,

    /// Version ID used to reference a specific version of the object.
    ///
    /// For directory buckets in this API operation, only the `null` value of the
    /// version ID is supported.
    version_id: ?[]const u8 = null,
};

pub const HeadObjectOutput = struct {
    /// Indicates that a range of bytes was specified.
    accept_ranges: ?[]const u8 = null,

    /// The archive state of the head object.
    ///
    /// This functionality is not supported for directory buckets.
    archive_status: ?ArchiveStatus = null,

    /// Indicates whether the object uses an S3 Bucket Key for server-side
    /// encryption with Key Management Service (KMS)
    /// keys (SSE-KMS).
    bucket_key_enabled: ?bool = null,

    /// Specifies caching behavior along the request/reply chain.
    cache_control: ?[]const u8 = null,

    /// The Base64 encoded, 32-bit `CRC32 checksum` of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. When you use an API operation on an object that was
    /// uploaded using multipart uploads, this value may not be a direct checksum
    /// value of the full object. Instead, it's a calculation based on the checksum
    /// values of each individual part. For more information about how checksums are
    /// calculated
    /// with multipart uploads, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html#large-object-checksums) in the *Amazon S3 User Guide*.
    checksum_crc32: ?[]const u8 = null,

    /// The Base64 encoded, 32-bit `CRC32C` checksum of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. When you use an API operation on an object that was
    /// uploaded using multipart uploads, this value may not be a direct checksum
    /// value of the full object. Instead, it's a calculation based on the checksum
    /// values of each individual part. For more information about how checksums are
    /// calculated
    /// with multipart uploads, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html#large-object-checksums) in the *Amazon S3 User Guide*.
    checksum_crc32_c: ?[]const u8 = null,

    /// The Base64 encoded, 64-bit `CRC64NVME` checksum of the object. For more
    /// information, see
    /// [Checking
    /// object integrity in the Amazon S3 User
    /// Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html).
    checksum_crc64_nvme: ?[]const u8 = null,

    /// The Base64 encoded, 160-bit `SHA1` digest of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. When you use the API operation on an object that was
    /// uploaded using multipart uploads, this value may not be a direct checksum
    /// value of the full object. Instead, it's a calculation based on the checksum
    /// values of each individual part. For more information about how checksums are
    /// calculated
    /// with multipart uploads, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html#large-object-checksums) in the *Amazon S3 User Guide*.
    checksum_sha1: ?[]const u8 = null,

    /// The Base64 encoded, 256-bit `SHA256` digest of the object. This checksum is
    /// only present if the checksum was uploaded
    /// with the object. When you use an API operation on an object that was
    /// uploaded using multipart uploads, this value may not be a direct checksum
    /// value of the full object. Instead, it's a calculation based on the checksum
    /// values of each individual part. For more information about how checksums are
    /// calculated
    /// with multipart uploads, see [
    /// Checking object
    /// integrity](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html#large-object-checksums) in the *Amazon S3 User Guide*.
    checksum_sha256: ?[]const u8 = null,

    /// The checksum type, which determines how part-level checksums are combined to
    /// create an object-level
    /// checksum for multipart objects. You can use this header response to verify
    /// that the checksum type that
    /// is received is the same checksum type that was specified in
    /// `CreateMultipartUpload` request.
    /// For more information, see [Checking object integrity in the Amazon S3
    /// User
    /// Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/checking-object-integrity.html).
    checksum_type: ?ChecksumType = null,

    /// Specifies presentational information for the object.
    content_disposition: ?[]const u8 = null,

    /// Indicates what content encodings have been applied to the object and thus
    /// what decoding mechanisms
    /// must be applied to obtain the media-type referenced by the Content-Type
    /// header field.
    content_encoding: ?[]const u8 = null,

    /// The language the content is in.
    content_language: ?[]const u8 = null,

    /// Size of the body in bytes.
    content_length: ?i64 = null,

    /// The portion of the object returned in the response for a `GET` request.
    content_range: ?[]const u8 = null,

    /// A standard MIME type describing the format of the object data.
    content_type: ?[]const u8 = null,

    /// Specifies whether the object retrieved was (true) or was not (false) a
    /// Delete Marker. If false, this
    /// response header does not appear in the response.
    ///
    /// This functionality is not supported for directory buckets.
    delete_marker: ?bool = null,

    /// An entity tag (ETag) is an opaque identifier assigned by a web server to a
    /// specific version of a
    /// resource found at a URL.
    e_tag: ?[]const u8 = null,

    /// If the object expiration is configured (see [
    /// `PutBucketLifecycleConfiguration`
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html)), the response includes this header. It
    /// includes the `expiry-date` and `rule-id` key-value pairs providing object
    /// expiration information. The value of the `rule-id` is URL-encoded.
    ///
    /// Object expiration information is not returned in directory buckets and this
    /// header returns the
    /// value "`NotImplemented`" in all responses for directory buckets.
    expiration: ?[]const u8 = null,

    /// The date and time at which the object is no longer cacheable.
    expires: ?[]const u8 = null,

    /// Date and time when the object was last modified.
    last_modified: ?i64 = null,

    /// A map of metadata to store with the object in S3.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// This is set to the number of metadata entries not returned in `x-amz-meta`
    /// headers. This
    /// can happen if you create metadata using an API like SOAP that supports more
    /// flexible metadata than the
    /// REST API. For example, using SOAP, you can create metadata whose values are
    /// not legal HTTP
    /// headers.
    ///
    /// This functionality is not supported for directory buckets.
    missing_meta: ?i32 = null,

    /// Specifies whether a legal hold is in effect for this object. This header is
    /// only returned if the
    /// requester has the `s3:GetObjectLegalHold` permission. This header is not
    /// returned if the
    /// specified version of this object has never had a legal hold applied. For
    /// more information about S3
    /// Object Lock, see [Object
    /// Lock](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html).
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_legal_hold_status: ?ObjectLockLegalHoldStatus = null,

    /// The Object Lock mode, if any, that's in effect for this object. This header
    /// is only returned if the
    /// requester has the `s3:GetObjectRetention` permission. For more information
    /// about S3 Object
    /// Lock, see [Object
    /// Lock](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html).
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_mode: ?ObjectLockMode = null,

    /// The date and time when the Object Lock retention period expires. This header
    /// is only returned if the
    /// requester has the `s3:GetObjectRetention` permission.
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_retain_until_date: ?i64 = null,

    /// The count of parts this object has. This value is only returned if you
    /// specify
    /// `partNumber` in your request and the object was uploaded as a multipart
    /// upload.
    parts_count: ?i32 = null,

    /// Amazon S3 can return this header if your request involves a bucket that is
    /// either a source or a
    /// destination in a replication rule.
    ///
    /// In replication, you have a source bucket on which you configure replication
    /// and destination bucket
    /// or buckets where Amazon S3 stores object replicas. When you request an
    /// object (`GetObject`) or
    /// object metadata (`HeadObject`) from these buckets, Amazon S3 will return the
    /// `x-amz-replication-status` header in the response as follows:
    ///
    /// * **If requesting an object from the source bucket**, Amazon S3 will
    /// return the `x-amz-replication-status` header if the object in your request
    /// is eligible
    /// for replication.
    ///
    /// For example, suppose that in your replication configuration, you specify
    /// object prefix
    /// `TaxDocs` requesting Amazon S3 to replicate objects with key prefix
    /// `TaxDocs`.
    /// Any objects you upload with this key name prefix, for example
    /// `TaxDocs/document1.pdf`,
    /// are eligible for replication. For any object request with this key name
    /// prefix, Amazon S3 will return the
    /// `x-amz-replication-status` header with value PENDING, COMPLETED or FAILED
    /// indicating
    /// object replication status.
    ///
    /// * **If requesting an object from a destination bucket**, Amazon S3 will
    /// return the `x-amz-replication-status` header with value REPLICA if the
    /// object in your
    /// request is a replica that Amazon S3 created and there is no replica
    /// modification replication in
    /// progress.
    ///
    /// * **When replicating objects to multiple destination buckets**, the
    /// `x-amz-replication-status` header acts differently. The header of the source
    /// object
    /// will only return a value of COMPLETED when replication is successful to all
    /// destinations. The header
    /// will remain at value PENDING until replication has completed for all
    /// destinations. If one or more
    /// destinations fails replication the header will return FAILED.
    ///
    /// For more information, see
    /// [Replication](https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html).
    ///
    /// This functionality is not supported for directory buckets.
    replication_status: ?ReplicationStatus = null,

    request_charged: ?RequestCharged = null,

    /// If the object is an archived object (an object whose storage class is
    /// GLACIER), the response
    /// includes this header if either the archive restoration is in progress (see
    /// [RestoreObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_RestoreObject.html) or an archive copy is already
    /// restored.
    ///
    /// If an archive copy is already restored, the header value indicates when
    /// Amazon S3 is scheduled to delete
    /// the object copy. For example:
    ///
    /// `x-amz-restore: ongoing-request="false", expiry-date="Fri, 21 Dec 2012
    /// 00:00:00
    /// GMT"`
    ///
    /// If the object restoration is in progress, the header returns the value
    /// `ongoing-request="true"`.
    ///
    /// For more information about archiving objects, see [Transitioning Objects:
    /// General
    /// Considerations](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html#lifecycle-transition-general-considerations).
    ///
    /// This functionality is not supported for directory buckets. Directory buckets
    /// only support `EXPRESS_ONEZONE` (the S3 Express One Zone storage class) in
    /// Availability Zones and `ONEZONE_IA` (the S3 One Zone-Infrequent Access
    /// storage class) in Dedicated Local Zones.
    restore: ?[]const u8 = null,

    /// The server-side encryption algorithm used when you store this object in
    /// Amazon S3 or Amazon FSx.
    ///
    /// When accessing data stored in Amazon FSx file systems using S3 access
    /// points, the only valid server side
    /// encryption option is `aws:fsx`.
    server_side_encryption: ?ServerSideEncryption = null,

    /// If server-side encryption with a customer-provided encryption key was
    /// requested, the response will
    /// include this header to confirm the encryption algorithm that's used.
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_algorithm: ?[]const u8 = null,

    /// If server-side encryption with a customer-provided encryption key was
    /// requested, the response will
    /// include this header to provide the round-trip message integrity verification
    /// of the customer-provided
    /// encryption key.
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key_md5: ?[]const u8 = null,

    /// If present, indicates the ID of the KMS key that was used for object
    /// encryption.
    ssekms_key_id: ?[]const u8 = null,

    /// Provides storage class information of the object. Amazon S3 returns this
    /// header for all objects except
    /// for S3 Standard storage class objects.
    ///
    /// For more information, see [Storage
    /// Classes](https://docs.aws.amazon.com/AmazonS3/latest/dev/storage-class-intro.html).
    ///
    /// **Directory buckets ** -
    /// Directory buckets only support `EXPRESS_ONEZONE` (the S3 Express One Zone
    /// storage class) in Availability Zones and `ONEZONE_IA` (the S3 One
    /// Zone-Infrequent Access storage class) in Dedicated Local Zones.
    storage_class: ?StorageClass = null,

    /// The number of tags, if any, on the object, when you have the relevant
    /// permission to read object
    /// tags.
    ///
    /// You can use
    /// [GetObjectTagging](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectTagging.html) to retrieve the tag set associated with an object.
    ///
    /// This functionality is not supported for directory buckets.
    tag_count: ?i32 = null,

    /// Version ID of the object.
    ///
    /// This functionality is not supported for directory buckets.
    version_id: ?[]const u8 = null,

    /// If the bucket is configured as a website, redirects requests for this object
    /// to another object in
    /// the same bucket or to an external URL. Amazon S3 stores the value of this
    /// header in the object
    /// metadata.
    ///
    /// This functionality is not supported for directory buckets.
    website_redirect_location: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: HeadObjectInput, options: CallOptions) !HeadObjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

pub const PresignOptions = struct {
    expires_seconds: u64 = 3600,
};

pub fn presign(client: *Client, allocator: std.mem.Allocator, input: HeadObjectInput, options: PresignOptions) ![]const u8 {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);

    return aws.signing.presignRequest(
        allocator,
        &request,
        creds,
        client.config.region,
        "s3",
        .{ .expires_seconds = options.expires_seconds },
    );
}

fn serializeRequest(allocator: std.mem.Allocator, input: HeadObjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.key);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.part_number) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "partNumber=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.response_cache_control) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "response-cache-control=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.response_content_disposition) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "response-content-disposition=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.response_content_encoding) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "response-content-encoding=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.response_content_language) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "response-content-language=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.response_content_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "response-content-type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.response_expires) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "response-expires=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.version_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "versionId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .HEAD;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    if (input.checksum_mode) |v| {
        try request.headers.put(allocator, "x-amz-checksum-mode", v.wireName());
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
    }
    if (input.if_match) |v| {
        try request.headers.put(allocator, "If-Match", v);
    }
    if (input.if_modified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try request.headers.put(allocator, "If-Modified-Since", num_str);
        }
    }
    if (input.if_none_match) |v| {
        try request.headers.put(allocator, "If-None-Match", v);
    }
    if (input.if_unmodified_since) |v| {
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try request.headers.put(allocator, "If-Unmodified-Since", num_str);
        }
    }
    if (input.range) |v| {
        try request.headers.put(allocator, "Range", v);
    }
    if (input.request_payer) |v| {
        try request.headers.put(allocator, "x-amz-request-payer", v.wireName());
    }
    if (input.sse_customer_algorithm) |v| {
        try request.headers.put(allocator, "x-amz-server-side-encryption-customer-algorithm", v);
    }
    if (input.sse_customer_key) |v| {
        try request.headers.put(allocator, "x-amz-server-side-encryption-customer-key", v);
    }
    if (input.sse_customer_key_md5) |v| {
        try request.headers.put(allocator, "x-amz-server-side-encryption-customer-key-MD5", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !HeadObjectOutput {
    var result: HeadObjectOutput = .{};
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
                if (std.mem.eql(u8, e.local, "Metadata")) {
                    result.metadata = try serde.deserializeMetadata(allocator, &reader, "entry");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("accept-ranges")) |value| {
        result.accept_ranges = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-archive-status")) |value| {
        result.archive_status = ArchiveStatus.fromWireName(value);
    }
    if (headers.get("x-amz-server-side-encryption-bucket-key-enabled")) |value| {
        result.bucket_key_enabled = std.mem.eql(u8, value, "true");
    }
    if (headers.get("cache-control")) |value| {
        result.cache_control = try allocator.dupe(u8, value);
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
    if (headers.get("x-amz-checksum-sha1")) |value| {
        result.checksum_sha1 = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-sha256")) |value| {
        result.checksum_sha256 = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-checksum-type")) |value| {
        result.checksum_type = ChecksumType.fromWireName(value);
    }
    if (headers.get("content-disposition")) |value| {
        result.content_disposition = try allocator.dupe(u8, value);
    }
    if (headers.get("content-encoding")) |value| {
        result.content_encoding = try allocator.dupe(u8, value);
    }
    if (headers.get("content-language")) |value| {
        result.content_language = try allocator.dupe(u8, value);
    }
    if (headers.get("content-length")) |value| {
        result.content_length = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (headers.get("content-range")) |value| {
        result.content_range = try allocator.dupe(u8, value);
    }
    if (headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-delete-marker")) |value| {
        result.delete_marker = std.mem.eql(u8, value, "true");
    }
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-expiration")) |value| {
        result.expiration = try allocator.dupe(u8, value);
    }
    if (headers.get("expires")) |value| {
        result.expires = try allocator.dupe(u8, value);
    }
    if (headers.get("last-modified")) |value| {
        result.last_modified = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (headers.get("x-amz-missing-meta")) |value| {
        result.missing_meta = std.fmt.parseInt(i32, value, 10) catch null;
    }
    if (headers.get("x-amz-object-lock-legal-hold")) |value| {
        result.object_lock_legal_hold_status = ObjectLockLegalHoldStatus.fromWireName(value);
    }
    if (headers.get("x-amz-object-lock-mode")) |value| {
        result.object_lock_mode = ObjectLockMode.fromWireName(value);
    }
    if (headers.get("x-amz-object-lock-retain-until-date")) |value| {
        result.object_lock_retain_until_date = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (headers.get("x-amz-mp-parts-count")) |value| {
        result.parts_count = std.fmt.parseInt(i32, value, 10) catch null;
    }
    if (headers.get("x-amz-replication-status")) |value| {
        result.replication_status = ReplicationStatus.fromWireName(value);
    }
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = RequestCharged.fromWireName(value);
    }
    if (headers.get("x-amz-restore")) |value| {
        result.restore = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-server-side-encryption")) |value| {
        result.server_side_encryption = ServerSideEncryption.fromWireName(value);
    }
    if (headers.get("x-amz-server-side-encryption-customer-algorithm")) |value| {
        result.sse_customer_algorithm = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-server-side-encryption-customer-key-md5")) |value| {
        result.sse_customer_key_md5 = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-server-side-encryption-aws-kms-key-id")) |value| {
        result.ssekms_key_id = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-storage-class")) |value| {
        result.storage_class = StorageClass.fromWireName(value);
    }
    if (headers.get("x-amz-tagging-count")) |value| {
        result.tag_count = std.fmt.parseInt(i32, value, 10) catch null;
    }
    if (headers.get("x-amz-version-id")) |value| {
        result.version_id = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-website-redirect-location")) |value| {
        result.website_redirect_location = try allocator.dupe(u8, value);
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
