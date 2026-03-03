const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Storage = @import("storage.zig").Storage;
const BundleTask = @import("bundle_task.zig").BundleTask;
const serde = @import("serde.zig");

pub const BundleInstanceInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the instance to bundle.
    ///
    /// Default: None
    instance_id: []const u8,

    /// The bucket in which to store the AMI. You can specify a bucket that you
    /// already own or a
    /// new bucket that Amazon EC2 creates on your behalf. If you specify a bucket
    /// that belongs to someone
    /// else, Amazon EC2 returns an error.
    storage: Storage,
};

pub const BundleInstanceOutput = struct {
    /// Information about the bundle task.
    bundle_task: ?BundleTask = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BundleInstanceInput, options: Options) !BundleInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: BundleInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=BundleInstance&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&InstanceId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.instance_id);
    if (input.storage.s3) |sv| {
        if (sv.aws_access_key_id) |sv2| {
            try body_buf.appendSlice(allocator, "&Storage.S3.AWSAccessKeyId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.bucket) |sv2| {
            try body_buf.appendSlice(allocator, "&Storage.S3.Bucket=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.prefix) |sv2| {
            try body_buf.appendSlice(allocator, "&Storage.S3.Prefix=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.upload_policy) |sv2| {
            try body_buf.appendSlice(allocator, "&Storage.S3.UploadPolicy=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.upload_policy_signature) |sv2| {
            try body_buf.appendSlice(allocator, "&Storage.S3.UploadPolicySignature=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BundleInstanceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: BundleInstanceOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "bundleInstanceTask")) {
                    result.bundle_task = try serde.deserializeBundleTask(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
