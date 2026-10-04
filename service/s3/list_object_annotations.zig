const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RequestPayer = @import("request_payer.zig").RequestPayer;
const AnnotationEntry = @import("annotation_entry.zig").AnnotationEntry;
const RequestCharged = @import("request_charged.zig").RequestCharged;
const serde = @import("serde.zig");

pub const ListObjectAnnotationsInput = struct {
    /// Filter results to annotations whose name begins with the specified prefix.
    annotation_prefix: ?[]const u8 = null,

    /// The name of the bucket that contains the object.
    bucket: []const u8,

    /// Continuation token returned by a previous request to retrieve the next page.
    continuation_token: ?[]const u8 = null,

    /// The account ID of the expected bucket owner.
    expected_bucket_owner: ?[]const u8 = null,

    /// The object key.
    key: []const u8,

    /// The maximum number of annotations to return in the response. Maximum is
    /// 1,000.
    max_annotation_results: ?i32 = null,

    request_payer: ?RequestPayer = null,

    /// The version ID of the object.
    version_id: ?[]const u8 = null,
};

pub const ListObjectAnnotationsOutput = struct {
    /// The number of annotations returned.
    annotation_count: ?i32 = null,

    /// The prefix used to filter the response.
    annotation_prefix: ?[]const u8 = null,

    /// The list of annotations attached to the object.
    annotations: ?[]const AnnotationEntry = null,

    /// The bucket name.
    bucket: ?[]const u8 = null,

    /// The continuation token used in this request.
    continuation_token: ?[]const u8 = null,

    /// The object key.
    key: ?[]const u8 = null,

    /// The maximum number of annotations returned in the response.
    max_annotation_results: ?i32 = null,

    /// The continuation token to use to retrieve the next page of results.
    next_continuation_token: ?[]const u8 = null,

    /// The version ID of the object.
    object_version_id: ?[]const u8 = null,

    request_charged: ?RequestCharged = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListObjectAnnotationsInput, options: CallOptions) !ListObjectAnnotationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListObjectAnnotationsInput, config: *aws.Config) !aws.http.Request {
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
    try query_buf.appendSlice(allocator, "annotation&x-id=ListObjectAnnotations");
    query_has_prev = true;
    if (input.annotation_prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "annotation-prefix=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.continuation_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "continuation-token=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_annotation_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max-annotation-results=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.version_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "versionId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListObjectAnnotationsOutput {
    var result: ListObjectAnnotationsOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnnotationCount")) {
                    result.annotation_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AnnotationPrefix")) {
                    result.annotation_prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Annotations")) {
                    result.annotations = try serde.deserializeAnnotationList(allocator, &reader, "AnnotationEntry");
                } else if (std.mem.eql(u8, e.local, "Bucket")) {
                    result.bucket = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ContinuationToken")) {
                    result.continuation_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxAnnotationResults")) {
                    result.max_annotation_results = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "NextContinuationToken")) {
                    result.next_continuation_token = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("x-amz-object-version-id")) |value| {
        result.object_version_id = try allocator.dupe(u8, value);
    }
    if (headers.get("x-amz-request-charged")) |value| {
        result.request_charged = RequestCharged.fromWireName(value);
    }

    return result;
}
