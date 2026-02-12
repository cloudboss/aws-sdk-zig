const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const RequestCharged = @import("request_charged.zig").RequestCharged;

/// Removes an object from a bucket. The behavior depends on the bucket's
/// versioning state:
///
/// * If bucket versioning is not enabled, the operation permanently deletes the
///   object.
///
/// * If bucket versioning is enabled, the operation inserts a delete marker,
///   which becomes the
/// current version of the object. To permanently delete an object in a
/// versioned bucket, you must
/// include the object’s `versionId` in the request. For more information about
/// versioning-enabled buckets, see [Deleting object versions from a
/// versioning-enabled
/// bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/DeletingObjectVersions.html).
///
/// * If bucket versioning is suspended, the operation removes the object that
///   has a null
/// `versionId`, if there is one, and inserts a delete marker that becomes the
/// current
/// version of the object. If there isn't an object with a null `versionId`, and
/// all versions
/// of the object have a `versionId`, Amazon S3 does not remove the object and
/// only inserts a
/// delete marker. To permanently delete an object that has a `versionId`, you
/// must include
/// the object’s `versionId` in the request. For more information about
/// versioning-suspended
/// buckets, see [Deleting
/// objects from versioning-suspended
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/DeletingObjectsfromVersioningSuspendedBuckets.html).
///
/// **Note:**
///
/// * **Directory buckets** - S3 Versioning isn't enabled and supported for
///   directory buckets. For this API operation, only the `null` value of the
///   version ID is supported by directory buckets.
/// You can only specify `null` to the `versionId` query parameter in the
/// request.
///
/// * **Directory buckets** - For directory buckets, you must make requests for
///   this API operation to the Zonal endpoint. These endpoints support
///   virtual-hosted-style requests in the format
///   `https://*amzn-s3-demo-bucket*.s3express-*zone-id*.*region-code*.amazonaws.com/*key-name*
/// `. Path-style requests are not supported. For more information about
/// endpoints in Availability Zones, see [Regional and Zonal endpoints for
/// directory buckets in Availability
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/endpoint-directory-buckets-AZ.html) in the
/// *Amazon S3 User Guide*. For more information about endpoints in Local Zones,
/// see [Concepts for directory buckets in Local
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-lzs-for-directory-buckets.html) in the
/// *Amazon S3 User Guide*.
///
/// To remove a specific version, you must use the `versionId` query parameter.
/// Using this
/// query parameter permanently deletes the version. If the object deleted is a
/// delete marker, Amazon S3 sets the
/// response header `x-amz-delete-marker` to true.
///
/// If the object you want to delete is in a bucket where the bucket versioning
/// configuration is MFA
/// Delete enabled, you must include the `x-amz-mfa` request header in the
/// DELETE
/// `versionId` request. Requests that include `x-amz-mfa` must use HTTPS. For
/// more
/// information about MFA Delete, see [Using MFA
/// Delete](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingMFADelete.html)
/// in the *Amazon S3 User
/// Guide*. To see sample requests that use versioning, see [Sample
/// Request](https://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectDELETE.html#ExampleVersionObjectDelete).
///
/// **Note:**
///
/// **Directory buckets** - MFA delete is not supported by directory buckets.
///
/// You can delete objects by explicitly calling DELETE Object or calling
/// ([PutBucketLifecycle](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycle.html)) to enable Amazon S3 to
/// remove them for you. If you want to block users or accounts from removing or
/// deleting objects from your
/// bucket, you must deny them the `s3:DeleteObject`, `s3:DeleteObjectVersion`,
/// and
/// `s3:PutLifeCycleConfiguration` actions.
///
/// **Note:**
///
/// **Directory buckets** -
/// S3 Lifecycle is not supported by directory buckets.
///
/// **Permissions**
///
/// * **General purpose bucket permissions** - The following
/// permissions are required in your policies when your `DeleteObjects` request
/// includes specific headers.
///
/// * **
/// `s3:DeleteObject`
/// ** - To
/// delete an object from a bucket, you must always have the
/// `s3:DeleteObject` permission.
///
/// * **
/// `s3:DeleteObjectVersion`
/// ** - To delete a specific version of an object from a versioning-enabled
/// bucket, you must have the `s3:DeleteObjectVersion` permission.
///
/// **Note:**
///
/// If the `s3:DeleteObject` or `s3:DeleteObjectVersion` permissions are
/// explicitly
/// denied in your bucket policy, attempts to delete any unversioned objects
/// result in a `403 Access Denied` error.
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
/// **HTTP Host header syntax**
///
/// **Directory buckets ** - The HTTP Host header syntax is `
/// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`.
///
/// The following action is related to `DeleteObject`:
///
/// *
///   [PutObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
///
/// **Note:**
///
/// The `If-Match` header is supported for both general purpose and directory
/// buckets. `IfMatchLastModifiedTime` and `IfMatchSize` is only supported for
/// directory buckets.
pub const DeleteObjectInput = struct {
    /// The bucket name of the bucket containing the object.
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

    /// Indicates whether S3 Object Lock should bypass Governance-mode restrictions
    /// to process this
    /// operation. To use this header, you must have the
    /// `s3:BypassGovernanceRetention`
    /// permission.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    bypass_governance_retention: ?bool = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// Deletes the object if the ETag (entity tag) value provided during the delete
    /// operation matches the ETag of the object in S3.
    /// If the ETag values do not match, the operation returns a `412 Precondition
    /// Failed` error.
    ///
    /// Expects the ETag value as a string. `If-Match` does accept a string value of
    /// an '*' (asterisk) character to denote a match of any ETag.
    ///
    /// For more information about conditional requests, see [RFC
    /// 7232](https://tools.ietf.org/html/rfc7232).
    if_match: ?[]const u8 = null,

    /// If present, the object is deleted only if its modification times matches the
    /// provided
    /// `Timestamp`. If the `Timestamp` values do not match, the operation returns a
    /// `412 Precondition Failed` error. If the `Timestamp` matches or if the object
    /// doesn’t exist, the operation returns a `204 Success (No Content)` response.
    ///
    /// **Note:**
    ///
    /// This functionality is only supported for directory buckets.
    if_match_last_modified_time: ?i64 = null,

    /// If present, the object is deleted only if its size matches the provided size
    /// in bytes. If the
    /// `Size` value does not match, the operation returns a `412 Precondition
    /// Failed`
    /// error. If the `Size` matches or if the object doesn’t exist, the operation
    /// returns a
    /// `204 Success (No Content)` response.
    ///
    /// **Note:**
    ///
    /// This functionality is only supported for directory buckets.
    ///
    /// **Important:**
    ///
    /// You can use the `If-Match`, `x-amz-if-match-last-modified-time` and
    /// `x-amz-if-match-size` conditional headers in conjunction with each-other or
    /// individually.
    if_match_size: ?i64 = null,

    /// Key name of the object to delete.
    key: []const u8,

    /// The concatenation of the authentication device's serial number, a space, and
    /// the value that is
    /// displayed on your authentication device. Required to permanently delete a
    /// versioned object if versioning
    /// is configured with MFA delete enabled.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    mfa: ?[]const u8 = null,

    request_payer: ?RequestPayer = null,

    /// Version ID used to reference a specific version of the object.
    ///
    /// **Note:**
    ///
    /// For directory buckets in this API operation, only the `null` value of the
    /// version ID is supported.
    version_id: ?[]const u8 = null,
};

