const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Ec2Config = @import("ec_2_config.zig").Ec2Config;
const EfsInTransitEncryption = @import("efs_in_transit_encryption.zig").EfsInTransitEncryption;

pub const DescribeLocationEfsInput = struct {
    /// The Amazon Resource Name (ARN) of the Amazon EFS file system location that
    /// you
    /// want information about.
    location_arn: []const u8,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub const DescribeLocationEfsOutput = struct {
    /// The ARN of the access point that DataSync uses to access the Amazon EFS
    /// file system.
    ///
    /// For more information, see [Accessing
    /// restricted file
    /// systems](https://docs.aws.amazon.com/datasync/latest/userguide/create-efs-location.html#create-efs-location-iam).
    access_point_arn: ?[]const u8 = null,

    /// The time that the location was created.
    creation_time: ?i64 = null,

    ec_2_config: ?Ec2Config = null,

    /// The Identity and Access Management (IAM) role that allows DataSync to
    /// access your Amazon EFS file system.
    ///
    /// For more information, see [Creating a DataSync
    /// IAM role for file system
    /// access](https://docs.aws.amazon.com/datasync/latest/userguide/create-efs-location.html#create-efs-location-iam-role).
    file_system_access_role_arn: ?[]const u8 = null,

    /// Indicates whether DataSync uses Transport Layer Security (TLS) encryption
    /// when
    /// transferring data to or from the Amazon EFS file system.
    in_transit_encryption: ?EfsInTransitEncryption = null,

    /// The ARN of the Amazon EFS file system location.
    location_arn: ?[]const u8 = null,

    /// The URL of the Amazon EFS file system location.
    location_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_point_arn = "AccessPointArn",
        .creation_time = "CreationTime",
        .ec_2_config = "Ec2Config",
        .file_system_access_role_arn = "FileSystemAccessRoleArn",
        .in_transit_encryption = "InTransitEncryption",
        .location_arn = "LocationArn",
        .location_uri = "LocationUri",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLocationEfsInput, options: Options) !DescribeLocationEfsOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLocationEfsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.DescribeLocationEfs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLocationEfsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLocationEfsOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
