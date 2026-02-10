const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LocationType = @import("location_type.zig").LocationType;

/// You can use this operation to determine if a bucket exists and if you have
/// permission to access it.
/// The action returns a `200 OK` HTTP status code if the bucket exists and you
/// have
/// permission to access it. You can make a `HeadBucket` call on any bucket name
/// to any
/// Region in the partition, and regardless of the permissions on the bucket,
/// you will receive a
/// response header with the correct bucket location so that you can then make a
/// proper, signed request
/// to the appropriate Regional endpoint.
///
/// **Note:**
///
/// If the bucket doesn't exist or you don't have permission to access it, the
/// `HEAD`
/// request returns a generic `400 Bad Request`, `403 Forbidden`, or
/// `404 Not Found` HTTP status code. A message body isn't included, so you
/// can't determine
/// the exception beyond these HTTP response codes.
///
/// **Authentication and authorization**
///
/// **General purpose buckets** - Request to public buckets that
/// grant the s3:ListBucket permission publicly do not need to be signed. All
/// other
/// `HeadBucket` requests must be authenticated and signed by using IAM
/// credentials
/// (access key ID and secret access key for the IAM identities). All headers
/// with the
/// `x-amz-` prefix, including `x-amz-copy-source`, must be signed. For more
/// information, see [REST
/// Authentication](https://docs.aws.amazon.com/AmazonS3/latest/dev/RESTAuthentication.html).
///
/// **Directory buckets** - You must use IAM credentials to
/// authenticate and authorize your access to the `HeadBucket` API operation,
/// instead of
/// using the temporary security credentials through the `CreateSession` API
/// operation.
///
/// Amazon Web Services CLI or SDKs handles authentication and authorization on
/// your behalf.
///
/// **Permissions**
///
/// * **General purpose bucket permissions** - To use this
/// operation, you must have permissions to perform the `s3:ListBucket` action.
/// The
/// bucket owner has this permission by default and can grant this permission to
/// others. For more
/// information about permissions, see [Managing access permissions to your
/// Amazon S3
/// resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-access-control.html) in the *Amazon S3 User Guide*.
///
/// * **Directory bucket permissions** - You must have the
/// **
/// `s3express:CreateSession`
/// ** permission in the
/// `Action` element of a policy. By default, the session is in the
/// `ReadWrite` mode. If you want to restrict the access, you can explicitly set
/// the
/// `s3express:SessionMode` condition key to `ReadOnly` on the
/// bucket.
///
/// For more information about example bucket policies, see [Example
/// bucket policies for S3 Express One
/// Zone](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-security-iam-example-bucket-policies.html) and [Amazon Web Services
/// Identity and Access Management (IAM) identity-based policies for S3 Express
/// One
/// Zone](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-express-security-iam-identity-policies.html) in the
/// *Amazon S3 User Guide*.
///
/// **HTTP Host header syntax**
///
/// **Directory buckets ** - The HTTP Host header syntax is `
/// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`.
///
/// **Note:**
///
/// You must make requests for this API operation to the Zonal endpoint. These
/// endpoints support virtual-hosted-style requests in the format
/// `https://*bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`.
/// Path-style requests are not supported. For more information about endpoints
/// in Availability Zones, see [Regional and Zonal endpoints for directory
/// buckets in Availability
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/endpoint-directory-buckets-AZ.html) in the
/// *Amazon S3 User Guide*. For more information about endpoints in Local Zones,
/// see [Concepts for directory buckets in Local
/// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-lzs-for-directory-buckets.html) in the
/// *Amazon S3 User Guide*.
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const HeadBucketInput = struct {
    /// The bucket name.
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
    /// **Object Lambda access points** - When you use this API operation with an
    /// Object Lambda access point, provide the alias of the Object Lambda access
    /// point in place of the bucket name.
    /// If the Object Lambda access point alias in a request is not valid, the error
    /// code `InvalidAccessPointAliasError` is returned.
    /// For more information about `InvalidAccessPointAliasError`, see [List of
    /// Error
    /// Codes](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html#ErrorCodeList).
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
};

pub const HeadBucketOutput = struct {
    /// Indicates whether the bucket name used in the request is an access point
    /// alias.
    ///
    /// **Note:**
    ///
    /// For directory buckets, the value of this field is `false`.
    access_point_alias: ?bool = null,

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

    /// The name of the location where the bucket will be created.
    ///
    /// For directory buckets, the Zone ID of the Availability Zone or the Local
    /// Zone where the bucket is created. An example
    /// Zone ID value for an Availability Zone is `usw2-az1`.
    ///
    /// **Note:**
    ///
    /// This functionality is only supported by directory buckets.
    bucket_location_name: ?[]const u8 = null,

    /// The type of location where the bucket is created.
    ///
    /// **Note:**
    ///
    /// This functionality is only supported by directory buckets.
    bucket_location_type: ?LocationType = null,

    /// The Region that the bucket is located.
    bucket_region: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const HeadBucketOutput) void {
        if (self.bucket_arn) |v| {
            self.allocator.free(v);
        }
        if (self.bucket_location_name) |v| {
            self.allocator.free(v);
        }
        if (self.bucket_region) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: HeadBucketInput, options: Options) !HeadBucketOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: HeadBucketInput, config: *aws.Config) !aws.http.Request {
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
    request.method = .HEAD;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/xml");
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(alloc, "x-amz-expected-bucket-owner", v);
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !HeadBucketOutput {
    _ = body;
    _ = status;
    const result: HeadBucketOutput = .{ .allocator = alloc };

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