pub const DeleteObjectOutput = struct {
    /// Indicates whether the specified object version that was permanently deleted
    /// was (true) or was not
    /// (false) a delete marker before deletion. In a simple DELETE, this header
    /// indicates whether (true) or not
    /// (false) the current version of the object is a delete marker. To learn more
    /// about delete markers, see
    /// [Working with delete
    /// markers](https://docs.aws.amazon.com/AmazonS3/latest/userguide/DeleteMarker.html).
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    delete_marker: ?bool = null,

    request_charged: ?RequestCharged = null,

    /// Returns the version ID of the delete marker created as a result of the
    /// DELETE operation.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    version_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DeleteObjectOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DeleteObjectInput, options: Options) !DeleteObjectOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DeleteObjectInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(alloc, "x-id=DeleteObject");
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
    request.method = .DELETE;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.bypass_governance_retention) |v| {
        try request.headers.put(alloc, "x-amz-bypass-governance-retention", if (v) "true" else "false");
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-expected-bucket-owner", v);
    }
    if (input.if_match) |v| {
        try request.headers.put(alloc, "If-Match", v);
    }
    if (input.if_match_last_modified_time) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-if-match-last-modified-time", num_str);
        }
    }
    if (input.if_match_size) |v| {
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try request.headers.put(alloc, "x-amz-if-match-size", num_str);
        }
    }
    if (input.mfa) |v| {
        try request.headers.put(alloc, "x-amz-mfa", v);
    }
    if (input.request_payer) |v| {
        try request.headers.put(alloc, "x-amz-request-payer", @tagName(v));
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DeleteObjectOutput {
    var result: DeleteObjectOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("x-amz-delete-marker")) |value| {
        result.delete_marker = std.mem.eql(u8, value, "true");
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
