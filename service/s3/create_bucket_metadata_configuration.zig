const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChecksumAlgorithm = @import("checksum_algorithm.zig").ChecksumAlgorithm;
const MetadataConfiguration = @import("metadata_configuration.zig").MetadataConfiguration;
const serde = @import("serde.zig");

pub const CreateBucketMetadataConfigurationInput = struct {
    /// The general purpose bucket that you want to create the metadata
    /// configuration for.
    bucket: []const u8,

    /// The checksum algorithm to use with your metadata configuration.
    checksum_algorithm: ?ChecksumAlgorithm = null,

    /// The `Content-MD5` header for the metadata configuration.
    content_md5: ?[]const u8 = null,

    /// The expected owner of the general purpose bucket that corresponds to your
    /// metadata configuration.
    expected_bucket_owner: ?[]const u8 = null,

    /// The contents of your metadata configuration.
    metadata_configuration: MetadataConfiguration,
};

pub const CreateBucketMetadataConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBucketMetadataConfigurationInput, options: CallOptions) !CreateBucketMetadataConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBucketMetadataConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "metadataConfiguration");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<MetadataConfiguration xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">");
    try serde.serializeMetadataConfiguration(allocator, &body_buf, input.metadata_configuration);
    try body_buf.appendSlice(allocator, "</MetadataConfiguration>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    if (input.checksum_algorithm) |v| {
        try request.headers.put(allocator, "x-amz-sdk-checksum-algorithm", v.wireName());
    }
    if (input.content_md5) |v| {
        try request.headers.put(allocator, "Content-MD5", v);
    }
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBucketMetadataConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CreateBucketMetadataConfigurationOutput = .{};

    return result;
}
