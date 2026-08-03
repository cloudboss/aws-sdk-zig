const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const SubnetGroup = @import("subnet_group.zig").SubnetGroup;

pub const DescribeSubnetGroupsInput = struct {
    /// The maximum number of records to include in the response. If more records
    /// exist than the specified MaxResults value, a token is included in the
    /// response so that the remaining results can be retrieved.
    max_results: ?i32 = null,

    /// An optional argument to pass in case the total number of records exceeds the
    /// value of MaxResults. If nextToken is returned, there are more results
    /// available. The value of nextToken is a unique pagination token for each
    /// page. Make the call again using the returned token to retrieve the next
    /// page. Keep all other arguments unchanged.
    next_token: ?[]const u8 = null,

    /// The name of the subnet group to return details for.
    subnet_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .subnet_group_name = "SubnetGroupName",
    };
};

pub const DescribeSubnetGroupsOutput = struct {
    /// An optional argument to pass in case the total number of records exceeds the
    /// value of MaxResults. If nextToken is returned, there are more results
    /// available. The value of nextToken is a unique pagination token for each
    /// page. Make the call again using the returned token to retrieve the next
    /// page. Keep all other arguments unchanged.
    next_token: ?[]const u8 = null,

    /// A list of subnet groups. Each element in the list contains detailed
    /// information about one group.
    subnet_groups: ?[]const SubnetGroup = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .subnet_groups = "SubnetGroups",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSubnetGroupsInput, options: CallOptions) !DescribeSubnetGroupsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "memorydb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSubnetGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("memory-db", "MemoryDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.DescribeSubnetGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSubnetGroupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSubnetGroupsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ACLAlreadyExistsFault")) {
        const parsed_error: ?errors.ACLAlreadyExistsFault = aws.json.parseJsonObject(errors.ACLAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .acl_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ACLNotFoundFault")) {
        const parsed_error: ?errors.ACLNotFoundFault = aws.json.parseJsonObject(errors.ACLNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .acl_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ACLQuotaExceededFault")) {
        const parsed_error: ?errors.ACLQuotaExceededFault = aws.json.parseJsonObject(errors.ACLQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .acl_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "APICallRateForCustomerExceededFault")) {
        const parsed_error: ?errors.APICallRateForCustomerExceededFault = aws.json.parseJsonObject(errors.APICallRateForCustomerExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .api_call_rate_for_customer_exceeded_fault = typed_error } };
        }
    }
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
    if (std.mem.eql(u8, error_code, "DefaultUserRequired")) {
        const parsed_error: ?errors.DefaultUserRequired = aws.json.parseJsonObject(errors.DefaultUserRequired, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .default_user_required = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "DuplicateUserNameFault")) {
        const parsed_error: ?errors.DuplicateUserNameFault = aws.json.parseJsonObject(errors.DuplicateUserNameFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .duplicate_user_name_fault = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InvalidACLStateFault")) {
        const parsed_error: ?errors.InvalidACLStateFault = aws.json.parseJsonObject(errors.InvalidACLStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_acl_state_fault = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InvalidCredentialsException")) {
        const parsed_error: ?errors.InvalidCredentialsException = aws.json.parseJsonObject(errors.InvalidCredentialsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_credentials_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidKMSKeyFault")) {
        const parsed_error: ?errors.InvalidKMSKeyFault = aws.json.parseJsonObject(errors.InvalidKMSKeyFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_kms_key_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidMultiRegionClusterStateFault")) {
        const parsed_error: ?errors.InvalidMultiRegionClusterStateFault = aws.json.parseJsonObject(errors.InvalidMultiRegionClusterStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_multi_region_cluster_state_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNodeStateFault")) {
        const parsed_error: ?errors.InvalidNodeStateFault = aws.json.parseJsonObject(errors.InvalidNodeStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_node_state_fault = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InvalidSnapshotStateFault")) {
        const parsed_error: ?errors.InvalidSnapshotStateFault = aws.json.parseJsonObject(errors.InvalidSnapshotStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_snapshot_state_fault = typed_error } };
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
    if (std.mem.eql(u8, error_code, "InvalidUserStateFault")) {
        const parsed_error: ?errors.InvalidUserStateFault = aws.json.parseJsonObject(errors.InvalidUserStateFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_user_state_fault = typed_error } };
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
    if (std.mem.eql(u8, error_code, "MultiRegionClusterAlreadyExistsFault")) {
        const parsed_error: ?errors.MultiRegionClusterAlreadyExistsFault = aws.json.parseJsonObject(errors.MultiRegionClusterAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .multi_region_cluster_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MultiRegionClusterNotFoundFault")) {
        const parsed_error: ?errors.MultiRegionClusterNotFoundFault = aws.json.parseJsonObject(errors.MultiRegionClusterNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .multi_region_cluster_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "MultiRegionParameterGroupNotFoundFault")) {
        const parsed_error: ?errors.MultiRegionParameterGroupNotFoundFault = aws.json.parseJsonObject(errors.MultiRegionParameterGroupNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .multi_region_parameter_group_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NoOperationFault")) {
        const parsed_error: ?errors.NoOperationFault = aws.json.parseJsonObject(errors.NoOperationFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .no_operation_fault = typed_error } };
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
    if (std.mem.eql(u8, error_code, "ReservedNodeAlreadyExistsFault")) {
        const parsed_error: ?errors.ReservedNodeAlreadyExistsFault = aws.json.parseJsonObject(errors.ReservedNodeAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .reserved_node_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeNotFoundFault")) {
        const parsed_error: ?errors.ReservedNodeNotFoundFault = aws.json.parseJsonObject(errors.ReservedNodeNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .reserved_node_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReservedNodeQuotaExceededFault")) {
        const parsed_error: ?errors.ReservedNodeQuotaExceededFault = aws.json.parseJsonObject(errors.ReservedNodeQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .reserved_node_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReservedNodesOfferingNotFoundFault")) {
        const parsed_error: ?errors.ReservedNodesOfferingNotFoundFault = aws.json.parseJsonObject(errors.ReservedNodesOfferingNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .reserved_nodes_offering_not_found_fault = typed_error } };
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
    if (std.mem.eql(u8, error_code, "ServiceUpdateNotFoundFault")) {
        const parsed_error: ?errors.ServiceUpdateNotFoundFault = aws.json.parseJsonObject(errors.ServiceUpdateNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_update_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ShardNotFoundFault")) {
        const parsed_error: ?errors.ShardNotFoundFault = aws.json.parseJsonObject(errors.ShardNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .shard_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ShardsPerClusterQuotaExceededFault")) {
        const parsed_error: ?errors.ShardsPerClusterQuotaExceededFault = aws.json.parseJsonObject(errors.ShardsPerClusterQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .shards_per_cluster_quota_exceeded_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SnapshotAlreadyExistsFault")) {
        const parsed_error: ?errors.SnapshotAlreadyExistsFault = aws.json.parseJsonObject(errors.SnapshotAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .snapshot_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SnapshotNotFoundFault")) {
        const parsed_error: ?errors.SnapshotNotFoundFault = aws.json.parseJsonObject(errors.SnapshotNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .snapshot_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "SnapshotQuotaExceededFault")) {
        const parsed_error: ?errors.SnapshotQuotaExceededFault = aws.json.parseJsonObject(errors.SnapshotQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .snapshot_quota_exceeded_fault = typed_error } };
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
    if (std.mem.eql(u8, error_code, "TestFailoverNotAvailableFault")) {
        const parsed_error: ?errors.TestFailoverNotAvailableFault = aws.json.parseJsonObject(errors.TestFailoverNotAvailableFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .test_failover_not_available_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UserAlreadyExistsFault")) {
        const parsed_error: ?errors.UserAlreadyExistsFault = aws.json.parseJsonObject(errors.UserAlreadyExistsFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .user_already_exists_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UserNotFoundFault")) {
        const parsed_error: ?errors.UserNotFoundFault = aws.json.parseJsonObject(errors.UserNotFoundFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .user_not_found_fault = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UserQuotaExceededFault")) {
        const parsed_error: ?errors.UserQuotaExceededFault = aws.json.parseJsonObject(errors.UserQuotaExceededFault, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .user_quota_exceeded_fault = typed_error } };
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
