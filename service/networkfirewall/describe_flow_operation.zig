const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FlowOperation = @import("flow_operation.zig").FlowOperation;
const FlowOperationStatus = @import("flow_operation_status.zig").FlowOperationStatus;
const FlowOperationType = @import("flow_operation_type.zig").FlowOperationType;

pub const DescribeFlowOperationInput = struct {
    /// The ID of the Availability Zone where the firewall is located. For example,
    /// `us-east-2a`.
    ///
    /// Defines the scope a flow operation. You can use up to 20 filters to
    /// configure a single flow operation.
    availability_zone: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: []const u8,

    /// A unique identifier for the flow operation. This ID is returned in the
    /// responses to start and list commands. You provide to describe commands.
    flow_operation_id: []const u8,

    /// The Amazon Resource Name (ARN) of a VPC endpoint association.
    vpc_endpoint_association_arn: ?[]const u8 = null,

    /// A unique identifier for the primary endpoint associated with a firewall.
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .firewall_arn = "FirewallArn",
        .flow_operation_id = "FlowOperationId",
        .vpc_endpoint_association_arn = "VpcEndpointAssociationArn",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};

pub const DescribeFlowOperationOutput = struct {
    /// The ID of the Availability Zone where the firewall is located. For example,
    /// `us-east-2a`.
    ///
    /// Defines the scope a flow operation. You can use up to 20 filters to
    /// configure a single flow operation.
    availability_zone: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: ?[]const u8 = null,

    /// Returns key information about a flow operation, such as related statuses,
    /// unique identifiers, and all filters defined in the operation.
    flow_operation: ?FlowOperation = null,

    /// A unique identifier for the flow operation. This ID is returned in the
    /// responses to start and list commands. You provide to describe commands.
    flow_operation_id: ?[]const u8 = null,

    /// Returns the status of the flow operation. This string is returned in the
    /// responses to start, list, and describe commands.
    ///
    /// If the status is `COMPLETED_WITH_ERRORS`, results may be returned with any
    /// number of `Flows` missing from the response.
    /// If the status is `FAILED`, `Flows` returned will be empty.
    flow_operation_status: ?FlowOperationStatus = null,

    /// Defines the type of `FlowOperation`.
    flow_operation_type: ?FlowOperationType = null,

    /// A timestamp indicating when the Suricata engine identified flows impacted by
    /// an operation.
    flow_request_timestamp: ?i64 = null,

    /// If the asynchronous operation fails, Network Firewall populates this with
    /// the reason for the error or failure. Options include `Flow operation error`
    /// and `Flow timeout`.
    status_message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a VPC endpoint association.
    vpc_endpoint_association_arn: ?[]const u8 = null,

    /// A unique identifier for the primary endpoint associated with a firewall.
    vpc_endpoint_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .firewall_arn = "FirewallArn",
        .flow_operation = "FlowOperation",
        .flow_operation_id = "FlowOperationId",
        .flow_operation_status = "FlowOperationStatus",
        .flow_operation_type = "FlowOperationType",
        .flow_request_timestamp = "FlowRequestTimestamp",
        .status_message = "StatusMessage",
        .vpc_endpoint_association_arn = "VpcEndpointAssociationArn",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFlowOperationInput, options: Options) !DescribeFlowOperationOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeFlowOperationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkfirewall", "Network Firewall", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "NetworkFirewall_20201112.DescribeFlowOperation");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeFlowOperationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFlowOperationOutput, body, alloc);
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
