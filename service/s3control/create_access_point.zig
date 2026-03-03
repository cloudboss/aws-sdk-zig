const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PublicAccessBlockConfiguration = @import("public_access_block_configuration.zig").PublicAccessBlockConfiguration;
const Scope = @import("scope.zig").Scope;
const Tag = @import("tag.zig").Tag;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;
const serde = @import("serde.zig");

pub const CreateAccessPointInput = struct {
    /// The Amazon Web Services account ID for the account that owns the specified
    /// access point.
    account_id: []const u8,

    /// The name of the bucket that you want to associate this access point with.
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
    bucket: []const u8,

    /// The Amazon Web Services account ID associated with the S3 bucket associated
    /// with this access point.
    ///
    /// For same account access point when your bucket and access point belong to
    /// the same account owner, the `BucketAccountId` is not required.
    /// For cross-account access point when your bucket and access point are not in
    /// the same account, the `BucketAccountId` is required.
    bucket_account_id: ?[]const u8 = null,

    /// The name you want to assign to this access point.
    ///
    /// For directory buckets, the access point name must consist of a base name
    /// that you provide and
    /// suffix that includes the `ZoneID` (Amazon Web Services Availability Zone or
    /// Local Zone) of your bucket location,
    /// followed by `--xa-s3`. For more information, see [Managing access to shared
    /// datasets in directory buckets with
    /// access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-directory-buckets.html) in the *Amazon S3 User Guide*.
    name: []const u8,

    /// The `PublicAccessBlock` configuration that you want to apply to the access
    /// point.
    public_access_block_configuration: ?PublicAccessBlockConfiguration = null,

    /// For directory buckets, you can filter access control to specific prefixes,
    /// API
    /// operations, or a combination of both. For more information, see [Managing
    /// access to shared datasets in directory buckets with
    /// access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points-directory-buckets.html) in the *Amazon S3 User Guide*.
    ///
    /// Scope is only supported for access points attached to directory buckets.
    scope: ?Scope = null,

    /// An array of tags that you can apply to an access point. Tags are key-value
    /// pairs of metadata used to control access to your access points. For more
    /// information about tags, see [Using tags with Amazon
    /// S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html). For
    /// information about tagging access points, see [Using tags for attribute-based
    /// access control
    /// (ABAC)](https://docs.aws.amazon.com/AmazonS3/latest/userguide/tagging.html#using-tags-for-abac).
    tags: ?[]const Tag = null,

    /// If you include this field, Amazon S3 restricts access to this access point
    /// to requests from the
    /// specified virtual private cloud (VPC).
    ///
    /// This is required for creating an access point for Amazon S3 on Outposts
    /// buckets.
    vpc_configuration: ?VpcConfiguration = null,
};

pub const CreateAccessPointOutput = struct {
    /// The ARN of the access point.
    ///
    /// This is only supported by Amazon S3 on Outposts.
    access_point_arn: ?[]const u8 = null,

    /// The name or alias of the access point.
    alias: ?[]const u8 = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessPointInput, options: Options) !CreateAccessPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "s3control");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAccessPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3control", "S3 Control", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v20180820/accesspoint/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    try body_buf.appendSlice(allocator, "<CreateAccessPointRequest>");
    try body_buf.appendSlice(allocator, "<Bucket>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.bucket);
    try body_buf.appendSlice(allocator, "</Bucket>");
    if (input.bucket_account_id) |v| {
        try body_buf.appendSlice(allocator, "<BucketAccountId>");
        try aws.xml.appendXmlEscaped(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</BucketAccountId>");
    }
    if (input.public_access_block_configuration) |v| {
        try body_buf.appendSlice(allocator, "<PublicAccessBlockConfiguration>");
        try serde.serializePublicAccessBlockConfiguration(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</PublicAccessBlockConfiguration>");
    }
    if (input.scope) |v| {
        try body_buf.appendSlice(allocator, "<Scope>");
        try serde.serializeScope(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</Scope>");
    }
    if (input.tags) |v| {
        try body_buf.appendSlice(allocator, "<Tags>");
        try serde.serializeTagList(allocator, &body_buf, v, "Tag");
        try body_buf.appendSlice(allocator, "</Tags>");
    }
    if (input.vpc_configuration) |v| {
        try body_buf.appendSlice(allocator, "<VpcConfiguration>");
        try serde.serializeVpcConfiguration(allocator, &body_buf, v);
        try body_buf.appendSlice(allocator, "</VpcConfiguration>");
    }
    try body_buf.appendSlice(allocator, "</CreateAccessPointRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAccessPointOutput {
    var result: CreateAccessPointOutput = .{};
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
                if (std.mem.eql(u8, e.local, "AccessPointArn")) {
                    result.access_point_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Alias")) {
                    result.alias = try allocator.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "IdempotencyException")) {
        return .{ .arena = arena, .kind = .{ .idempotency_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "JobStatusException")) {
        return .{ .arena = arena, .kind = .{ .job_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoSuchPublicAccessBlockConfiguration")) {
        return .{ .arena = arena, .kind = .{ .no_such_public_access_block_configuration = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
