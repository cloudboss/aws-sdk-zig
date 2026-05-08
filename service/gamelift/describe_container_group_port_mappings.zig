const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ContainerGroupType = @import("container_group_type.zig").ContainerGroupType;
const ContainerGroupPortMapping = @import("container_group_port_mapping.zig").ContainerGroupPortMapping;

pub const DescribeContainerGroupPortMappingsInput = struct {
    /// A unique identifier for the compute resource for which to retrieve port
    /// mappings. For a
    /// container fleet, a compute represents a game server container group running
    /// on a fleet
    /// instance. You can use either the compute name or ARN value.
    ///
    /// When `ContainerGroupType` is `GAME_SERVER`, this parameter is
    /// required.
    ///
    /// When `ContainerGroupType` is `PER_INSTANCE`, do not provide
    /// this parameter. If you provide a compute name with `PER_INSTANCE`, the
    /// request fails with an `InvalidRequestException`.
    compute_name: ?[]const u8 = null,

    /// The type of container group to retrieve port mappings for.
    ///
    /// * `GAME_SERVER` -- Get port mappings for a game server
    /// container group.
    ///
    /// * `PER_INSTANCE` -- Get port mappings for a per-instance
    /// container group.
    container_group_type: ContainerGroupType,

    /// A container name to filter the results. When provided, the operation returns
    /// port
    /// mappings for the specified container only. If no container with the
    /// specified name
    /// exists in the container group, the request fails with a
    /// `NotFoundException`.
    ///
    /// If not provided, the operation returns port mappings for all containers in
    /// the container
    /// group.
    container_name: ?[]const u8 = null,

    /// A unique identifier for the container fleet. You can use either the fleet ID
    /// or ARN
    /// value.
    fleet_id: []const u8,

    /// A unique identifier for the fleet instance to retrieve port mappings for.
    ///
    /// When `ContainerGroupType` is `PER_INSTANCE`, this parameter is
    /// required.
    ///
    /// When `ContainerGroupType` is `GAME_SERVER`, this parameter is
    /// optional. If you provide an instance ID, it must match the instance that's
    /// running the
    /// specified compute. If the instance ID doesn't match, the request fails with
    /// an
    /// `InvalidRequestException`.
    instance_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .compute_name = "ComputeName",
        .container_group_type = "ContainerGroupType",
        .container_name = "ContainerName",
        .fleet_id = "FleetId",
        .instance_id = "InstanceId",
    };
};

pub const DescribeContainerGroupPortMappingsOutput = struct {
    /// A unique identifier for the compute resource running the game server
    /// container group.
    /// Returned when `ContainerGroupType` is `GAME_SERVER`.
    compute_name: ?[]const u8 = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to the container group definition. The ARN value also
    /// identifies the specific container group definition version in use.
    container_group_definition_arn: ?[]const u8 = null,

    /// A list of `ContainerGroupPortMapping` objects that describe the port
    /// mappings for each container in the container group.
    container_group_port_mappings: ?[]const ContainerGroupPortMapping = null,

    /// The type of container group that was specified in the request. Valid values
    /// are `GAME_SERVER` or `PER_INSTANCE`.
    container_group_type: ?ContainerGroupType = null,

    /// A unique identifier for the container fleet.
    fleet_id: ?[]const u8 = null,

    /// A unique identifier for the fleet instance. For `GAME_SERVER` requests,
    /// this is the instance running the specified compute. For `PER_INSTANCE`
    /// requests, this is the instance specified in the request.
    instance_id: ?[]const u8 = null,

    /// The location of the fleet instance, expressed as an Amazon Web Services
    /// Region code, such as
    /// `us-west-2`.
    location: ?[]const u8 = null,

    pub const json_field_names = .{
        .compute_name = "ComputeName",
        .container_group_definition_arn = "ContainerGroupDefinitionArn",
        .container_group_port_mappings = "ContainerGroupPortMappings",
        .container_group_type = "ContainerGroupType",
        .fleet_id = "FleetId",
        .instance_id = "InstanceId",
        .location = "Location",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeContainerGroupPortMappingsInput, options: CallOptions) !DescribeContainerGroupPortMappingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeContainerGroupPortMappingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.DescribeContainerGroupPortMappings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeContainerGroupPortMappingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeContainerGroupPortMappingsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FleetCapacityExceededException")) {
        return .{ .arena = arena, .kind = .{ .fleet_capacity_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GameSessionFullException")) {
        return .{ .arena = arena, .kind = .{ .game_session_full_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        return .{ .arena = arena, .kind = .{ .internal_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFleetStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_fleet_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGameSessionStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_game_session_status_exception = .{
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotReadyException")) {
        return .{ .arena = arena, .kind = .{ .not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OutOfCapacityException")) {
        return .{ .arena = arena, .kind = .{ .out_of_capacity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TaggingFailedException")) {
        return .{ .arena = arena, .kind = .{ .tagging_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TerminalRoutingStrategyException")) {
        return .{ .arena = arena, .kind = .{ .terminal_routing_strategy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedRegionException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_region_exception = .{
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
