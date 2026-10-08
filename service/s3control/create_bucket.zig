const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BucketCannedACL = @import("bucket_canned_acl.zig").BucketCannedACL;
const CreateBucketConfiguration = @import("create_bucket_configuration.zig").CreateBucketConfiguration;
const serde = @import("serde.zig");

pub const CreateBucketInput = struct {
    /// The canned ACL to apply to the bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    acl: ?BucketCannedACL = null,

    /// The name of the bucket.
    bucket: []const u8,

    /// The configuration information for the bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    create_bucket_configuration: ?CreateBucketConfiguration = null,

    /// Allows grantee the read, write, read ACP, and write ACP permissions on the
    /// bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    grant_full_control: ?[]const u8 = null,

    /// Allows grantee to list the objects in the bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    grant_read: ?[]const u8 = null,

    /// Allows grantee to read the bucket ACL.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    grant_read_acp: ?[]const u8 = null,

    /// Allows grantee to create, overwrite, and delete any object in the bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    grant_write: ?[]const u8 = null,

    /// Allows grantee to write the ACL for the applicable bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    grant_write_acp: ?[]const u8 = null,

    /// Specifies whether you want S3 Object Lock to be enabled for the new bucket.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    object_lock_enabled_for_bucket: ?bool = null,

    /// The ID of the Outposts where the bucket is being created.
    ///
    /// This ID is required by Amazon S3 on Outposts buckets.
    outpost_id: ?[]const u8 = null,
};

pub const CreateBucketOutput = struct {
    /// The Amazon Resource Name (ARN) of the bucket.
    ///
    /// For using this parameter with Amazon S3 on Outposts with the REST API, you
    /// must specify the name and the x-amz-outpost-id as well.
    ///
    /// For using this parameter with S3 on Outposts with the Amazon Web Services
    /// SDK and CLI, you must specify the ARN of the bucket accessed in the format
    /// `arn:aws:s3-outposts:::outpost//bucket/`. For example, to access the bucket
    /// `reports` through Outpost `my-outpost` owned by account `123456789012` in
    /// Region `us-west-2`, use the URL encoding of
    /// `arn:aws:s3-outposts:us-west-2:123456789012:outpost/my-outpost/bucket/reports`. The value must be URL encoded.
    bucket_arn: ?[]const u8 = null,

    /// The location of the bucket.
    location: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBucketInput, options: CallOptions) !CreateBucketOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBucketInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20180820/bucket/");
    try path_buf.appendSlice(allocator, input.bucket);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = blk: {
        if (input.create_bucket_configuration) |payload| {
            var body_buf: std.ArrayList(u8) = .empty;
            try body_buf.appendSlice(allocator, "<CreateBucketConfiguration xmlns=\"http://awss3control.amazonaws.com/doc/2018-08-20/\">");
            try serde.serializeCreateBucketConfiguration(allocator, &body_buf, payload);
            try body_buf.appendSlice(allocator, "</CreateBucketConfiguration>");
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
    if (input.acl) |v| {
        try request.headers.put(allocator, "x-amz-acl", v.wireName());
    }
    if (input.grant_full_control) |v| {
        try request.headers.put(allocator, "x-amz-grant-full-control", v);
    }
    if (input.grant_read) |v| {
        try request.headers.put(allocator, "x-amz-grant-read", v);
    }
    if (input.grant_read_acp) |v| {
        try request.headers.put(allocator, "x-amz-grant-read-acp", v);
    }
    if (input.grant_write) |v| {
        try request.headers.put(allocator, "x-amz-grant-write", v);
    }
    if (input.grant_write_acp) |v| {
        try request.headers.put(allocator, "x-amz-grant-write-acp", v);
    }
    if (input.object_lock_enabled_for_bucket) |v| {
        try request.headers.put(allocator, "x-amz-bucket-object-lock-enabled", if (v) "true" else "false");
    }
    if (input.outpost_id) |v| {
        try request.headers.put(allocator, "x-amz-outpost-id", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBucketOutput {
    var result: CreateBucketOutput = .{};
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
                if (std.mem.eql(u8, e.local, "BucketArn")) {
                    result.bucket_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
