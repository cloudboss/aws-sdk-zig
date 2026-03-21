const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const ChecksumType = @import("checksum_type.zig").ChecksumType;
const Initiator = @import("initiator.zig").Initiator;
const Owner = @import("owner.zig").Owner;
const Part = @import("part.zig").Part;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const StorageClass = @import("storage_class.zig").StorageClass;
const serde = @import("serde.zig");

pub const ListPartsInput = struct {
    /// The name of the bucket to which the parts are being uploaded.
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

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// Object key for which the multipart upload was initiated.
    key: []const u8,

    /// Sets the maximum number of parts to return.
    max_parts: ?i32 = null,

    /// Specifies the part after which listing should begin. Only parts with higher
    /// part numbers will be
    /// listed.
    part_number_marker: ?[]const u8 = null,

    request_payer: ?RequestPayer = null,

    /// The server-side encryption (SSE) algorithm used to encrypt the object. This
    /// parameter is needed only when the object was created
    /// using a checksum algorithm. For more information,
    /// see [Protecting data using SSE-C
    /// keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_algorithm: ?[]const u8 = null,

    /// The server-side encryption (SSE) customer managed key. This parameter is
    /// needed only when the object was created using a checksum algorithm.
    /// For more information, see
    /// [Protecting data using SSE-C
    /// keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key: ?[]const u8 = null,

    /// The MD5 server-side encryption (SSE) customer managed key. This parameter is
    /// needed only when the object was created using a checksum
    /// algorithm. For more information,
    /// see [Protecting data using SSE-C
    /// keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/ServerSideEncryptionCustomerKeys.html) in the
    /// *Amazon S3 User Guide*.
    ///
    /// This functionality is not supported for directory buckets.
    sse_customer_key_md5: ?[]const u8 = null,

    /// Upload ID identifying the multipart upload whose parts are being listed.
    upload_id: []const u8,
};

pub const ListPartsOutput = struct {
    /// If the bucket has a lifecycle rule configured with an action to abort
    /// incomplete multipart uploads
    /// and the prefix in the lifecycle rule matches the object name in the request,
    /// then the response includes
    /// this header indicating when the initiated multipart upload will become
    /// eligible for abort operation. For
    /// more information, see [Aborting
    /// Incomplete Multipart Uploads Using a Bucket Lifecycle
    /// Configuration](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html#mpu-abort-incomplete-mpu-lifecycle-config).
    ///
    /// The response will also include the `x-amz-abort-rule-id` header that will
    /// provide the ID
    /// of the lifecycle configuration rule that defines this action.
    ///
    /// This functionality is not supported for directory buckets.
    abort_date: ?i64 = null,

    /// This header is returned along with the `x-amz-abort-date` header. It
    /// identifies
    /// applicable lifecycle configuration rule that defines the action to abort
    /// incomplete multipart
    /// uploads.
    ///
    /// This functionality is not supported for directory buckets.
    abort_rule_id: ?[]const u8 = null,

    /// The name of the bucket to which the multipart upload was initiated. Does not
    /// return the access point ARN or
    /// access point alias if used.
    bucket: ?[]const u8 = null,

    /// The algorithm that was used to create a checksum of the object.
    checksum_algorithm: ?ChecksumAlgorithm = null,

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

    /// Container element that identifies who initiated the multipart upload. If the
    /// initiator is an
    /// Amazon Web Services account, this element provides the same information as
    /// the `Owner` element. If the
    /// initiator is an IAM User, this element provides the user ARN.
    initiator: ?Initiator = null,

    /// Indicates whether the returned list of parts is truncated. A true value
    /// indicates that the list was
    /// truncated. A list can be truncated if the number of parts exceeds the limit
    /// returned in the MaxParts
    /// element.
    is_truncated: ?bool = null,

    /// Object key for which the multipart upload was initiated.
    key: ?[]const u8 = null,

    /// Maximum number of parts that were allowed in the response.
    max_parts: ?i32 = null,

    /// When a list is truncated, this element specifies the last part in the list,
    /// as well as the value to
    /// use for the `part-number-marker` request parameter in a subsequent request.
    next_part_number_marker: ?[]const u8 = null,

    /// Container element that identifies the object owner, after the object is
    /// created. If multipart upload
    /// is initiated by an IAM user, this element provides the parent account ID.
    ///
    /// **Directory buckets** - The bucket owner is returned as the
    /// object owner for all the parts.
    owner: ?Owner = null,

    /// Specifies the part after which listing should begin. Only parts with higher
    /// part numbers will be
    /// listed.
    part_number_marker: ?[]const u8 = null,

    /// Container for elements related to a particular part. A response can contain
    /// zero or more
    /// `Part` elements.
    parts: ?[]const Part = null,

    request_charged: ?RequestCharged = null,

    /// The class of storage used to store the uploaded object.
    ///
    /// **Directory buckets** -
    /// Directory buckets only support `EXPRESS_ONEZONE` (the S3 Express One Zone
    /// storage class) in Availability Zones and `ONEZONE_IA` (the S3 One
    /// Zone-Infrequent Access storage class) in Dedicated Local Zones.
    storage_class: ?StorageClass = null,

    /// Upload ID identifying the multipart upload whose parts are being listed.
    upload_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPartsInput, options: CallOptions) !ListPartsOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListPartsInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(allocator, "x-id=ListParts");
    query_has_prev = true;
    if (input.max_parts) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max-parts=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.part_number_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "part-number-marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "uploadId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.upload_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPartsOutput {
    var result: ListPartsOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var parts_list: std.ArrayList(Part) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumAlgorithm")) {
                    result.checksum_algorithm = ChecksumAlgorithm.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChecksumType")) {
                    result.checksum_type = ChecksumType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Initiator")) {
                    result.initiator = try serde.deserializeInitiator(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxParts")) {
                    result.max_parts = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NextPartNumberMarker")) {
                    result.next_part_number_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try serde.deserializeOwner(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "PartNumberMarker")) {
                    result.part_number_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Part")) {
                    try parts_list.append(allocator, try serde.deserializePart(allocator, &reader));
                } else if (std.mem.eql(u8, e.local, "StorageClass")) {
                    result.storage_class = StorageClass.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UploadId")) {
                    result.upload_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    result.parts = if (parts_list.items.len > 0) try parts_list.toOwnedSlice(allocator) else null;
    if (headers.get("x-amz-abort-date")) |value| {
        result.abort_date = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (headers.get("x-amz-abort-rule-id")) |value| {
        result.abort_rule_id = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = RequestCharged.fromWireName(value);
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
