const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SubnetMapping = @import("subnet_mapping.zig").SubnetMapping;

pub const DisassociateSubnetsInput = struct {
    /// The Amazon Resource Name (ARN) of the firewall.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    firewall_arn: ?[]const u8 = null,

    /// The descriptive name of the firewall. You can't change the name of a
    /// firewall after you create it.
    ///
    /// You must specify the ARN or the name, and you can specify both.
    firewall_name: ?[]const u8 = null,

    /// The unique identifiers for the subnets that you want to disassociate.
    subnet_ids: []const []const u8,

    /// An optional token that you can use for optimistic locking. Network Firewall
    /// returns a token to your requests that access the firewall. The token marks
    /// the state of the firewall resource at the time of the request.
    ///
    /// To make an unconditional change to the firewall, omit the token in your
    /// update request. Without the token, Network Firewall performs your updates
    /// regardless of whether the firewall has changed since you last retrieved it.
    ///
    /// To make a conditional change to the firewall, provide the token in your
    /// update request. Network Firewall uses the token to ensure that the firewall
    /// hasn't changed since you last retrieved it. If it has changed, the operation
    /// fails with an `InvalidTokenException`. If this happens, retrieve the
    /// firewall again to get a current copy of it with a new token. Reapply your
    /// changes as needed, then try the operation again using the new token.
    update_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_arn = "FirewallArn",
        .firewall_name = "FirewallName",
        .subnet_ids = "SubnetIds",
        .update_token = "UpdateToken",
    };
};

pub const DisassociateSubnetsOutput = struct {
    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: ?[]const u8 = null,

    /// The descriptive name of the firewall. You can't change the name of a
    /// firewall after you create it.
    firewall_name: ?[]const u8 = null,

    /// The IDs of the subnets that are associated with the firewall.
    subnet_mappings: ?[]const SubnetMapping = null,

    /// An optional token that you can use for optimistic locking. Network Firewall
    /// returns a token to your requests that access the firewall. The token marks
    /// the state of the firewall resource at the time of the request.
    ///
    /// To make an unconditional change to the firewall, omit the token in your
    /// update request. Without the token, Network Firewall performs your updates
    /// regardless of whether the firewall has changed since you last retrieved it.
    ///
    /// To make a conditional change to the firewall, provide the token in your
    /// update request. Network Firewall uses the token to ensure that the firewall
    /// hasn't changed since you last retrieved it. If it has changed, the operation
    /// fails with an `InvalidTokenException`. If this happens, retrieve the
    /// firewall again to get a current copy of it with a new token. Reapply your
    /// changes as needed, then try the operation again using the new token.
    update_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_arn = "FirewallArn",
        .firewall_name = "FirewallName",
        .subnet_mappings = "SubnetMappings",
        .update_token = "UpdateToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateSubnetsInput, options: Options) !DisassociateSubnetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateSubnetsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DisassociateSubnets");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateSubnetsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisassociateSubnetsOutput, body, allocator);
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
