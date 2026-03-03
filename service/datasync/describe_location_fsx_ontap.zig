const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FsxProtocol = @import("fsx_protocol.zig").FsxProtocol;

pub const DescribeLocationFsxOntapInput = struct {
    /// Specifies the Amazon Resource Name (ARN) of the FSx for ONTAP file system
    /// location that you want information about.
    location_arn: []const u8,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub const DescribeLocationFsxOntapOutput = struct {
    /// The time that the location was created.
    creation_time: ?i64 = null,

    /// The ARN of the FSx for ONTAP file system.
    fsx_filesystem_arn: ?[]const u8 = null,

    /// The ARN of the FSx for ONTAP file system location.
    location_arn: ?[]const u8 = null,

    /// The uniform resource identifier (URI) of the FSx for ONTAP file system
    /// location.
    location_uri: ?[]const u8 = null,

    protocol: ?FsxProtocol = null,

    /// The security groups that DataSync uses to access your FSx for ONTAP
    /// file system.
    security_group_arns: ?[]const []const u8 = null,

    /// The ARN of the storage virtual machine (SVM) on your FSx for ONTAP file
    /// system
    /// where you're copying data to or from.
    storage_virtual_machine_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .fsx_filesystem_arn = "FsxFilesystemArn",
        .location_arn = "LocationArn",
        .location_uri = "LocationUri",
        .protocol = "Protocol",
        .security_group_arns = "SecurityGroupArns",
        .storage_virtual_machine_arn = "StorageVirtualMachineArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLocationFsxOntapInput, options: Options) !DescribeLocationFsxOntapOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLocationFsxOntapInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.DescribeLocationFsxOntap");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLocationFsxOntapOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLocationFsxOntapOutput, body, allocator);
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
