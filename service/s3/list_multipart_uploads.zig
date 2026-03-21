const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EncodingType = @import("encoding_type.zig").EncodingType;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const CommonPrefix = @import("common_prefix.zig").CommonPrefix;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const MultipartUpload = @import("multipart_upload.zig").MultipartUpload;
const serde = @import("serde.zig");

pub const ListMultipartUploadsInput = struct {
    /// The name of the bucket to which the multipart upload was initiated.
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

    /// Character you use to group keys.
    ///
    /// All keys that contain the same string between the prefix, if specified, and
    /// the first occurrence of
    /// the delimiter after the prefix are grouped under a single result element,
    /// `CommonPrefixes`.
    /// If you don't specify the prefix parameter, then the substring starts at the
    /// beginning of the key. The
    /// keys that are grouped under `CommonPrefixes` result element are not returned
    /// elsewhere in the
    /// response.
    ///
    /// `CommonPrefixes` is filtered out from results if it is not lexicographically
    /// greater than
    /// the key-marker.
    ///
    /// **Directory buckets** - For directory buckets, `/` is the only supported
    /// delimiter.
    delimiter: ?[]const u8 = null,

    encoding_type: ?EncodingType = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// Specifies the multipart upload after which listing should begin.
    ///
    /// * **General purpose buckets** - For general purpose buckets,
    /// `key-marker` is an object key. Together with `upload-id-marker`, this
    /// parameter specifies the multipart upload after which listing should begin.
    ///
    /// If `upload-id-marker` is not specified, only the keys lexicographically
    /// greater
    /// than the specified `key-marker` will be included in the list.
    ///
    /// If `upload-id-marker` is specified, any multipart uploads for a key equal to
    /// the
    /// `key-marker` might also be included, provided those multipart uploads have
    /// upload IDs
    /// lexicographically greater than the specified `upload-id-marker`.
    ///
    /// * **Directory buckets** - For directory buckets,
    /// `key-marker` is obfuscated and isn't a real object key. The
    /// `upload-id-marker` parameter isn't supported by directory buckets. To list
    /// the
    /// additional multipart uploads, you only need to set the value of `key-marker`
    /// to the
    /// `NextKeyMarker` value from the previous response.
    ///
    /// In the `ListMultipartUploads` response, the multipart uploads aren't sorted
    /// lexicographically based on the object keys.
    key_marker: ?[]const u8 = null,

    /// Sets the maximum number of multipart uploads, from 1 to 1,000, to return in
    /// the response body. 1,000
    /// is the maximum number of uploads that can be returned in a response.
    max_uploads: ?i32 = null,

    /// Lists in-progress uploads only for those keys that begin with the specified
    /// prefix. You can use
    /// prefixes to separate a bucket into different grouping of keys. (You can
    /// think of using
    /// `prefix` to make groups in the same way that you'd use a folder in a file
    /// system.)
    ///
    /// **Directory buckets** - For directory buckets, only prefixes that end in a
    /// delimiter (`/`) are supported.
    prefix: ?[]const u8 = null,

    request_payer: ?RequestPayer = null,

    /// Together with key-marker, specifies the multipart upload after which listing
    /// should begin. If
    /// key-marker is not specified, the upload-id-marker parameter is ignored.
    /// Otherwise, any multipart uploads
    /// for a key equal to the key-marker might be included in the list only if they
    /// have an upload ID
    /// lexicographically greater than the specified `upload-id-marker`.
    ///
    /// This functionality is not supported for directory buckets.
    upload_id_marker: ?[]const u8 = null,
};

