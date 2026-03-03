const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const UpdateChapCredentialsInput = struct {
    /// The iSCSI initiator that connects to the target.
    initiator_name: []const u8,

    /// The secret key that the initiator (for example, the Windows client) must
    /// provide to
    /// participate in mutual CHAP with the target.
    ///
    /// The secret key must be between 12 and 16 bytes when encoded in UTF-8.
    secret_to_authenticate_initiator: []const u8,

    /// The secret key that the target must provide to participate in mutual CHAP
    /// with the
    /// initiator (e.g. Windows client).
    ///
    /// Byte constraints: Minimum bytes of 12. Maximum bytes of 16.
    ///
    /// The secret key must be between 12 and 16 bytes when encoded in UTF-8.
    secret_to_authenticate_target: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the iSCSI volume target. Use the
    /// DescribeStorediSCSIVolumes operation to return the TargetARN for specified
    /// VolumeARN.
    target_arn: []const u8,

    pub const json_field_names = .{
        .initiator_name = "InitiatorName",
        .secret_to_authenticate_initiator = "SecretToAuthenticateInitiator",
        .secret_to_authenticate_target = "SecretToAuthenticateTarget",
        .target_arn = "TargetARN",
    };
};

pub const UpdateChapCredentialsOutput = struct {
    /// The iSCSI initiator that connects to the target. This is the same initiator
    /// name
    /// specified in the request.
    initiator_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the target. This is the same target
    /// specified in the
    /// request.
    target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .initiator_name = "InitiatorName",
        .target_arn = "TargetARN",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateChapCredentialsInput, options: Options) !UpdateChapCredentialsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "storagegateway");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateChapCredentialsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.UpdateChapCredentials");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateChapCredentialsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateChapCredentialsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGatewayRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_gateway_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableError")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_error = .{
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
