const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IngressPointAuthConfiguration = @import("ingress_point_auth_configuration.zig").IngressPointAuthConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const IngressPointStatus = @import("ingress_point_status.zig").IngressPointStatus;
const IngressPointType = @import("ingress_point_type.zig").IngressPointType;

pub const GetIngressPointInput = struct {
    /// The identifier of an ingress endpoint.
    ingress_point_id: []const u8,

    pub const json_field_names = .{
        .ingress_point_id = "IngressPointId",
    };
};

pub const GetIngressPointOutput = struct {
    /// The DNS A Record that identifies your ingress endpoint. Configure your DNS
    /// Mail Exchange (MX) record with this value to route emails to Mail Manager.
    a_record: ?[]const u8 = null,

    /// The timestamp of when the ingress endpoint was created.
    created_timestamp: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the ingress endpoint resource.
    ingress_point_arn: ?[]const u8 = null,

    /// The authentication configuration of the ingress endpoint resource.
    ingress_point_auth_configuration: ?IngressPointAuthConfiguration = null,

    /// The identifier of an ingress endpoint resource.
    ingress_point_id: []const u8,

    /// A user friendly name for the ingress endpoint.
    ingress_point_name: []const u8,

    /// The timestamp of when the ingress endpoint was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The network configuration for the ingress point.
    network_configuration: ?NetworkConfiguration = null,

    /// The identifier of a rule set resource associated with the ingress endpoint.
    rule_set_id: ?[]const u8 = null,

    /// The status of the ingress endpoint resource.
    status: ?IngressPointStatus = null,

    /// The identifier of the traffic policy resource associated with the ingress
    /// endpoint.
    traffic_policy_id: ?[]const u8 = null,

    /// The type of ingress endpoint.
    @"type": ?IngressPointType = null,

    pub const json_field_names = .{
        .a_record = "ARecord",
        .created_timestamp = "CreatedTimestamp",
        .ingress_point_arn = "IngressPointArn",
        .ingress_point_auth_configuration = "IngressPointAuthConfiguration",
        .ingress_point_id = "IngressPointId",
        .ingress_point_name = "IngressPointName",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .network_configuration = "NetworkConfiguration",
        .rule_set_id = "RuleSetId",
        .status = "Status",
        .traffic_policy_id = "TrafficPolicyId",
        .@"type" = "Type",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIngressPointInput, options: Options) !GetIngressPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mailmanager");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetIngressPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mailmanager", "MailManager", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "MailManagerSvc.GetIngressPoint");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetIngressPointOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetIngressPointOutput, body, alloc);
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
