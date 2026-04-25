const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const IngressPointConfiguration = @import("ingress_point_configuration.zig").IngressPointConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const Tag = @import("tag.zig").Tag;
const TlsPolicy = @import("tls_policy.zig").TlsPolicy;
const IngressPointType = @import("ingress_point_type.zig").IngressPointType;

pub const CreateIngressPointInput = struct {
    /// A unique token that Amazon SES uses to recognize subsequent retries of the
    /// same request.
    client_token: ?[]const u8 = null,

    /// If you choose an Authenticated ingress endpoint, you must configure either
    /// an SMTP password or a secret ARN.
    ingress_point_configuration: ?IngressPointConfiguration = null,

    /// A user friendly name for an ingress endpoint resource.
    ingress_point_name: []const u8,

    /// Specifies the network configuration for the ingress point. This allows you
    /// to create an IPv4-only, Dual-Stack, or PrivateLink type of ingress point. If
    /// not specified, the default network type is IPv4-only.
    network_configuration: ?NetworkConfiguration = null,

    /// The identifier of an existing rule set that you attach to an ingress
    /// endpoint resource.
    rule_set_id: []const u8,

    /// The tags used to organize, track, or control access for the resource. For
    /// example, { "tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const Tag = null,

    /// The Transport Layer Security (TLS) policy for the ingress point. The FIPS
    /// value is only valid in US and Canada regions.
    tls_policy: ?TlsPolicy = null,

    /// The identifier of an existing traffic policy that you attach to an ingress
    /// endpoint resource.
    traffic_policy_id: []const u8,

    /// The type of the ingress endpoint to create.
    @"type": IngressPointType,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .ingress_point_configuration = "IngressPointConfiguration",
        .ingress_point_name = "IngressPointName",
        .network_configuration = "NetworkConfiguration",
        .rule_set_id = "RuleSetId",
        .tags = "Tags",
        .tls_policy = "TlsPolicy",
        .traffic_policy_id = "TrafficPolicyId",
        .@"type" = "Type",
    };
};

pub const CreateIngressPointOutput = struct {
    /// The unique identifier for a previously created ingress endpoint.
    ingress_point_id: []const u8,

    pub const json_field_names = .{
        .ingress_point_id = "IngressPointId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIngressPointInput, options: CallOptions) !CreateIngressPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ses");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIngressPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mail-manager", "MailManager", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.CreateIngressPoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIngressPointOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateIngressPointOutput, body, allocator);
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
