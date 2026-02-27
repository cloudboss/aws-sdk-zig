const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const S3Config = @import("s3_config.zig").S3Config;
const S3StorageClass = @import("s3_storage_class.zig").S3StorageClass;
const TagListEntry = @import("tag_list_entry.zig").TagListEntry;

pub const CreateLocationS3Input = struct {
    /// (Amazon S3 on Outposts only) Specifies the Amazon Resource Name (ARN) of the
    /// DataSync agent on your Outpost.
    ///
    /// For more information, see [Deploy your DataSync agent on
    /// Outposts](https://docs.aws.amazon.com/datasync/latest/userguide/deploy-agents.html#outposts-agent).
    agent_arns: ?[]const []const u8 = null,

    /// Specifies the ARN of the S3 bucket that you want to use as a location. (When
    /// creating
    /// your DataSync task later, you specify whether this location is a transfer
    /// source or
    /// destination.)
    ///
    /// If your S3 bucket is located on an Outposts resource, you must specify an
    /// Amazon S3 access point. For more information, see [Managing data access
    /// with Amazon S3 access
    /// points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-points.html) in the *Amazon S3 User
    /// Guide*.
    s3_bucket_arn: []const u8,

    s3_config: S3Config,

    /// Specifies the storage class that you want your objects to use when Amazon S3
    /// is a
    /// transfer destination.
    ///
    /// For buckets in Amazon Web Services Regions, the storage class defaults to
    /// `STANDARD`. For buckets on Outposts, the storage class defaults to
    /// `OUTPOSTS`.
    ///
    /// For more information, see [Storage class
    /// considerations with Amazon S3
    /// transfers](https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html#using-storage-classes).
    s3_storage_class: ?S3StorageClass = null,

    /// Specifies a prefix in the S3 bucket that DataSync reads from or writes to
    /// (depending on whether the bucket is a source or destination location).
    ///
    /// DataSync can't transfer objects with a prefix that begins with a slash (`/`)
    /// or includes `//`, `/./`, or `/../` patterns. For
    /// example:
    ///
    /// * `/photos`
    ///
    /// * `photos//2006/January`
    ///
    /// * `photos/./2006/February`
    ///
    /// * `photos/../2006/March`
    subdirectory: ?[]const u8 = null,

    /// Specifies labels that help you categorize, filter, and search for your
    /// Amazon Web Services resources. We recommend creating at least a name tag for
    /// your transfer location.
    tags: ?[]const TagListEntry = null,

    pub const json_field_names = .{
        .agent_arns = "AgentArns",
        .s3_bucket_arn = "S3BucketArn",
        .s3_config = "S3Config",
        .s3_storage_class = "S3StorageClass",
        .subdirectory = "Subdirectory",
        .tags = "Tags",
    };
};

pub const CreateLocationS3Output = struct {
    /// The ARN of the S3 location that you created.
    location_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLocationS3Input, options: Options) !CreateLocationS3Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datasync");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateLocationS3Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "FmrsService.CreateLocationS3");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateLocationS3Output {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLocationS3Output, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
