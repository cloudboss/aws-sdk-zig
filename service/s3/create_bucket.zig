const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BucketCannedACL = @import("bucket_canned_acl.zig").BucketCannedACL;
const CreateBucketConfiguration = @import("create_bucket_configuration.zig").CreateBucketConfiguration;
const ObjectOwnership = @import("object_ownership.zig").ObjectOwnership;

/// **Note:**
///
/// This action creates an Amazon S3 bucket. To create an Amazon S3 on Outposts
/// bucket, see [
/// `CreateBucket`
/// ](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateBucket.html).
///
/// Creates a new S3 bucket. To create a bucket, you must set up Amazon S3 and
/// have a valid Amazon Web Services Access Key
/// ID to authenticate requests. Anonymous requests are never allowed to create
/// buckets. By creating the
/// bucket, you become the bucket owner.
///
/// There are two types of buckets: general purpose buckets and directory
/// buckets. For more information about
/// these bucket types, see [Creating, configuring, and working with Amazon S3
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/creating-buckets-s3.html) in the *Amazon S3 User Guide*.
///
/// **Note:**
///
/// * **General purpose buckets** - If you send your
/// `CreateBucket` request to the `s3.amazonaws.com` global endpoint, the
/// request goes to the `us-east-1` Region. So the signature calculations in
/// Signature
/// Version 4 must use `us-east-1` as the Region, even if the location
/// constraint in the
/// request specifies another Region where the bucket is to be created. If you
/// create a bucket in a
/// Region other than US East (N. Virginia), your application must be able to
/// handle 307 redirect. For
/// more information, see [Virtual hosting of
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/dev/VirtualHosting.html) in the *Amazon S3 User Guide*.
///
/// * **Directory buckets ** - For directory buckets, you must make requests for
///   this API operation to the Regional endpoint. These endpoints support
///   path-style requests in the format
///   `https://s3express-control.*region-code*.amazonaws.com/*bucket-name*
/// `. Virtual-hosted-style requests aren't supported.
/// For more information about endpoints in Availability Zones, see [Regional
/// and Zonal endpoints for directory buckets in Availability
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/endpoint-directory-buckets-AZ.html) in the
/// *Amazon S3 User Guide*. For more information about endpoints in Local Zones,
/// see [Concepts for directory buckets in Local
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-lzs-for-directory-buckets.html) in the
/// *Amazon S3 User Guide*.
///
/// **Permissions**
///
/// * **General purpose bucket permissions** - In addition to the
/// `s3:CreateBucket` permission, the following permissions are required in a
/// policy
/// when your `CreateBucket` request includes specific headers:
///
/// * **Access control lists (ACLs)** - In your
/// `CreateBucket` request, if you specify an access control list (ACL) and set
/// it to `public-read`, `public-read-write`,
/// `authenticated-read`, or if you explicitly specify any other custom ACLs,
/// both `s3:CreateBucket` and `s3:PutBucketAcl` permissions are
/// required. In your `CreateBucket` request, if you set the ACL to
/// `private`, or if you don't specify any ACLs, only the
/// `s3:CreateBucket` permission is required.
///
/// * **Object Lock** - In your
/// `CreateBucket` request, if you set
/// `x-amz-bucket-object-lock-enabled` to true, the
/// `s3:PutBucketObjectLockConfiguration` and `s3:PutBucketVersioning`
/// permissions are required.
///
/// * **S3 Object Ownership** - If your
/// `CreateBucket` request includes the `x-amz-object-ownership`
/// header, then the `s3:PutBucketOwnershipControls` permission is required.
///
/// **Important:**
///
/// To set an ACL on a bucket as part of a `CreateBucket` request, you must
/// explicitly set S3 Object Ownership for the bucket to a different value than
/// the default,
/// `BucketOwnerEnforced`. Additionally, if your desired bucket ACL grants
/// public access, you must first create the bucket (without the bucket ACL) and
/// then
/// explicitly disable Block Public Access on the bucket before using
/// `PutBucketAcl` to set the ACL. If you try to create a bucket with a public
/// ACL, the request will fail.
///
/// For the majority of modern use cases in S3, we recommend that you keep all
/// Block
/// Public Access settings enabled and keep ACLs disabled. If you would like to
/// share data
/// with users outside of your account, you can use bucket policies as needed.
/// For more
/// information, see [Controlling ownership of
/// objects and disabling ACLs for your bucket
/// ](https://docs.aws.amazon.com/AmazonS3/latest/userguide/about-object-ownership.html) and [Blocking
/// public access to your Amazon S3 storage
/// ](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html) in the
/// *Amazon S3 User Guide*.
///
/// * **S3 Block Public Access** - If your specific use
/// case requires granting public access to your S3 resources, you can disable
/// Block Public
/// Access. Specifically, you can create a new bucket with Block Public Access
/// enabled, then
/// separately call the [
/// `DeletePublicAccessBlock`
/// ](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeletePublicAccessBlock.html) API. To use this operation, you must have the
/// `s3:PutBucketPublicAccessBlock` permission. For more information about S3
/// Block Public Access, see [Blocking public
/// access to your Amazon S3 storage
/// ](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-control-block-public-access.html) in the *Amazon S3 User Guide*.
///
/// * **Directory bucket permissions** - You must have the
/// `s3express:CreateBucket` permission in an IAM identity-based policy instead
/// of a bucket policy.
/// Cross-account access to this API operation isn't supported. This operation
/// can only be performed by the Amazon Web Services account that owns the
/// resource. For more information about directory bucket policies and
/// permissions, see [Amazon Web Services Identity and Access Management (IAM)
/// for S3 Express One
/// Zone](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-security-iam.html) in the *Amazon S3 User Guide*.
///
/// **Important:**
///
/// The permissions for ACLs, Object Lock, S3 Object Ownership, and S3 Block
/// Public Access
/// are not supported for directory buckets. For directory buckets, all Block
/// Public Access
/// settings are enabled at the bucket level and S3 Object Ownership is set to
/// Bucket owner
/// enforced (ACLs disabled). These settings can't be modified.
///
/// For more information about permissions for creating and working with
/// directory buckets,
/// see [Directory
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-overview.html)
/// in the *Amazon S3 User Guide*. For more information about supported S3
/// features for directory buckets, see [Features of
/// S3 Express One
/// Zone](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-one-zone.html#s3-express-features) in the *Amazon S3 User Guide*.
///
/// **HTTP Host header syntax**
///
/// **Directory buckets ** - The HTTP Host header syntax is
/// `s3express-control.*region-code*.amazonaws.com`.
///
/// The following operations are related to `CreateBucket`:
///
/// *
///   [PutObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html)
///
/// *
///   [DeleteBucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteBucket.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const CreateBucketInput = struct {
    /// The canned ACL to apply to the bucket.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    acl: ?BucketCannedACL = null,

    /// The name of the bucket to create.
    ///
    /// **General purpose buckets** - For information about bucket naming
    /// restrictions, see [Bucket naming
    /// rules](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html) in the *Amazon S3 User Guide*.
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

    /// The configuration information for the bucket.
    create_bucket_configuration: ?CreateBucketConfiguration = null,

    /// Allows grantee the read, write, read ACP, and write ACP permissions on the
    /// bucket.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    grant_full_control: ?[]const u8 = null,

    /// Allows grantee to list the objects in the bucket.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    grant_read: ?[]const u8 = null,

    /// Allows grantee to read the bucket ACL.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    grant_read_acp: ?[]const u8 = null,

    /// Allows grantee to create new objects in the bucket.
    ///
    /// For the bucket and object owners of existing objects, also allows deletions
    /// and overwrites of those
    /// objects.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    grant_write: ?[]const u8 = null,

    /// Allows grantee to write the ACL for the applicable bucket.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    grant_write_acp: ?[]const u8 = null,

    /// Specifies whether you want S3 Object Lock to be enabled for the new bucket.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    object_lock_enabled_for_bucket: ?bool = null,

    object_ownership: ?ObjectOwnership = null,
};

pub const CreateBucketOutput = struct {
    /// The Amazon Resource Name (ARN) of the S3 bucket. ARNs uniquely identify
    /// Amazon Web Services resources across all
    /// of Amazon Web Services.
    ///
    /// **Note:**
    ///
    /// This parameter is only supported for S3 directory buckets. For more
    /// information, see [Using tags with
    /// directory
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-tagging.html).
    bucket_arn: ?[]const u8 = null,

    /// A forward slash followed by the name of the bucket.
    location: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateBucketOutput) void {
        if (self.bucket_arn) |v| {
            self.allocator.free(v);
        }
        if (self.location) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateBucketInput, options: Options) !CreateBucketOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateBucketInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("s3", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.bucket);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.acl) |v| {
        try request.headers.put(alloc, "x-amz-acl", @tagName(v));
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
    if (input.object_lock_enabled_for_bucket) |v| {
        try request.headers.put(alloc, "x-amz-bucket-object-lock-enabled", if (v) "true" else "false");
    }
    if (input.object_ownership) |v| {
        try request.headers.put(alloc, "x-amz-object-ownership", @tagName(v));
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !CreateBucketOutput {
    _ = body;
    _ = status;
    const result: CreateBucketOutput = .{ .allocator = alloc };

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
