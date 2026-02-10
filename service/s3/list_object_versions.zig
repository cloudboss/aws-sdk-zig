const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EncodingType = @import("encoding_type.zig").EncodingType;
const OptionalObjectAttributes = @import("optional_object_attributes.zig").OptionalObjectAttributes;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const CommonPrefix = @import("common_prefix.zig").CommonPrefix;
const DeleteMarkerEntry = @import("delete_marker_entry.zig").DeleteMarkerEntry;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const ObjectVersion = @import("object_version.zig").ObjectVersion;

/// **Note:**
///
/// This operation is not supported for directory buckets.
///
/// Returns metadata about all versions of the objects in a bucket. You can also
/// use request parameters
/// as selection criteria to return metadata about a subset of all the object
/// versions.
///
/// **Important:**
///
/// To use this operation, you must have permission to perform the
/// `s3:ListBucketVersions`
/// action. Be aware of the name difference.
///
/// **Note:**
///
/// A `200 OK` response can contain valid or invalid XML. Make sure to design
/// your
/// application to parse the contents of the response and handle it
/// appropriately.
///
/// To use this operation, you must have READ access to the bucket.
///
/// The following operations are related to `ListObjectVersions`:
///
/// *
///   [ListObjectsV2](https://docs.aws.amazon.com/AmazonS3/latest/API/API_ListObjectsV2.html)
///
/// *
///   [GetObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_GetObject.html)
///
/// *
///   [PutObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_PutObject.html)
///
/// *
///   [DeleteObject](https://docs.aws.amazon.com/AmazonS3/latest/API/API_DeleteObject.html)
///
/// **Important:**
///
/// You must URL encode any signed header values that contain spaces. For
/// example, if your header value is `my file.txt`, containing two spaces after
/// `my`, you must URL encode this value to `my%20%20file.txt`.
pub const ListObjectVersionsInput = struct {
    /// The bucket name that contains the objects.
    bucket: []const u8,

    /// A delimiter is a character that you specify to group keys. All keys that
    /// contain the same string
    /// between the `prefix` and the first occurrence of the delimiter are grouped
    /// under a single
    /// result element in `CommonPrefixes`. These groups are counted as one result
    /// against the
    /// `max-keys` limitation. These keys are not returned elsewhere in the
    /// response.
    ///
    /// `CommonPrefixes` is filtered out from results if it is not lexicographically
    /// greater than
    /// the key-marker.
    delimiter: ?[]const u8 = null,

    encoding_type: ?EncodingType = null,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,

    /// Specifies the key to start with when listing objects in a bucket.
    key_marker: ?[]const u8 = null,

    /// Sets the maximum number of keys returned in the response. By default, the
    /// action returns up to 1,000
    /// key names. The response might contain fewer keys but will never contain
    /// more. If additional keys satisfy
    /// the search criteria, but were not returned because `max-keys` was exceeded,
    /// the response
    /// contains `true`. To return the additional keys, see
    /// `key-marker` and `version-id-marker`.
    max_keys: ?i32 = null,

    /// Specifies the optional fields that you want returned in the response. Fields
    /// that you do not specify
    /// are not returned.
    optional_object_attributes: ?[]const OptionalObjectAttributes = null,

    /// Use this parameter to select only those keys that begin with the specified
    /// prefix. You can use
    /// prefixes to separate a bucket into different groupings of keys. (You can
    /// think of using
    /// `prefix` to make groups in the same way that you'd use a folder in a file
    /// system.) You can
    /// use `prefix` with `delimiter` to roll up numerous objects into a single
    /// result
    /// under `CommonPrefixes`.
    prefix: ?[]const u8 = null,

    request_payer: ?RequestPayer = null,

    /// Specifies the object version you want to start listing from.
    version_id_marker: ?[]const u8 = null,
};

