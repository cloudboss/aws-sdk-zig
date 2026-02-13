const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AccessControlPolicy = @import("access_control_policy.zig").AccessControlPolicy;
const BucketCannedACL = @import("bucket_canned_acl.zig").BucketCannedACL;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const serde = @import("serde.zig");

/// **Important:**
///
/// End of support notice: As of October 1, 2025, Amazon S3 has discontinued
/// support for Email Grantee Access Control Lists (ACLs). If you attempt to use
/// an Email Grantee ACL in a request after October 1, 2025,
/// the request will receive an `HTTP 405` (Method Not Allowed) error.
///
/// This change affects the following Amazon Web Services Regions: US East (N.
/// Virginia), US West (N. California), US West (Oregon), Asia Pacific
/// (Singapore), Asia Pacific (Sydney), Asia Pacific (Tokyo), Europe (Ireland),
/// and South America (São Paulo).
///
/// **Note:**
///
/// This operation is not supported for directory buckets.
///
/// Sets the permissions on an existing bucket using access control lists (ACL).
/// For more information,
/// see [Using
/// ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/S3_ACLs_UsingACLs.html). To
/// set the ACL of a bucket, you must have the `WRITE_ACP` permission.
///
/// You can use one of the following two ways to set a bucket's permissions:
///
/// * Specify the ACL in the request body
///
/// * Specify permissions using request headers
///
/// **Note:**
///
/// You cannot specify access permission using both the body and the request
/// headers.
///
/// Depending on your application needs, you may choose to set the ACL on a
/// bucket using either the
/// request body or the headers. For example, if you have an existing
/// application that updates a bucket ACL
/// using the request body, then you can continue to use that approach.
///
/// **Important:**
///
/// If your bucket uses the bucket owner enforced setting for S3 Object
/// Ownership, ACLs are disabled
/// and no longer affect permissions. You must use policies to grant access to
/// your bucket and the objects
/// in it. Requests to set ACLs or update ACLs fail and return the
/// `AccessControlListNotSupported` error code. Requests to read ACLs are still
/// supported.
/// For more information, see [Controlling object
/// ownership](https://docs.aws.amazon.com/AmazonS3/latest/userguide/about-object-ownership.html) in
/// the *Amazon S3 User Guide*.
///
/// **Permissions**
///
/// You can set access permissions by using one of the following methods:
///
/// * Specify a canned ACL with the `x-amz-acl` request header. Amazon S3
///   supports a set
/// of predefined ACLs, known as *canned ACLs*. Each canned ACL has a
/// predefined set of grantees and permissions. Specify the canned ACL name as
/// the value of
/// `x-amz-acl`. If you use this header, you cannot use other access
/// control-specific
/// headers in your request. For more information, see [Canned
/// ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#CannedACL).
///
/// * Specify access permissions explicitly with the `x-amz-grant-read`,
/// `x-amz-grant-read-acp`, `x-amz-grant-write-acp`, and
/// `x-amz-grant-full-control` headers. When using these headers, you specify
/// explicit access permissions and grantees (Amazon Web Services accounts or
/// Amazon S3 groups) who will receive the
/// permission. If you use these ACL-specific headers, you cannot use the
/// `x-amz-acl`
/// header to set a canned ACL. These parameters map to the set of permissions
/// that Amazon S3 supports
/// in an ACL. For more information, see [Access Control List (ACL)
/// Overview](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html).
///
/// You specify each grantee as a type=value pair, where the type is one of the
/// following:
///
/// * `id` – if the value specified is the canonical user ID of an
/// Amazon Web Services account
///
/// * `uri` – if you are granting permissions to a predefined group
///
/// * `emailAddress` – if the value specified is the email address of an
/// Amazon Web Services account
///
/// **Note:**
///
/// Using email addresses to specify a grantee is only supported in the
/// following Amazon Web Services Regions:
///
/// * US East (N. Virginia)
///
/// * US West (N. California)
///
/// * US West (Oregon)
///
/// * Asia Pacific (Singapore)
///
/// * Asia Pacific (Sydney)
///
/// * Asia Pacific (Tokyo)
///
/// * Europe (Ireland)
///
/// * South America (São Paulo)
///
/// For a list of all the Amazon S3 supported Regions and endpoints, see
/// [Regions and
/// Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region) in the Amazon Web Services General Reference.
///
/// For example, the following `x-amz-grant-write` header grants create,
/// overwrite,
/// and delete objects permission to LogDelivery group predefined by Amazon S3
/// and two Amazon Web Services accounts
/// identified by their email addresses.
///
/// `x-amz-grant-write: uri="http://acs.amazonaws.com/groups/s3/LogDelivery",
/// id="111122223333", id="555566667777" `
///
/// You can use either a canned ACL or specify access permissions explicitly.
/// You cannot do
/// both.
///
/// **Grantee Values**
///
/// You can specify the person (grantee) to whom you're assigning access rights
/// (using request
/// elements) in the following ways. For examples of how to specify these
/// grantee values in JSON
/// format, see the Amazon Web Services CLI example in [ Enabling Amazon S3
/// server
/// access
/// logging](https://docs.aws.amazon.com/AmazonS3/latest/userguide/enable-server-access-logging.html) in the *Amazon S3 User Guide*.
///
/// * By the person's ID:
///
/// `<>ID<><>GranteesEmail<>
/// `
///
/// DisplayName is optional and ignored in the request
///
/// * By URI:
///
/// `<>http://acs.amazonaws.com/groups/global/AuthenticatedUsers<>`
///
/// * By Email address:
///
/// `<>Grantees@email.com<>&`
///
/// The grantee is resolved to the CanonicalUser and, in a response to a GET
/// Object acl
/// request, appears as the CanonicalUser.
///
/// **Note:**
///
/// Using email addresses to specify a grantee is only supported in the
/// following Amazon Web Services Regions:
///
/// * US East (N. Virginia)
///
/// * US West (N. California)
///
/// * US West (Oregon)
///
/// * Asia Pacific (Singapore)
///
/// * Asia Pacific (Sydney)
///
/// * Asia Pacific (Tokyo)
///
/// * Europe (Ireland)
///
/// * South America (São Paulo)
///
/// For a list of all the Amazon S3 supported Regions and endpoints, see
/// [Regions and
/// Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region) in the Amazon Web Services General Reference.
///
/// The following operations are related to `PutBucketAcl`:
///
/// *
///   [CreateBucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html)
///
/// *
///   [DeleteBucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucket.html)
///
/// *
///   [GetObjectAcl](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObjectAcl.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const PutBucketAclInput = struct {
    /// Contains the elements that set the ACL permissions for an object per
    /// grantee.
    access_control_policy: ?AccessControlPolicy = null,

    /// The canned ACL to apply to the bucket.
    acl: ?BucketCannedACL = null,

    /// The bucket to which to apply the ACL.
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

    /// The Base64 encoded 128-bit `MD5` digest of the data. This header must be
    /// used as a
    /// message integrity check to verify that the request body was not corrupted in
    /// transit. For more
    /// information, go to [RFC 1864.](http://www.ietf.org/rfc/rfc1864.txt)
    ///
    /// For requests made using the Amazon Web Services Command Line Interface (CLI)
    /// or Amazon Web Services SDKs, this field is calculated automatically.
    content_md5: ?[]const u8 = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// Allows grantee the read, write, read ACP, and write ACP permissions on the
    /// bucket.
    grant_full_control: ?[]const u8 = null,

    /// Allows grantee to list the objects in the bucket.
    grant_read: ?[]const u8 = null,

    /// Allows grantee to read the bucket ACL.
    grant_read_acp: ?[]const u8 = null,

    /// Allows grantee to create new objects in the bucket.
    ///
    /// For the bucket and object owners of existing objects, also allows deletions
    /// and overwrites of those
    /// objects.
    grant_write: ?[]const u8 = null,

    /// Allows grantee to write the ACL for the applicable bucket.
    grant_write_acp: ?[]const u8 = null,
};

