const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const ModifyHsmInput = struct {
    /// The new IP address for the elastic network interface (ENI) attached to the
    /// HSM.
    ///
    /// If the HSM is moved to a different subnet, and an IP address is not
    /// specified, an IP
    /// address will be randomly chosen from the CIDR range of the new subnet.
    eni_ip: ?[]const u8 = null,

    /// The new external ID.
    external_id: ?[]const u8 = null,

    /// The ARN of the HSM to modify.
    hsm_arn: []const u8,

    /// The new IAM role ARN.
    iam_role_arn: ?[]const u8 = null,

    /// The new identifier of the subnet that the HSM is in. The new subnet must be
    /// in the same
    /// Availability Zone as the current subnet.
    subnet_id: ?[]const u8 = null,

    /// The new IP address for the syslog monitoring server. The AWS CloudHSM
    /// service only supports
    /// one syslog monitoring server.
    syslog_ip: ?[]const u8 = null,

    pub const json_field_names = .{
        .eni_ip = "EniIp",
        .external_id = "ExternalId",
        .hsm_arn = "HsmArn",
        .iam_role_arn = "IamRoleArn",
        .subnet_id = "SubnetId",
        .syslog_ip = "SyslogIp",
    };
};

pub const ModifyHsmOutput = struct {
    /// The ARN of the HSM.
    hsm_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .hsm_arn = "HsmArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyHsmInput, options: CallOptions) !ModifyHsmOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudhsm");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyHsmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsm", "CloudHSM", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "CloudHsmFrontendService.ModifyHsm");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyHsmOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ModifyHsmOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "CloudHsmInternalException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmServiceException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_service_exception = .{
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
