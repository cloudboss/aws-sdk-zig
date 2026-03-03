const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EfsInTransitEncryption = @import("efs_in_transit_encryption.zig").EfsInTransitEncryption;

pub const UpdateLocationEfsInput = struct {
    /// Specifies the Amazon Resource Name (ARN) of the access point that DataSync
    /// uses
    /// to mount your Amazon EFS file system.
    ///
    /// For more information, see [Accessing
    /// restricted Amazon EFS file
    /// systems](https://docs.aws.amazon.com/datasync/latest/userguide/create-efs-location.html#create-efs-location-iam).
    access_point_arn: ?[]const u8 = null,

    /// Specifies an Identity and Access Management (IAM) role that allows DataSync
    /// to access your Amazon EFS file system.
    ///
    /// For information on creating this role, see [Creating a DataSync
    /// IAM role for Amazon EFS file system
    /// access](https://docs.aws.amazon.com/datasync/latest/userguide/create-efs-location.html#create-efs-location-iam-role).
    file_system_access_role_arn: ?[]const u8 = null,

    /// Specifies whether you want DataSync to use Transport Layer Security (TLS)
    /// 1.2
    /// encryption when it transfers data to or from your Amazon EFS file system.
    ///
    /// If you specify an access point using `AccessPointArn` or an IAM
    /// role using `FileSystemAccessRoleArn`, you must set this parameter to
    /// `TLS1_2`.
    in_transit_encryption: ?EfsInTransitEncryption = null,

    /// Specifies the Amazon Resource Name (ARN) of the Amazon EFS transfer location
    /// that
    /// you're updating.
    location_arn: []const u8,

    /// Specifies a mount path for your Amazon EFS file system. This is where
    /// DataSync reads or writes data on your file system (depending on if this is a
    /// source or
    /// destination location).
    ///
    /// By default, DataSync uses the root directory (or [access
    /// point](https://docs.aws.amazon.com/efs/latest/ug/efs-access-points.html) if
    /// you provide one by using
    /// `AccessPointArn`). You can also include subdirectories using forward slashes
    /// (for
    /// example, `/path/to/folder`).
    subdirectory: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_point_arn = "AccessPointArn",
        .file_system_access_role_arn = "FileSystemAccessRoleArn",
        .in_transit_encryption = "InTransitEncryption",
        .location_arn = "LocationArn",
        .subdirectory = "Subdirectory",
    };
};

pub const UpdateLocationEfsOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLocationEfsInput, options: CallOptions) !UpdateLocationEfsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLocationEfsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.UpdateLocationEfs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLocationEfsOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
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
