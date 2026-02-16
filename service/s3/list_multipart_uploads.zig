const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EncodingType = @import("encoding_type.zig").EncodingType;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const CommonPrefix = @import("common_prefix.zig").CommonPrefix;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const MultipartUpload = @import("multipart_upload.zig").MultipartUpload;
const serde = @import("serde.zig");

/// This operation lists in-progress multipart uploads in a bucket. An
/// in-progress multipart upload is a
/// multipart upload that has been initiated by the `CreateMultipartUpload`
/// request, but has not
/// yet been completed or aborted.
///
/// **Note:**
///
/// **Directory buckets** - If multipart uploads in a
/// directory bucket are in progress, you can't delete the bucket until all the
/// in-progress multipart
/// uploads are aborted or completed. To delete these in-progress multipart
/// uploads, use the
/// `ListMultipartUploads` operation to list the in-progress multipart uploads
/// in the bucket
/// and use the `AbortMultipartUpload` operation to abort all the in-progress
/// multipart
/// uploads.
///
/// The `ListMultipartUploads` operation returns a maximum of 1,000 multipart
/// uploads in the
/// response. The limit of 1,000 multipart uploads is also the default value.
/// You can further limit the
/// number of uploads in a response by specifying the `max-uploads` request
/// parameter. If there
/// are more than 1,000 multipart uploads that satisfy your
/// `ListMultipartUploads` request, the
/// response returns an `IsTruncated` element with the value of `true`, a
/// `NextKeyMarker` element, and a `NextUploadIdMarker` element. To list the
/// remaining multipart uploads, you need to make subsequent
/// `ListMultipartUploads` requests. In
/// these requests, include two query parameters: `key-marker` and
/// `upload-id-marker`.
/// Set the value of `key-marker` to the `NextKeyMarker` value from the previous
/// response. Similarly, set the value of `upload-id-marker` to the
/// `NextUploadIdMarker` value from the previous response.
///
/// **Note:**
///
/// **Directory buckets** - The `upload-id-marker`
/// element and the `NextUploadIdMarker` element aren't supported by directory
/// buckets. To
/// list the additional multipart uploads, you only need to set the value of
/// `key-marker` to
/// the `NextKeyMarker` value from the previous response.
///
/// For more information about multipart uploads, see [Uploading Objects Using
/// Multipart
/// Upload](https://docs.aws.amazon.com/AmazonS3/latest/dev/uploadobjusingmpu.html) in
/// the *Amazon S3 User Guide*.
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
/// * **General purpose bucket permissions** - For information
/// about permissions required to use the multipart upload API, see [Multipart
/// Upload and
/// Permissions](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuAndPermissions.html) in
/// the *Amazon S3 User Guide*.
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
/// **Sorting of multipart uploads in response**
///
/// * **General purpose bucket** - In the
/// `ListMultipartUploads` response, the multipart uploads are sorted based on
/// two
/// criteria:
///
/// * Key-based sorting - Multipart uploads are initially sorted in ascending
///   order
/// based on their object keys.
///
/// * Time-based sorting - For uploads that share the same object key, they are
/// further sorted in ascending order based on the upload initiation time. Among
/// uploads with
/// the same key, the one that was initiated first will appear before the ones
/// that were
/// initiated later.
///
/// * **Directory bucket** - In the
/// `ListMultipartUploads` response, the multipart uploads aren't sorted
/// lexicographically based on the object keys.
///
/// **HTTP Host header syntax**
///
/// **Directory buckets ** - The HTTP Host header syntax is `
/// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`.
///
/// The following operations are related to `ListMultipartUploads`:
///
/// *
///   [CreateMultipartUpload](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateMultipartUpload.html)
///
/// *
///   [UploadPart](https://docs.aws.amazon.com/AmazonS3/latest/API/API_UploadPart.html)
///
/// *
///   [CompleteMultipartUpload](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CompleteMultipartUpload.html)
///
/// *
///   [ListParts](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListParts.html)
///
/// *
///   [AbortMultipartUpload](https://docs.aws.amazon.com/AmazonS3/latest/API/API_AbortMultipartUpload.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
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
    /// **Note:**
    ///
    /// **Directory buckets** - For directory buckets, only prefixes that end in a
    /// delimiter (`/`) are supported.
    common_prefixes: ?[]const CommonPrefix = null,

    /// Contains the delimiter you specified in the request. If you don't specify a
    /// delimiter in your
    /// request, this element is absent from the response.
    ///
    /// **Note:**
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
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    next_upload_id_marker: ?[]const u8 = null,

    /// When a prefix is provided in the request, this field contains the specified
    /// prefix. The result
    /// contains only keys starting with the specified prefix.
    ///
    /// **Note:**
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
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    upload_id_marker: ?[]const u8 = null,

    /// Container for elements related to a particular multipart upload. A response
    /// can contain zero or more
    /// `Upload` elements.
    uploads: ?[]const MultipartUpload = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ListMultipartUploadsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ListMultipartUploadsInput, options: Options) !ListMultipartUploadsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ListMultipartUploadsInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(alloc, "uploads");
    query_has_prev = true;
    if (input.delimiter) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "delimiter=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.encoding_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "encoding-type=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (input.key_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "key-marker=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_uploads) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "max-uploads=");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try query_buf.appendSlice(alloc, num_str);
        }
        query_has_prev = true;
    }
    if (input.prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "prefix=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.upload_id_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "upload-id-marker=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
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
    if (input.request_payer) |v| {
        try request.headers.put(alloc, "x-amz-request-payer", @tagName(v));
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListMultipartUploadsOutput {
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
                    result.bucket = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CommonPrefixes")) {
                    try common_prefixes_list.append(alloc, try serde.deserializeCommonPrefix(&reader, alloc));
                } else if (std.mem.eql(u8, e.local, "Delimiter")) {
                    result.delimiter = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncodingType")) {
                    result.encoding_type = std.meta.stringToEnum(EncodingType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KeyMarker")) {
                    result.key_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxUploads")) {
                    result.max_uploads = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NextKeyMarker")) {
                    result.next_key_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NextUploadIdMarker")) {
                    result.next_upload_id_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UploadIdMarker")) {
                    result.upload_id_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Upload")) {
                    try uploads_list.append(alloc, try serde.deserializeMultipartUpload(&reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    result.common_prefixes = if (common_prefixes_list.items.len > 0) try common_prefixes_list.toOwnedSlice(alloc) else null;
    result.uploads = if (uploads_list.items.len > 0) try uploads_list.toOwnedSlice(alloc) else null;
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = std.meta.stringToEnum(RequestCharged, value);
    }

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
