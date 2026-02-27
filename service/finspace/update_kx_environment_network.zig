const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CustomDNSServer = @import("custom_dns_server.zig").CustomDNSServer;
const TransitGatewayConfiguration = @import("transit_gateway_configuration.zig").TransitGatewayConfiguration;
const dnsStatus = @import("dns_status.zig").dnsStatus;
const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;
const tgwStatus = @import("tgw_status.zig").tgwStatus;

pub const UpdateKxEnvironmentNetworkInput = struct {
    /// A token that ensures idempotency. This token expires in 10 minutes.
    client_token: ?[]const u8 = null,

    /// A list of DNS server name and server IP. This is used to set up Route-53
    /// outbound resolvers.
    custom_dns_configuration: ?[]const CustomDNSServer = null,

    /// A unique identifier for the kdb environment.
    environment_id: []const u8,

    /// Specifies the transit gateway and network configuration to connect the kdb
    /// environment to an internal network.
    transit_gateway_configuration: ?TransitGatewayConfiguration = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .custom_dns_configuration = "customDNSConfiguration",
        .environment_id = "environmentId",
        .transit_gateway_configuration = "transitGatewayConfiguration",
    };
};

pub const UpdateKxEnvironmentNetworkOutput = struct {
    /// The identifier of the availability zones where subnets for the environment
    /// are created.
    availability_zone_ids: ?[]const []const u8 = null,

    /// The unique identifier of the AWS account that is used to create the kdb
    /// environment.
    aws_account_id: ?[]const u8 = null,

    /// The timestamp at which the kdb environment was created in FinSpace.
    creation_timestamp: ?i64 = null,

    /// A list of DNS server name and server IP. This is used to set up Route-53
    /// outbound resolvers.
    custom_dns_configuration: ?[]const CustomDNSServer = null,

    /// A unique identifier for the AWS environment infrastructure account.
    dedicated_service_account_id: ?[]const u8 = null,

    /// The description of the environment.
    description: ?[]const u8 = null,

    /// The status of DNS configuration.
    dns_status: ?dnsStatus = null,

    /// The ARN identifier of the environment.
    environment_arn: ?[]const u8 = null,

    /// A unique identifier for the kdb environment.
    environment_id: ?[]const u8 = null,

    /// Specifies the error message that appears if a flow fails.
    error_message: ?[]const u8 = null,

    /// The KMS key ID to encrypt your data in the FinSpace environment.
    kms_key_id: ?[]const u8 = null,

    /// The name of the kdb environment.
    name: ?[]const u8 = null,

    /// The status of the kdb environment.
    status: ?EnvironmentStatus = null,

    /// The status of the network configuration.
    tgw_status: ?tgwStatus = null,

    transit_gateway_configuration: ?TransitGatewayConfiguration = null,

    /// The timestamp at which the kdb environment was updated.
    update_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .availability_zone_ids = "availabilityZoneIds",
        .aws_account_id = "awsAccountId",
        .creation_timestamp = "creationTimestamp",
        .custom_dns_configuration = "customDNSConfiguration",
        .dedicated_service_account_id = "dedicatedServiceAccountId",
        .description = "description",
        .dns_status = "dnsStatus",
        .environment_arn = "environmentArn",
        .environment_id = "environmentId",
        .error_message = "errorMessage",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .status = "status",
        .tgw_status = "tgwStatus",
        .transit_gateway_configuration = "transitGatewayConfiguration",
        .update_timestamp = "updateTimestamp",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateKxEnvironmentNetworkInput, options: Options) !UpdateKxEnvironmentNetworkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "finspace");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateKxEnvironmentNetworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/kx/environments/");
    try path_buf.appendSlice(alloc, input.environment_id);
    try path_buf.appendSlice(alloc, "/network");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.custom_dns_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"customDNSConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.transit_gateway_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"transitGatewayConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateKxEnvironmentNetworkOutput {
    var result: UpdateKxEnvironmentNetworkOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateKxEnvironmentNetworkOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