pub const ListMultipartUploadsOutput = struct {
    /// The name of the bucket to which the multipart upload was initiated. Does not
    /// return the access point ARN or
    /// access point alias if used.
    bucket: ?[]const u8 = null,

    /// If you specify a delimiter in the request, then the result returns each
    /// distinct key prefix
    /// containing the delimiter in a `CommonPrefixes` element. The distinct key
    /// prefixes are
    /// returned in the `Prefix` child element.
    ///
    /// **Directory buckets** - For directory buckets, only prefixes that end in a
    /// delimiter (`/`) are supported.
    common_prefixes: ?[]const CommonPrefix = null,

    /// Contains the delimiter you specified in the request. If you don't specify a
    /// delimiter in your
    /// request, this element is absent from the response.
    ///
    /// **Directory buckets** - For directory buckets, `/` is the only supported
    /// delimiter.
    delimiter: ?[]const u8 = null,

    /// Encoding type used by Amazon S3 to encode object keys in the response.
    ///
    /// If you specify the `encoding-type` request parameter, Amazon S3 includes
    /// this element in the
    /// response, and returns encoded key name values in the following response
    /// elements:
    ///
    /// `Delimiter`, `KeyMarker`, `Prefix`, `NextKeyMarker`,
    /// `Key`.
    encoding_type: ?EncodingType = null,

    /// Indicates whether the returned list of multipart uploads is truncated. A
    /// value of true indicates
    /// that the list was truncated. The list can be truncated if the number of
    /// multipart uploads exceeds the
    /// limit allowed or specified by max uploads.
    is_truncated: ?bool = null,

    /// The key at or after which the listing began.
    key_marker: ?[]const u8 = null,

    /// Maximum number of multipart uploads that could have been included in the
    /// response.
    max_uploads: ?i32 = null,

    /// When a list is truncated, this element specifies the value that should be
    /// used for the key-marker
    /// request parameter in a subsequent request.
    next_key_marker: ?[]const u8 = null,

    /// When a list is truncated, this element specifies the value that should be
    /// used for the
    /// `upload-id-marker` request parameter in a subsequent request.
    ///
    /// This functionality is not supported for directory buckets.
    next_upload_id_marker: ?[]const u8 = null,

    /// When a prefix is provided in the request, this field contains the specified
    /// prefix. The result
    /// contains only keys starting with the specified prefix.
    ///
    /// **Directory buckets** - For directory buckets, only prefixes that end in a
    /// delimiter (`/`) are supported.
    prefix: ?[]const u8 = null,

    request_charged: ?RequestCharged = null,

    /// Together with key-marker, specifies the multipart upload after which listing
    /// should begin. If
    /// key-marker is not specified, the upload-id-marker parameter is ignored.
    /// Otherwise, any multipart uploads
    /// for a key equal to the key-marker might be included in the list only if they
    /// have an upload ID
    /// lexicographically greater than the specified `upload-id-marker`.
    ///
    /// This functionality is not supported for directory buckets.
    upload_id_marker: ?[]const u8 = null,

    /// Container for elements related to a particular multipart upload. A response
    /// can contain zero or more
    /// `Upload` elements.
    uploads: ?[]const MultipartUpload = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMultipartUploadsInput, options: CallOptions) !ListMultipartUploadsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMultipartUploadsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "uploads");
    query_has_prev = true;
    if (input.delimiter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "delimiter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.encoding_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "encoding-type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.key_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "key-marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_uploads) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max-uploads=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "prefix=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.upload_id_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "upload-id-marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMultipartUploadsOutput {
    var result: ListMultipartUploadsOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var common_prefixes_list: std.ArrayList(CommonPrefix) = .{};
    var uploads_list: std.ArrayList(MultipartUpload) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CommonPrefixes")) {
                    try common_prefixes_list.append(allocator, try serde.deserializeCommonPrefix(allocator, &reader));
                } else if (std.mem.eql(u8, e.local, "Delimiter")) {
                    result.delimiter = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncodingType")) {
                    result.encoding_type = EncodingType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KeyMarker")) {
                    result.key_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxUploads")) {
                    result.max_uploads = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NextKeyMarker")) {
                    result.next_key_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NextUploadIdMarker")) {
                    result.next_upload_id_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UploadIdMarker")) {
                    result.upload_id_marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Upload")) {
                    try uploads_list.append(allocator, try serde.deserializeMultipartUpload(allocator, &reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    result.common_prefixes = if (common_prefixes_list.items.len > 0) try common_prefixes_list.toOwnedSlice(allocator) else null;
    result.uploads = if (uploads_list.items.len > 0) try uploads_list.toOwnedSlice(allocator) else null;
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