pub const ListObjectVersionsOutput = struct {
    /// All of the keys rolled up into a common prefix count as a single return when
    /// calculating the number
    /// of returns.
    common_prefixes: ?[]const CommonPrefix = null,

    /// Container for an object that is a delete marker. To learn more about delete
    /// markers, see [Working with delete
    /// markers](https://docs.aws.amazon.com/AmazonS3/latest/userguide/DeleteMarker.html).
    delete_markers: ?[]const DeleteMarkerEntry = null,

    /// The delimiter grouping the included keys. A delimiter is a character that
    /// you specify to group keys.
    /// All keys that contain the same string between the prefix and the first
    /// occurrence of the delimiter are
    /// grouped under a single result element in `CommonPrefixes`. These groups are
    /// counted as one
    /// result against the `max-keys` limitation. These keys are not returned
    /// elsewhere in the
    /// response.
    delimiter: ?[]const u8 = null,

    /// Encoding type used by Amazon S3 to encode object key names in the XML
    /// response.
    ///
    /// If you specify the `encoding-type` request parameter, Amazon S3 includes
    /// this element in the
    /// response, and returns encoded key name values in the following response
    /// elements:
    ///
    /// `KeyMarker, NextKeyMarker, Prefix, Key`, and `Delimiter`.
    encoding_type: ?EncodingType = null,

    /// A flag that indicates whether Amazon S3 returned all of the results that
    /// satisfied the search criteria.
    /// If your results were truncated, you can make a follow-up paginated request
    /// by using the
    /// `NextKeyMarker` and `NextVersionIdMarker` response parameters as a starting
    /// place in another request to return the rest of the results.
    is_truncated: ?bool = null,

    /// Marks the last key returned in a truncated response.
    key_marker: ?[]const u8 = null,

    /// Specifies the maximum number of objects to return.
    max_keys: ?i32 = null,

    /// The bucket name.
    name: ?[]const u8 = null,

    /// When the number of responses exceeds the value of `MaxKeys`, `NextKeyMarker`
    /// specifies the first key not returned that satisfies the search criteria. Use
    /// this value for the
    /// key-marker request parameter in a subsequent request.
    next_key_marker: ?[]const u8 = null,

    /// When the number of responses exceeds the value of `MaxKeys`,
    /// `NextVersionIdMarker` specifies the first object version not returned that
    /// satisfies the
    /// search criteria. Use this value for the `version-id-marker` request
    /// parameter in a subsequent
    /// request.
    next_version_id_marker: ?[]const u8 = null,

    /// Selects objects that start with the value supplied by this parameter.
    prefix: ?[]const u8 = null,

    request_charged: ?RequestCharged = null,

    /// Marks the last version of the key returned in a truncated response.
    version_id_marker: ?[]const u8 = null,

    /// Container for version information.
    versions: ?[]const ObjectVersion = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ListObjectVersionsOutput) void {
        if (self.delimiter) |v| {
            self.allocator.free(v);
        }
        if (self.key_marker) |v| {
            self.allocator.free(v);
        }
        if (self.name) |v| {
            self.allocator.free(v);
        }
        if (self.next_key_marker) |v| {
            self.allocator.free(v);
        }
        if (self.next_version_id_marker) |v| {
            self.allocator.free(v);
        }
        if (self.prefix) |v| {
            self.allocator.free(v);
        }
        if (self.version_id_marker) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ListObjectVersionsInput, options: Options) !ListObjectVersionsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ListObjectVersionsInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(alloc, "versions");
    query_has_prev = true;
    if (input.delimiter) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "delimiter=");
        try appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.encoding_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "encoding-type=");
        try appendUrlEncoded(alloc, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (input.key_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "key-marker=");
        try appendUrlEncoded(alloc, &query_buf, v);
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
        try appendUrlEncoded(alloc, &query_buf, v);
        query_has_prev = true;
    }
    if (input.version_id_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "version-id-marker=");
        try appendUrlEncoded(alloc, &query_buf, v);
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
        try request.headers.put(alloc, "x-amz-optional-object-attributes", v);
    }
    if (input.request_payer) |v| {
        try request.headers.put(alloc, "x-amz-request-payer", @tagName(v));
    }

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ListObjectVersionsOutput {
    var result: ListObjectVersionsOutput = .{ .allocator = alloc };
    _ = status;
    if (findElement(body, "Delimiter")) |content| {
        result.delimiter = try alloc.dupe(u8, content);
    }
    if (findElement(body, "IsTruncated")) |content| {
        result.is_truncated = std.mem.eql(u8, content, "true");
    }
    if (findElement(body, "KeyMarker")) |content| {
        result.key_marker = try alloc.dupe(u8, content);
    }
    if (findElement(body, "MaxKeys")) |content| {
        result.max_keys = std.fmt.parseInt(i32, content, 10) catch null;
    }
    if (findElement(body, "Name")) |content| {
        result.name = try alloc.dupe(u8, content);
    }
    if (findElement(body, "NextKeyMarker")) |content| {
        result.next_key_marker = try alloc.dupe(u8, content);
    }
    if (findElement(body, "NextVersionIdMarker")) |content| {
        result.next_version_id_marker = try alloc.dupe(u8, content);
    }
    if (findElement(body, "Prefix")) |content| {
        result.prefix = try alloc.dupe(u8, content);
    }
    if (findElement(body, "VersionIdMarker")) |content| {
        result.version_id_marker = try alloc.dupe(u8, content);
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
