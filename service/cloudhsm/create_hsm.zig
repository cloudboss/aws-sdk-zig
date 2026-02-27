const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SubscriptionType = @import("subscription_type.zig").SubscriptionType;

pub const CreateHsmInput = struct {
    /// A user-defined token to ensure idempotence. Subsequent calls to this
    /// operation with the
    /// same token will be ignored.
    client_token: ?[]const u8 = null,

    /// The IP address to assign to the HSM's ENI.
    ///
    /// If an IP address is not specified, an IP address will be randomly chosen
    /// from the CIDR
    /// range of the subnet.
    eni_ip: ?[]const u8 = null,

    /// The external ID from `IamRoleArn`, if present.
    external_id: ?[]const u8 = null,

    /// The ARN of an IAM role to enable the AWS CloudHSM service to allocate an ENI
    /// on your
    /// behalf.
    iam_role_arn: []const u8,

    /// The SSH public key to install on the HSM.
    ssh_key: []const u8,

    /// The identifier of the subnet in your VPC in which to place the HSM.
    subnet_id: []const u8,

    subscription_type: SubscriptionType,

    /// The IP address for the syslog monitoring server. The AWS CloudHSM service
    /// only supports one
    /// syslog monitoring server.
    syslog_ip: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .eni_ip = "EniIp",
        .external_id = "ExternalId",
        .iam_role_arn = "IamRoleArn",
        .ssh_key = "SshKey",
        .subnet_id = "SubnetId",
        .subscription_type = "SubscriptionType",
        .syslog_ip = "SyslogIp",
    };
};

pub const CreateHsmOutput = struct {
    /// The ARN of the HSM.
    hsm_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .hsm_arn = "HsmArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHsmInput, options: Options) !CreateHsmOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudhsm");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateHsmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsm", "CloudHSM", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "CloudHsmFrontendService.CreateHsm");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateHsmOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateHsmOutput, body, alloc);
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
