const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const SubnetGroup = @import("subnet_group.zig").SubnetGroup;

pub const UpdateSubnetGroupInput = struct {
    /// A description of the subnet group.
    description: ?[]const u8 = null,

    /// The name of the subnet group.
    subnet_group_name: []const u8,

    /// A list of subnet IDs in the subnet group.
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .subnet_group_name = "SubnetGroupName",
        .subnet_ids = "SubnetIds",
    };
};

pub const UpdateSubnetGroupOutput = struct {
    /// The subnet group that has been modified.
    subnet_group: ?SubnetGroup = null,

    pub const json_field_names = .{
        .subnet_group = "SubnetGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSubnetGroupInput, options: CallOptions) !UpdateSubnetGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dax", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSubnetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dax", "DAX", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDAXV3.UpdateSubnetGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSubnetGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateSubnetGroupOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ClusterAlreadyExistsFault")) {
        const parsed_error: ?errors.ClusterAlreadyExistsFault = aws.json.parseJsonObject(errors.ClusterAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cluster_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClusterNotFoundFault")) {
        const parsed_error: ?errors.ClusterNotFoundFault = aws.json.parseJsonObject(errors.ClusterNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cluster_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ClusterQuotaForCustomerExceededFault")) {
        const parsed_error: ?errors.ClusterQuotaForCustomerExceededFault = aws.json.parseJsonObject(errors.ClusterQuotaForCustomerExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cluster_quota_for_customer_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InsufficientClusterCapacityFault")) {
        const parsed_error: ?errors.InsufficientClusterCapacityFault = aws.json.parseJsonObject(errors.InsufficientClusterCapacityFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .insufficient_cluster_capacity_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidARNFault")) {
        const parsed_error: ?errors.InvalidARNFault = aws.json.parseJsonObject(errors.InvalidARNFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_arn_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidClusterStateFault")) {
        const parsed_error: ?errors.InvalidClusterStateFault = aws.json.parseJsonObject(errors.InvalidClusterStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_cluster_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        const parsed_error: ?errors.InvalidParameterCombinationException = aws.json.parseJsonObject(errors.InvalidParameterCombinationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterGroupStateFault")) {
        const parsed_error: ?errors.InvalidParameterGroupStateFault = aws.json.parseJsonObject(errors.InvalidParameterGroupStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_group_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        const parsed_error: ?errors.InvalidParameterValueException = aws.json.parseJsonObject(errors.InvalidParameterValueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnet")) {
        const parsed_error: ?errors.InvalidSubnet = aws.json.parseJsonObject(errors.InvalidSubnet, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_subnet = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidVPCNetworkStateFault")) {
        const parsed_error: ?errors.InvalidVPCNetworkStateFault = aws.json.parseJsonObject(errors.InvalidVPCNetworkStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_vpc_network_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NodeNotFoundFault")) {
        const parsed_error: ?errors.NodeNotFoundFault = aws.json.parseJsonObject(errors.NodeNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .node_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NodeQuotaForClusterExceededFault")) {
        const parsed_error: ?errors.NodeQuotaForClusterExceededFault = aws.json.parseJsonObject(errors.NodeQuotaForClusterExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .node_quota_for_cluster_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NodeQuotaForCustomerExceededFault")) {
        const parsed_error: ?errors.NodeQuotaForCustomerExceededFault = aws.json.parseJsonObject(errors.NodeQuotaForCustomerExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .node_quota_for_customer_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterGroupAlreadyExistsFault")) {
        const parsed_error: ?errors.ParameterGroupAlreadyExistsFault = aws.json.parseJsonObject(errors.ParameterGroupAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_group_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterGroupNotFoundFault")) {
        const parsed_error: ?errors.ParameterGroupNotFoundFault = aws.json.parseJsonObject(errors.ParameterGroupNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_group_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ParameterGroupQuotaExceededFault")) {
        const parsed_error: ?errors.ParameterGroupQuotaExceededFault = aws.json.parseJsonObject(errors.ParameterGroupQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .parameter_group_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceLinkedRoleNotFoundFault")) {
        const parsed_error: ?errors.ServiceLinkedRoleNotFoundFault = aws.json.parseJsonObject(errors.ServiceLinkedRoleNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_linked_role_not_found_fault = typed_error } };
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
    if (std.mem.eql(u8, error_code, "SubnetGroupAlreadyExistsFault")) {
        const parsed_error: ?errors.SubnetGroupAlreadyExistsFault = aws.json.parseJsonObject(errors.SubnetGroupAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_group_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetGroupInUseFault")) {
        const parsed_error: ?errors.SubnetGroupInUseFault = aws.json.parseJsonObject(errors.SubnetGroupInUseFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_group_in_use_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetGroupNotFoundFault")) {
        const parsed_error: ?errors.SubnetGroupNotFoundFault = aws.json.parseJsonObject(errors.SubnetGroupNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_group_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetGroupQuotaExceededFault")) {
        const parsed_error: ?errors.SubnetGroupQuotaExceededFault = aws.json.parseJsonObject(errors.SubnetGroupQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_group_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetInUse")) {
        const parsed_error: ?errors.SubnetInUse = aws.json.parseJsonObject(errors.SubnetInUse, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_in_use = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetNotAllowedFault")) {
        const parsed_error: ?errors.SubnetNotAllowedFault = aws.json.parseJsonObject(errors.SubnetNotAllowedFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_not_allowed_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SubnetQuotaExceededFault")) {
        const parsed_error: ?errors.SubnetQuotaExceededFault = aws.json.parseJsonObject(errors.SubnetQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .subnet_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagNotFoundFault")) {
        const parsed_error: ?errors.TagNotFoundFault = aws.json.parseJsonObject(errors.TagNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TagQuotaPerResourceExceeded")) {
        const parsed_error: ?errors.TagQuotaPerResourceExceeded = aws.json.parseJsonObject(errors.TagQuotaPerResourceExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .tag_quota_per_resource_exceeded = typed_error } };
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
