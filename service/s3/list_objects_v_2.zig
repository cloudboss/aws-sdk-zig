const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EncodingType = @import("encoding_type.zig").EncodingType;
const OptionalObjectAttributes = @import("optional_object_attributes.zig").OptionalObjectAttributes;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const CommonPrefix = @import("common_prefix.zig").CommonPrefix;
const Object = @import("object.zig").Object;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const serde = @import("serde.zig");

/// Returns some or all (up to 1,000) of the objects in a bucket with each
/// request. You can use the
/// request parameters as selection criteria to return a subset of the objects
/// in a bucket. A `200
/// OK` response can contain valid or invalid XML. Make sure to design your
/// application to parse the
/// contents of the response and handle it appropriately. For more information
/// about listing objects, see
/// [Listing object
/// keys
/// programmatically](https://docs.aws.amazon.com/AmazonS3/latest/userguide/ListingKeysUsingAPIs.html) in the *Amazon S3 User Guide*. To get a list of your
/// buckets, see
/// [ListBuckets](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListBuckets.html).
///
/// **Note:**
///
/// * **General purpose bucket** - For general purpose buckets,
/// `ListObjectsV2` doesn't return prefixes that are related only to in-progress
/// multipart uploads.
///
/// * **Directory buckets** - For directory buckets,
/// `ListObjectsV2` response includes the prefixes that are related only to
/// in-progress
/// multipart uploads.
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
/// **Permissions**
///
/// * **General purpose bucket permissions** - To use this
/// operation, you must have READ access to the bucket. You must have permission
/// to perform the
/// `s3:ListBucket` action. The bucket owner has this permission by default and
/// can
/// grant this permission to others. For more information about permissions, see
/// [Permissions Related to Bucket Subresource
/// Operations](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-with-s3-actions.html#using-with-s3-actions-related-to-bucket-subresources) and [Managing Access
/// Permissions to Your Amazon S3
/// Resources](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-access-control.html) in the
/// *Amazon S3 User Guide*.
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
/// **Sorting order of returned objects**
///
/// * **General purpose bucket** - For general purpose buckets,
/// `ListObjectsV2` returns objects in lexicographical order based on their key
/// names.
///
/// * **Directory bucket** - For directory buckets,
/// `ListObjectsV2` does not return objects in lexicographical order.
///
/// **HTTP Host header syntax**
///
/// **Directory buckets ** - The HTTP Host header syntax is `
/// *Bucket-name*.s3express-*zone-id*.*region-code*.amazonaws.com`.
///
/// **Important:**
///
/// This section describes the latest revision of this action. We recommend that
/// you use this revised
/// API operation for application development. For backward compatibility,
/// Amazon S3 continues to support the
/// prior version of this API operation,
/// [ListObjects](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjects.html).
///
/// The following operations are related to `ListObjectsV2`:
///
/// *
///   [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html)
///
/// *
///   [PutObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html)
///
/// *
///   [CreateBucket](https://docs.aws.amazon.com/AmazonS3/latest/API/API_CreateBucket.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const ListObjectsV2Input = struct {
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

    /// `ContinuationToken` indicates to Amazon S3 that the list is being continued
    /// on this bucket
    /// with a token. `ContinuationToken` is obfuscated and is not a real key. You
    /// can use this
    /// `ContinuationToken` for pagination of the list results.
    continuation_token: ?[]const u8 = null,

    /// A delimiter is a character that you use to group keys.
    ///
    /// `CommonPrefixes` is filtered out from results if it is not lexicographically
    /// greater than
    /// the `StartAfter` value.
    ///
    /// **Note:**
    ///
    /// * **Directory buckets** - For directory buckets, `/` is the only supported
    ///   delimiter.
    ///
    /// * **Directory buckets ** - When you query
    /// `ListObjectsV2` with a delimiter during in-progress multipart uploads, the
    /// `CommonPrefixes` response parameter contains the prefixes that are
    /// associated with
    /// the in-progress multipart uploads. For more information about multipart
    /// uploads, see [Multipart Upload
    /// Overview](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html)
    /// in the *Amazon S3 User Guide*.
    delimiter: ?[]const u8 = null,

    /// Encoding type used by Amazon S3 to encode the [object
    /// keys](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html) in the response. Responses are
    /// encoded only in UTF-8. An object key can contain any Unicode character.
    /// However, the XML 1.0 parser
    /// can't parse certain characters, such as characters with an ASCII value from
    /// 0 to 10. For characters that
    /// aren't supported in XML 1.0, you can add this parameter to request that
    /// Amazon S3 encode the keys in the
    /// response. For more information about characters to avoid in object key
    /// names, see [Object key
    /// naming
    /// guidelines](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-guidelines).
    ///
    /// **Note:**
    ///
    /// When using the URL encoding type, non-ASCII characters that are used in an
    /// object's key name will
    /// be percent-encoded according to UTF-8 code values. For example, the object
    /// `test_file(3).png` will appear as `test_file%283%29.png`.
    encoding_type: ?EncodingType = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// The owner field is not present in `ListObjectsV2` by default. If you want to
    /// return the
    /// owner field with each key in the result, then set the `FetchOwner` field to
    /// `true`.
    ///
    /// **Note:**
    ///
    /// **Directory buckets** - For directory buckets, the bucket
    /// owner is returned as the object owner for all objects.
    fetch_owner: ?bool = null,

    /// Sets the maximum number of keys returned in the response. By default, the
    /// action returns up to 1,000
    /// key names. The response might contain fewer keys but will never contain
    /// more.
    max_keys: ?i32 = null,

    /// Specifies the optional fields that you want returned in the response. Fields
    /// that you do not specify
    /// are not returned.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    optional_object_attributes: ?[]const OptionalObjectAttributes = null,

    /// Limits the response to keys that begin with the specified prefix.
    ///
    /// **Note:**
    ///
    /// **Directory buckets** - For directory buckets, only prefixes that end in a
    /// delimiter (`/`) are supported.
    prefix: ?[]const u8 = null,

    /// Confirms that the requester knows that she or he will be charged for the
    /// list objects request in V2
    /// style. Bucket owners need not specify this parameter in their requests.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    request_payer: ?RequestPayer = null,

    /// StartAfter is where you want Amazon S3 to start listing from. Amazon S3
    /// starts listing after this specified
    /// key. StartAfter can be any key in the bucket.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    start_after: ?[]const u8 = null,
};

