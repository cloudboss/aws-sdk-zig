const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const TrustStoreResponseOption = @import("trust_store_response_option.zig").TrustStoreResponseOption;
const IngressPointAuthConfiguration = @import("ingress_point_auth_configuration.zig").IngressPointAuthConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const IngressPointStatus = @import("ingress_point_status.zig").IngressPointStatus;
const TlsPolicy = @import("tls_policy.zig").TlsPolicy;
const IngressPointType = @import("ingress_point_type.zig").IngressPointType;

pub const GetIngressPointInput = struct {
    /// Whether to include the trust store contents in the response. Use INCLUDE to
    /// retrieve trust store certificate and CRL contents.
    include_trust_store_contents: ?TrustStoreResponseOption = null,

    /// The identifier of an ingress endpoint.
    ingress_point_id: []const u8,

    pub const json_field_names = .{
        .include_trust_store_contents = "IncludeTrustStoreContents",
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

    /// The selected Transport Layer Security (TLS) policy of the ingress point.
    tls_policy: ?TlsPolicy = null,

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
        .tls_policy = "TlsPolicy",
        .traffic_policy_id = "TrafficPolicyId",
        .@"type" = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIngressPointInput, options: CallOptions) !GetIngressPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetIngressPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mail-manager", "MailManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.GetIngressPoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIngressPointOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetIngressPointOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
