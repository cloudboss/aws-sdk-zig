const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const Tag = @import("tag.zig").Tag;
const TLSInspectionConfiguration = @import("tls_inspection_configuration.zig").TLSInspectionConfiguration;
const TLSInspectionConfigurationResponse = @import("tls_inspection_configuration_response.zig").TLSInspectionConfigurationResponse;

pub const CreateTLSInspectionConfigurationInput = struct {
    /// A description of the TLS inspection configuration.
    description: ?[]const u8 = null,

    encryption_configuration: ?EncryptionConfiguration = null,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    /// The object that defines a TLS inspection configuration. This, along with
    /// TLSInspectionConfigurationResponse, define the TLS inspection configuration.
    /// You can retrieve all objects for a TLS inspection configuration by calling
    /// DescribeTLSInspectionConfiguration.
    ///
    /// Network Firewall uses a TLS inspection configuration to decrypt traffic.
    /// Network Firewall re-encrypts the traffic before sending it to its
    /// destination.
    ///
    /// To use a TLS inspection configuration, you add it to a new Network Firewall
    /// firewall policy, then you apply the firewall policy to a firewall. Network
    /// Firewall acts as a proxy service to decrypt and inspect the traffic
    /// traveling through your firewalls. You can reference a TLS inspection
    /// configuration from more than one firewall policy, and you can use a firewall
    /// policy in more than one firewall. For more information about using TLS
    /// inspection configurations, see
    /// [Inspecting SSL/TLS traffic with TLS
    /// inspection
    /// configurations](https://docs.aws.amazon.com/network-firewall/latest/developerguide/tls-inspection.html) in the *Network Firewall Developer Guide*.
    tls_inspection_configuration: TLSInspectionConfiguration,

    /// The descriptive name of the TLS inspection configuration. You can't change
    /// the name of a TLS inspection configuration after you create it.
    tls_inspection_configuration_name: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .encryption_configuration = "EncryptionConfiguration",
        .tags = "Tags",
        .tls_inspection_configuration = "TLSInspectionConfiguration",
        .tls_inspection_configuration_name = "TLSInspectionConfigurationName",
    };
};

pub const CreateTLSInspectionConfigurationOutput = struct {
    /// The high-level properties of a TLS inspection configuration. This, along
    /// with the TLSInspectionConfiguration, define the TLS inspection
    /// configuration. You can retrieve all objects for a TLS inspection
    /// configuration by calling DescribeTLSInspectionConfiguration.
    tls_inspection_configuration_response: ?TLSInspectionConfigurationResponse = null,

    /// A token used for optimistic locking. Network Firewall returns a token to
    /// your requests that access the TLS inspection configuration. The token marks
    /// the state of the TLS inspection configuration resource at the time of the
    /// request.
    ///
    /// To make changes to the TLS inspection configuration, you provide the token
    /// in your request. Network Firewall uses the token to ensure that the TLS
    /// inspection configuration hasn't changed since you last retrieved it. If it
    /// has changed, the operation fails with an `InvalidTokenException`. If this
    /// happens, retrieve the TLS inspection configuration again to get a current
    /// copy of it with a current token. Reapply your changes as needed, then try
    /// the operation again using the new token.
    update_token: []const u8,

    pub const json_field_names = .{
        .tls_inspection_configuration_response = "TLSInspectionConfigurationResponse",
        .update_token = "UpdateToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTLSInspectionConfigurationInput, options: Options) !CreateTLSInspectionConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "networkfirewall");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTLSInspectionConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkfirewall", "Network Firewall", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.CreateTLSInspectionConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTLSInspectionConfigurationOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateTLSInspectionConfigurationOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InsufficientCapacityException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capacity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidResourcePolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "LogDestinationPermissionException")) {
        return .{ .arena = arena, .kind = .{ .log_destination_permission_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceOwnerCheckException")) {
        return .{ .arena = arena, .kind = .{ .resource_owner_check_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
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
