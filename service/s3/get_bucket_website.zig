const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ErrorDocument = @import("error_document.zig").ErrorDocument;
const IndexDocument = @import("index_document.zig").IndexDocument;
const RedirectAllRequestsTo = @import("redirect_all_requests_to.zig").RedirectAllRequestsTo;
const RoutingRule = @import("routing_rule.zig").RoutingRule;
const serde = @import("serde.zig");

pub const GetBucketWebsiteInput = struct {
    /// The bucket name for which to get the website configuration.
    bucket: []const u8,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    expected_bucket_owner: ?[]const u8 = null,
};

pub const GetBucketWebsiteOutput = struct {
    /// The object key name of the website error document to use for 4XX class
    /// errors.
    error_document: ?ErrorDocument = null,

    /// The name of the index document for the website (for example `index.html`).
    index_document: ?IndexDocument = null,

    /// Specifies the redirect behavior of all requests to a website endpoint of an
    /// Amazon S3 bucket.
    redirect_all_requests_to: ?RedirectAllRequestsTo = null,

    /// Rules that define when a redirect is applied and the redirect behavior.
    routing_rules: ?[]const RoutingRule = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBucketWebsiteInput, options: CallOptions) !GetBucketWebsiteOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBucketWebsiteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "website");
    query_has_prev = true;
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBucketWebsiteOutput {
    var result: GetBucketWebsiteOutput = .{};
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
                if (std.mem.eql(u8, e.local, "ErrorDocument")) {
                    result.error_document = try serde.deserializeErrorDocument(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "IndexDocument")) {
                    result.index_document = try serde.deserializeIndexDocument(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "RedirectAllRequestsTo")) {
                    result.redirect_all_requests_to = try serde.deserializeRedirectAllRequestsTo(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "RoutingRules")) {
                    result.routing_rules = try serde.deserializeRoutingRules(allocator, &reader, "RoutingRule");
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
