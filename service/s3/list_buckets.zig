const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Bucket = @import("bucket.zig").Bucket;
const Owner = @import("owner.zig").Owner;
const serde = @import("serde.zig");

pub const ListBucketsInput = struct {
    /// Limits the response to buckets that are located in the specified Amazon Web
    /// Services Region. The Amazon Web Services Region must
    /// be expressed according to the Amazon Web Services Region code, such as
    /// `us-west-2` for the US West (Oregon)
    /// Region. For a list of the valid values for all of the Amazon Web Services
    /// Regions, see [Regions and
    /// Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region).
    ///
    /// Requests made to a Regional endpoint that is different from the
    /// `bucket-region`
    /// parameter are not supported. For example, if you want to limit the response
    /// to your buckets in Region
    /// `us-west-2`, the request must be made to an endpoint in Region
    /// `us-west-2`.
    bucket_region: ?[]const u8 = null,

    /// `ContinuationToken` indicates to Amazon S3 that the list is being continued
    /// on this bucket
    /// with a token. `ContinuationToken` is obfuscated and is not a real key. You
    /// can use this
    /// `ContinuationToken` for pagination of the list results.
    ///
    /// Length Constraints: Minimum length of 0. Maximum length of 1024.
    ///
    /// Required: No.
    ///
    /// If you specify the `bucket-region`, `prefix`, or
    /// `continuation-token` query parameters without using `max-buckets` to set the
    /// maximum number of buckets returned in the response, Amazon S3 applies a
    /// default page size of 10,000 and
    /// provides a continuation token if there are more buckets.
    continuation_token: ?[]const u8 = null,

    /// Maximum number of buckets to be returned in response. When the number is
    /// more than the count of
    /// buckets that are owned by an Amazon Web Services account, return all the
    /// buckets in response.
    max_buckets: ?i32 = null,

    /// Limits the response to bucket names that begin with the specified bucket
    /// name prefix.
    prefix: ?[]const u8 = null,
};

pub const ListBucketsOutput = struct {
    /// The list of buckets owned by the requester.
    buckets: ?[]const Bucket = null,

    /// `ContinuationToken` is included in the response when there are more buckets
    /// that can be
    /// listed with pagination. The next `ListBuckets` request to Amazon S3 can be
    /// continued with this
    /// `ContinuationToken`. `ContinuationToken` is obfuscated and is not a real
    /// bucket.
    continuation_token: ?[]const u8 = null,

    /// The owner of the buckets listed.
    owner: ?Owner = null,

    /// If `Prefix` was sent with the request, it is included in the response.
    ///
    /// All bucket names in the response begin with the specified bucket name
    /// prefix.
    prefix: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBucketsInput, options: CallOptions) !ListBucketsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBucketsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "x-id=ListBuckets");
    query_has_prev = true;
    if (input.bucket_region) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "bucket-region=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.continuation_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "continuation-token=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_buckets) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "max-buckets=");
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
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBucketsOutput {
    var result: ListBucketsOutput = .{};
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
                if (std.mem.eql(u8, e.local, "Buckets")) {
                    result.buckets = try serde.deserializeBuckets(allocator, &reader, "Bucket");
                } else if (std.mem.eql(u8, e.local, "ContinuationToken")) {
                    result.continuation_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Owner")) {
                    result.owner = try serde.deserializeOwner(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "Prefix")) {
                    result.prefix = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    _ = headers;

    return result;
}
