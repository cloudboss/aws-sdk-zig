const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const RestoreRequest = @import("restore_request.zig").RestoreRequest;
const RequestCharged = @import("request_charged.zig").RequestCharged;

/// **Note:**
///
/// This operation is not supported for directory buckets.
///
/// Restores an archived copy of an object back into Amazon S3
///
/// This functionality is not supported for Amazon S3 on Outposts.
///
/// This action performs the following types of requests:
///
/// * `restore an archive` - Restore an archived object
///
/// For more information about the `S3` structure in the request body, see the
/// following:
///
/// *
///   [PutObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html)
///
/// * [Managing Access
/// with
/// ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html) in the *Amazon S3 User Guide*
///
/// * [Protecting Data
/// Using Server-Side
/// Encryption](https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html) in the *Amazon S3 User Guide*
///
/// **Permissions**
///
/// To use this operation, you must have permissions to perform the
/// `s3:RestoreObject`
/// action. The bucket owner has this permission by default and can grant this
/// permission to others.
/// For more information about permissions, see [Permissions Related to Bucket
/// Subresource
/// Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources) and [Managing Access Permissions to Your Amazon S3
/// Resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-access-control.html) in the *Amazon S3 User Guide*.
///
/// **Restoring objects**
///
/// Objects that you archive to the S3 Glacier Flexible Retrieval or S3 Glacier
/// Deep Archive
/// storage class, and S3 Intelligent-Tiering Archive or S3 Intelligent-Tiering
/// Deep Archive tiers, are not accessible in
/// real time. For objects in the S3 Glacier Flexible Retrieval or S3 Glacier
/// Deep Archive
/// storage classes, you must first initiate a restore request, and then wait
/// until a temporary copy
/// of the object is available. If you want a permanent copy of the object,
/// create a copy of it in the
/// Amazon S3 Standard storage class in your S3 bucket. To access an archived
/// object, you must restore the
/// object for the duration (number of days) that you specify. For objects in
/// the Archive Access or
/// Deep Archive Access tiers of S3 Intelligent-Tiering, you must first initiate
/// a restore request, and
/// then wait until the object is moved into the Frequent Access tier.
///
/// To restore a specific object version, you can provide a version ID. If you
/// don't provide a
/// version ID, Amazon S3 restores the current version.
///
/// When restoring an archived object, you can specify one of the following data
/// access tier
/// options in the `Tier` element of the request body:
///
/// * `Expedited` - Expedited retrievals allow you to quickly access your data
///   stored
/// in the S3 Glacier Flexible Retrieval storage class or S3 Intelligent-Tiering
/// Archive tier when occasional
/// urgent requests for restoring archives are required. For all but the largest
/// archived objects
/// (250 MB+), data accessed using Expedited retrievals is typically made
/// available within 1–5
/// minutes. Provisioned capacity ensures that retrieval capacity for Expedited
/// retrievals is
/// available when you need it. Expedited retrievals and provisioned capacity
/// are not available
/// for objects stored in the S3 Glacier Deep Archive storage class or
/// S3 Intelligent-Tiering Deep Archive tier.
///
/// * `Standard` - Standard retrievals allow you to access any of your archived
/// objects within several hours. This is the default option for retrieval
/// requests that do not
/// specify the retrieval option. Standard retrievals typically finish within
/// 3–5 hours for
/// objects stored in the S3 Glacier Flexible Retrieval storage class or S3
/// Intelligent-Tiering Archive tier.
/// They typically finish within 12 hours for objects stored in the
/// S3 Glacier Deep Archive storage class or S3 Intelligent-Tiering Deep Archive
/// tier. Standard
/// retrievals are free for objects stored in S3 Intelligent-Tiering.
///
/// * `Bulk` - Bulk retrievals free for objects stored in the S3 Glacier
///   Flexible
/// Retrieval and S3 Intelligent-Tiering storage classes, enabling you to
/// retrieve large amounts,
/// even petabytes, of data at no cost. Bulk retrievals typically finish within
/// 5–12 hours for
/// objects stored in the S3 Glacier Flexible Retrieval storage class or S3
/// Intelligent-Tiering Archive tier.
/// Bulk retrievals are also the lowest-cost retrieval option when restoring
/// objects from
/// S3 Glacier Deep Archive. They typically finish within 48 hours for objects
/// stored in
/// the S3 Glacier Deep Archive storage class or S3 Intelligent-Tiering Deep
/// Archive tier.
///
/// For more information about archive retrieval options and provisioned
/// capacity for
/// `Expedited` data access, see [Restoring Archived
/// Objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/restoring-objects.html) in the
/// *Amazon S3 User Guide*.
///
/// You can use Amazon S3 restore speed upgrade to change the restore speed to a
/// faster speed while it
/// is in progress. For more information, see [
/// Upgrading the speed of an in-progress
/// restore](https://docs.aws.amazon.com/AmazonS3/latest/dev/restoring-objects.html#restoring-objects-upgrade-tier.title.html) in the
/// *Amazon S3 User Guide*.
///
/// To get the status of object restoration, you can send a `HEAD` request.
/// Operations
/// return the `x-amz-restore` header, which provides information about the
/// restoration
/// status, in the response. You can use Amazon S3 event notifications to notify
/// you when a restore is
/// initiated or completed. For more information, see [Configuring Amazon S3
/// Event
/// Notifications](https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html) in
/// the *Amazon S3 User Guide*.
///
/// After restoring an archived object, you can update the restoration period by
/// reissuing the
/// request with a new period. Amazon S3 updates the restoration period relative
/// to the current time and
/// charges only for the request-there are no data transfer charges. You cannot
/// update the
/// restoration period when Amazon S3 is actively processing your current
/// restore request for the
/// object.
///
/// If your bucket has a lifecycle configuration with a rule that includes an
/// expiration action,
/// the object expiration overrides the life span that you specify in a restore
/// request. For example,
/// if you restore an object copy for 10 days, but the object is scheduled to
/// expire in 3 days, Amazon S3
/// deletes the object in 3 days. For more information about lifecycle
/// configuration, see
/// [PutBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html) and [Object Lifecycle Management](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html) in
/// *Amazon S3 User Guide*.
///
/// **Responses**
///
/// A successful action returns either the `200 OK` or `202 Accepted` status
/// code.
///
/// * If the object is not previously restored, then Amazon S3 returns `202
///   Accepted` in
/// the response.
///
/// * If the object is previously restored, Amazon S3 returns `200 OK` in the
///   response.
///
/// * Special errors:
///
/// * *Code: RestoreAlreadyInProgress*
///
/// * *Cause: Object restore is already in progress.*
///
/// * *HTTP Status Code: 409 Conflict*
///
/// * *SOAP Fault Code Prefix: Client*
///
/// *
///
/// * *Code: GlacierExpeditedRetrievalNotAvailable*
///
/// * *Cause: expedited retrievals are currently not available. Try again later.
/// (Returned if there is insufficient capacity to process the Expedited
/// request. This error
/// applies only to Expedited retrievals and not to S3 Standard or Bulk
/// retrievals.)*
///
/// * *HTTP Status Code: 503*
///
/// * *SOAP Fault Code Prefix: N/A*
///
/// The following operations are related to `RestoreObject`:
///
/// *
///   [PutBucketLifecycleConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutBucketLifecycleConfiguration.html)
///
/// *
///   [GetBucketNotificationConfiguration](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketNotificationConfiguration.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const RestoreObjectInput = struct {
    /// The bucket name containing the object to restore.
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
    /// **S3 on Outposts** - When you use this action with S3 on Outposts, you must
    /// direct requests to the S3 on Outposts hostname. The S3 on Outposts hostname
    /// takes the
    /// form `
    /// *AccessPointName*-*AccountId*.*outpostID*.s3-outposts.*Region*.amazonaws.com`. When you use this action with S3 on Outposts, the destination bucket must be the Outposts access point ARN or the access point alias. For more information about S3 on Outposts, see [What is S3 on Outposts?](https://docs.aws.amazon.com/AmazonS3/latest/userguide/S3onOutposts.html) in the *Amazon S3 User Guide*.
    bucket: []const u8,

    /// Indicates the algorithm used to create the checksum for the object when you
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
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// Object key for which the action was initiated.
    key: []const u8,

    request_payer: ?RequestPayer = null,

    restore_request: ?RestoreRequest = null,

    /// VersionId used to reference a specific version of the object.
    version_id: ?[]const u8 = null,
};

pub const RestoreObjectOutput = struct {
    request_charged: ?RequestCharged = null,

    /// Indicates the path in the provided S3 output location where Select results
    /// will be restored
    /// to.
    restore_output_path: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *RestoreObjectOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: RestoreObjectInput, options: Options) !RestoreObjectOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: RestoreObjectInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(alloc, "restore");
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
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.checksum_algorithm) |v| {
        try request.headers.put(alloc, "x-amz-sdk-checksum-algorithm", @tagName(v));
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-expected-bucket-owner", v);
    }
    if (input.request_payer) |v| {
        try request.headers.put(alloc, "x-amz-request-payer", @tagName(v));
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RestoreObjectOutput {
    var result: RestoreObjectOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = std.meta.stringToEnum(RequestCharged, value);
    }
    if (headers.get("x-amz-restore-output-path")) |value| {
        result.restore_output_path = try alloc.dupe(u8, value);
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
