const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LifecycleConfiguration = @import("lifecycle_configuration.zig").LifecycleConfiguration;
const serde = @import("serde.zig");

pub const PutBucketLifecycleConfigurationInput = struct {
    /// The Amazon Web Services account ID of the Outposts bucket.
    account_id: []const u8,

    /// The name of the bucket for which to set the configuration.
    bucket: []const u8,

    /// Container for lifecycle rules. You can add as many as 1,000 rules.
    lifecycle_configuration: ?LifecycleConfiguration = null,
};

pub const PutBucketLifecycleConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutBucketLifecycleConfigurationInput, options: CallOptions) !PutBucketLifecycleConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutBucketLifecycleConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20180820/bucket/");
    try path_buf.appendSlice(allocator, input.bucket);
    try path_buf.appendSlice(allocator, "/lifecycleconfiguration");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = blk: {
        if (input.lifecycle_configuration) |payload| {
            var body_buf: std.ArrayList(u8) = .empty;
            try body_buf.appendSlice(allocator, "<LifecycleConfiguration xmlns=\"http://awss3control.amazonaws.com/doc/2018-08-20/\">");
            try serde.serializeLifecycleConfiguration(allocator, &body_buf, payload);
            try body_buf.appendSlice(allocator, "</LifecycleConfiguration>");
            break :blk try body_buf.toOwnedSlice(allocator);
        }
        break :blk null;
    };

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutBucketLifecycleConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutBucketLifecycleConfigurationOutput = .{};

    return result;
}
