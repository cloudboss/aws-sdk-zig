const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const RequestCharged = @import("request_charged.zig").RequestCharged;

pub const DeleteObjectAnnotationInput = struct {
    /// The name of the annotation to delete. Annotation names are UTF-8 encoded and
    /// cannot start with
    /// `aws` or `s3` (case-insensitive).
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 512 bytes.
    annotation_name: []const u8,

    /// The name of the bucket that contains the object.
    bucket: []const u8,

    /// The account ID of the expected bucket owner.
    expected_bucket_owner: ?[]const u8 = null,

    /// The object key.
    key: []const u8,

    /// If specified, the operation only succeeds if the object's ETag matches the
    /// provided value.
    object_if_match: ?[]const u8 = null,

    request_payer: ?RequestPayer = null,

    /// The version ID of the object.
    version_id: ?[]const u8 = null,
};

pub const DeleteObjectAnnotationOutput = struct {
    /// The version ID of the object that the annotation was deleted from.
    object_version_id: ?[]const u8 = null,

    request_charged: ?RequestCharged = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteObjectAnnotationInput, options: CallOptions) !DeleteObjectAnnotationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteObjectAnnotationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.key);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "annotation");
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "annotationName=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.annotation_name);
    query_has_prev = true;
    if (input.version_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "versionId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
    }
    if (input.object_if_match) |v| {
        try request.headers.put(allocator, "x-amz-object-if-match", v);
    }
    if (input.request_payer) |v| {
        try request.headers.put(allocator, "x-amz-request-payer", v.wireName());
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteObjectAnnotationOutput {
    var result: DeleteObjectAnnotationOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("x-amz-object-version-id")) |value| {
        result.object_version_id = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = RequestCharged.fromWireName(value);
    }

    return result;
}
