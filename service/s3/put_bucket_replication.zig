const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const ReplicationConfiguration = @import("replication_configuration.zig").ReplicationConfiguration;

/// **Note:**
///
/// This operation is not supported for directory buckets.
///
/// Creates a replication configuration or replaces an existing one. For more
/// information, see
/// [Replication](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html) in the
/// *Amazon S3 User Guide*.
///
/// Specify the replication configuration in the request body. In the
/// replication configuration, you
/// provide the name of the destination bucket or buckets where you want Amazon
/// S3 to replicate objects, the
/// IAM role that Amazon S3 can assume to replicate objects on your behalf, and
/// other relevant information. You
/// can invoke this request for a specific Amazon Web Services Region by using
/// the [
/// `aws:RequestedRegion`
/// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_condition-keys.html#condition-keys-requestedregion) condition key.
///
/// A replication configuration must include at least one rule, and can contain
/// a maximum of 1,000. Each
/// rule identifies a subset of objects to replicate by filtering the objects in
/// the source bucket. To
/// choose additional subsets of objects to replicate, add a rule for each
/// subset.
///
/// To specify a subset of the objects in the source bucket to apply a
/// replication rule to, add the
/// Filter element as a child of the Rule element. You can filter objects based
/// on an object key prefix, one
/// or more object tags, or both. When you add the Filter element in the
/// configuration, you must also add
/// the following elements: `DeleteMarkerReplication`, `Status`, and
/// `Priority`.
///
/// **Note:**
///
/// If you are using an earlier version of the replication configuration, Amazon
/// S3 handles replication of
/// delete markers differently. For more information, see [Backward
/// Compatibility](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-add-config.html#replication-backward-compat-considerations).
///
/// For information about enabling versioning on a bucket, see [Using
/// Versioning](https://docs.aws.amazon.com/AmazonS3/latest/dev/Versioning.html).
///
/// **Handling Replication of Encrypted Objects**
///
/// By default, Amazon S3 doesn't replicate objects that are stored at rest
/// using server-side
/// encryption with KMS keys. To replicate Amazon Web Services KMS-encrypted
/// objects, add the following:
/// `SourceSelectionCriteria`, `SseKmsEncryptedObjects`, `Status`,
/// `EncryptionConfiguration`, and `ReplicaKmsKeyID`. For information about
/// replication configuration, see [Replicating Objects Created
/// with SSE Using KMS
/// keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication-config-for-kms-objects.html).
///
/// For information on `PutBucketReplication` errors, see [List of
/// replication-related error
/// codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#ReplicationErrorCodeList)
///
/// **Permissions**
///
/// To create a `PutBucketReplication` request, you must have
/// `s3:PutReplicationConfiguration` permissions for the bucket.
///
/// By default, a resource owner, in this case the Amazon Web Services account
/// that created the bucket, can
/// perform this operation. The resource owner can also grant others permissions
/// to perform the
/// operation. For more information about permissions, see [Specifying
/// Permissions in a
/// Policy](https://docs.aws.amazon.com/AmazonS3/latest/dev/using-with-s3-actions.html)
/// and [Managing
/// Access Permissions to Your Amazon S3
/// Resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-access-control.html).
///
/// **Note:**
///
/// To perform this operation, the user or role performing the action must have
/// the
/// [iam:PassRole](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_passrole.html) permission.
///
/// The following operations are related to `PutBucketReplication`:
///
/// *
///   [GetBucketReplication](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetBucketReplication.html)
///
/// *
///   [DeleteBucketReplication](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucketReplication.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const PutBucketReplicationInput = struct {
    /// The name of the bucket
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
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// The Base64 encoded 128-bit `MD5` digest of the data. You must use this
    /// header as a
    /// message integrity check to verify that the request body was not corrupted in
    /// transit. For more
    /// information, see [RFC 1864](http://www.ietf.org/rfc/rfc1864.txt).
    ///
    /// For requests made using the Amazon Web Services Command Line Interface (CLI)
    /// or Amazon Web Services SDKs, this field is calculated automatically.
    content_md5: ?[]const u8 = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    replication_configuration: ReplicationConfiguration,

    /// A token to allow Object Lock to be enabled for an existing bucket.
    token: ?[]const u8 = null,
};

pub const PutBucketReplicationOutput = struct {

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const PutBucketReplicationOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: PutBucketReplicationInput, options: Options) !PutBucketReplicationOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: PutBucketReplicationInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(alloc, "replication");
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
    if (input.token) |v| {
        try request.headers.put(alloc, "x-amz-bucket-object-lock-token", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !PutBucketReplicationOutput {
    _ = body;
    _ = status;
    const result: PutBucketReplicationOutput = .{ .allocator = alloc };

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