pub const PutBucketAclOutput = struct {

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *PutBucketAclOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: PutBucketAclInput, options: Options) !PutBucketAclOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: PutBucketAclInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("s3", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.bucket);
    const path = try path_buf.toOwnedSlice(alloc);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(alloc, "acl");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = blk: {
        if (input.access_control_policy) |payload| {
            var body_buf: std.ArrayList(u8) = .{};
            try body_buf.appendSlice(alloc, "<AccessControlPolicy xmlns=" ++ &[_]u8{0x22} ++ "http://s3.amazonaws.com/doc/2006-03-01/" ++ &[_]u8{0x22} ++ ">");
            try serde.serializeAccessControlPolicy(alloc, &body_buf, payload);
            try body_buf.appendSlice(alloc, "</AccessControlPolicy>");
            break :blk try body_buf.toOwnedSlice(alloc);
        }
        break :blk null;
    };

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.acl) |v| {
        try request.headers.put(alloc, "x-amz-acl", @tagName(v));
    }
    if (input.checksum_algorithm) |v| {
        try request.headers.put(alloc, "x-amz-sdk-checksum-algorithm", @tagName(v));
    }
    if (input.content_md5) |v| {
        try request.headers.put(alloc, "Content-MD5", v);
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-expected-bucket-owner", v);
    }
    if (input.grant_full_control) |v| {
        try request.headers.put(alloc, "x-amz-grant-full-control", v);
    }
    if (input.grant_read) |v| {
        try request.headers.put(alloc, "x-amz-grant-read", v);
    }
    if (input.grant_read_acp) |v| {
        try request.headers.put(alloc, "x-amz-grant-read-acp", v);
    }
    if (input.grant_write) |v| {
        try request.headers.put(alloc, "x-amz-grant-write", v);
    }
    if (input.grant_write_acp) |v| {
        try request.headers.put(alloc, "x-amz-grant-write-acp", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutBucketAclOutput {
    _ = alloc;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutBucketAclOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";

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