pub const ListObjectsV2Output = struct {
    /// All of the keys (up to 1,000) that share the same prefix are grouped
    /// together. When counting the
    /// total numbers of returns by this API operation, this group of keys is
    /// considered as one item.
    ///
    /// A response can contain `CommonPrefixes` only if you specify a delimiter.
    ///
    /// `CommonPrefixes` contains all (if there are any) keys between `Prefix` and
    /// the
    /// next occurrence of the string specified by a delimiter.
    ///
    /// `CommonPrefixes` lists keys that act like subdirectories in the directory
    /// specified by
    /// `Prefix`.
    ///
    /// For example, if the prefix is `notes/` and the delimiter is a slash (`/`) as
    /// in `notes/summer/july`, the common prefix is `notes/summer/`. All of the
    /// keys that
    /// roll up into a common prefix count as a single return when calculating the
    /// number of returns.
    ///
    /// **Note:**
    ///
    /// * **Directory buckets** - For directory buckets, only prefixes that end in a
    ///   delimiter (`/`) are supported.
    ///
    /// * **Directory buckets ** - When you query
    /// `ListObjectsV2` with a delimiter during in-progress multipart uploads, the
    /// `CommonPrefixes` response parameter contains the prefixes that are
    /// associated with
    /// the in-progress multipart uploads. For more information about multipart
    /// uploads, see [Multipart Upload
    /// Overview](https://docs.aws.amazon.com/AmazonS3/latest/dev/mpuoverview.html)
    /// in the *Amazon S3 User Guide*.
    common_prefixes: ?[]const CommonPrefix = null,

    /// Metadata about each object returned.
    contents: ?[]const Object = null,

    /// If `ContinuationToken` was sent with the request, it is included in the
    /// response. You
    /// can use the returned `ContinuationToken` for pagination of the list
    /// response.
    continuation_token: ?[]const u8 = null,

    /// Causes keys that contain the same string between the `prefix` and the first
    /// occurrence of
    /// the delimiter to be rolled up into a single result element in the
    /// `CommonPrefixes`
    /// collection. These rolled-up keys are not returned elsewhere in the response.
    /// Each rolled-up result
    /// counts as only one return against the `MaxKeys` value.
    ///
    /// **Note:**
    ///
    /// **Directory buckets** - For directory buckets, `/` is the only supported
    /// delimiter.
    delimiter: ?[]const u8 = null,

    /// Encoding type used by Amazon S3 to encode object key names in the XML
    /// response.
    ///
    /// If you specify the `encoding-type` request parameter, Amazon S3 includes
    /// this element in the
    /// response, and returns encoded key name values in the following response
    /// elements:
    ///
    /// `Delimiter, Prefix, Key,` and `StartAfter`.
    encoding_type: ?EncodingType = null,

    /// Set to `false` if all of the results were returned. Set to `true` if more
    /// keys
    /// are available to return. If the number of results exceeds that specified by
    /// `MaxKeys`, all of
    /// the results might not be returned.
    is_truncated: ?bool = null,

    /// `KeyCount` is the number of keys returned with this request. `KeyCount` will
    /// always be less than or equal to the `MaxKeys` field. For example, if you ask
    /// for 50 keys,
    /// your result will include 50 keys or fewer.
    key_count: ?i32 = null,

    /// Sets the maximum number of keys returned in the response. By default, the
    /// action returns up to 1,000
    /// key names. The response might contain fewer keys but will never contain
    /// more.
    max_keys: ?i32 = null,

    /// The bucket name.
    name: ?[]const u8 = null,

    /// `NextContinuationToken` is sent when `isTruncated` is true, which means
    /// there
    /// are more keys in the bucket that can be listed. The next list requests to
    /// Amazon S3 can be continued with
    /// this `NextContinuationToken`. `NextContinuationToken` is obfuscated and is
    /// not a
    /// real key
    next_continuation_token: ?[]const u8 = null,

    /// Keys that begin with the indicated prefix.
    ///
    /// **Note:**
    ///
    /// **Directory buckets** - For directory buckets, only prefixes that end in a
    /// delimiter (`/`) are supported.
    prefix: ?[]const u8 = null,

    request_charged: ?RequestCharged = null,

    /// If StartAfter was sent with the request, it is included in the response.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    start_after: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ListObjectsV2Output) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ListObjectsV2Input, options: Options) !ListObjectsV2Output {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ListObjectsV2Input, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(alloc, "list-type=2");
    query_has_prev = true;
    if (input.continuation_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "continuation-token=");
        try aws.url.appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
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
    if (input.fetch_owner) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "fetch-owner=");
        try query_buf.appendSlice(alloc, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.max_keys) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "max-keys=");
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
    if (input.start_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "start-after=");
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
    if (input.optional_object_attributes) |v| {
        {
            var header_buf: std.ArrayList(u8) = .{};
            for (v) |item| {
                if (header_buf.items.len > 0) try header_buf.appendSlice(alloc, ", ");
                try header_buf.appendSlice(alloc, @tagName(item));
            }
            try request.headers.put(alloc, "x-amz-optional-object-attributes", header_buf.items);
        }
    }
    if (input.request_payer) |v| {
        try request.headers.put(alloc, "x-amz-request-payer", @tagName(v));
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListObjectsV2Output {
    var result: ListObjectsV2Output = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var common_prefixes_list: std.ArrayList(CommonPrefix) = .{};
    var contents_list: std.ArrayList(Object) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CommonPrefixes")) {
                    try common_prefixes_list.append(alloc, try serde.deserializeCommonPrefix(&reader, alloc));
                } else if (std.mem.eql(u8, e.local, "Contents")) {
                    try contents_list.append(alloc, try serde.deserializeObject(&reader, alloc));
                } else if (std.mem.eql(u8, e.local, "ContinuationToken")) {
                    result.continuation_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Delimiter")) {
                    result.delimiter = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncodingType")) {
                    result.encoding_type = std.meta.stringToEnum(EncodingType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KeyCount")) {
                    result.key_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxKeys")) {
                    result.max_keys = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NextContinuationToken")) {
                    result.next_continuation_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartAfter")) {
                    result.start_after = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    result.common_prefixes = if (common_prefixes_list.items.len > 0) try common_prefixes_list.toOwnedSlice(alloc) else null;
    result.contents = if (contents_list.items.len > 0) try contents_list.toOwnedSlice(alloc) else null;
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
