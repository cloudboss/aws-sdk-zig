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
const serde = @import("serde.zig");

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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ListObjectVersionsOutput) void {
        self._arena.deinit();
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ListObjectVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

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
    if (input.version_id_marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(alloc, "&");
        try query_buf.appendSlice(alloc, "version-id-marker=");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListObjectVersionsOutput {
    var result: ListObjectVersionsOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var common_prefixes_list: std.ArrayList(CommonPrefix) = .{};
    var delete_markers_list: std.ArrayList(DeleteMarkerEntry) = .{};
    var versions_list: std.ArrayList(ObjectVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CommonPrefixes")) {
                    try common_prefixes_list.append(alloc, try serde.deserializeCommonPrefix(&reader, alloc));
                } else if (std.mem.eql(u8, e.local, "DeleteMarker")) {
                    try delete_markers_list.append(alloc, try serde.deserializeDeleteMarkerEntry(&reader, alloc));
                } else if (std.mem.eql(u8, e.local, "Delimiter")) {
                    result.delimiter = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EncodingType")) {
                    result.encoding_type = std.meta.stringToEnum(EncodingType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsTruncated")) {
                    result.is_truncated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "KeyMarker")) {
                    result.key_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxKeys")) {
                    result.max_keys = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NextKeyMarker")) {
                    result.next_key_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NextVersionIdMarker")) {
                    result.next_version_id_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionIdMarker")) {
                    result.version_id_marker = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Version")) {
                    try versions_list.append(alloc, try serde.deserializeObjectVersion(&reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    result.common_prefixes = if (common_prefixes_list.items.len > 0) try common_prefixes_list.toOwnedSlice(alloc) else null;
    result.delete_markers = if (delete_markers_list.items.len > 0) try delete_markers_list.toOwnedSlice(alloc) else null;
    result.versions = if (versions_list.items.len > 0) try versions_list.toOwnedSlice(alloc) else null;
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = std.meta.stringToEnum(RequestCharged, value);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
