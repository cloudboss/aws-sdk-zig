const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DeploymentConfiguration = @import("deployment_configuration.zig").DeploymentConfiguration;
const GameSessionCreationLimitPolicy = @import("game_session_creation_limit_policy.zig").GameSessionCreationLimitPolicy;
const ConnectionPortRange = @import("connection_port_range.zig").ConnectionPortRange;
const IpPermission = @import("ip_permission.zig").IpPermission;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const ProtectionPolicy = @import("protection_policy.zig").ProtectionPolicy;
const ContainerFleetRemoveAttribute = @import("container_fleet_remove_attribute.zig").ContainerFleetRemoveAttribute;
const ContainerFleet = @import("container_fleet.zig").ContainerFleet;

pub const UpdateContainerFleetInput = struct {
    /// Instructions for how to deploy updates to a container fleet, if the fleet
    /// update
    /// initiates a deployment. The deployment configuration lets you determine how
    /// to replace
    /// fleet instances and what actions to take if the deployment fails.
    deployment_configuration: ?DeploymentConfiguration = null,

    /// A meaningful description of the container fleet.
    description: ?[]const u8 = null,

    /// A unique identifier for the container fleet to update. You can use either
    /// the fleet ID
    /// or ARN value.
    fleet_id: []const u8,

    /// The name or ARN value of a new game server container group definition to
    /// deploy on the
    /// fleet. If you're updating the fleet to a specific version of a container
    /// group
    /// definition, use the ARN value and include the version number. If you're
    /// updating the
    /// fleet to the latest version of a container group definition, you can use the
    /// name value.
    /// You can't remove a fleet's game server container group definition, you can
    /// only update
    /// or replace it with another definition.
    ///
    /// Update a container group definition by calling
    /// [UpdateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateContainerGroupDefinition.html).
    /// This operation creates a
    /// [ContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerGroupDefinition.html)
    /// resource with an incremented version.
    game_server_container_group_definition_name: ?[]const u8 = null,

    /// The number of times to replicate the game server container group on each
    /// fleet
    /// instance. By default, Amazon GameLift Servers calculates the maximum number
    /// of game server container
    /// groups that can fit on each instance. You can remove this property value to
    /// use the
    /// calculated value, or set it manually. If you set this number manually,
    /// Amazon GameLift Servers uses your
    /// value as long as it's less than the calculated maximum.
    game_server_container_groups_per_instance: ?i32 = null,

    /// A policy that limits the number of game sessions that each individual player
    /// can create
    /// on instances in this fleet. The limit applies for a specified span of time.
    game_session_creation_limit_policy: ?GameSessionCreationLimitPolicy = null,

    /// A revised set of port numbers to open on each fleet instance. By default,
    /// Amazon GameLift Servers
    /// calculates an optimal port range based on your fleet configuration. If you
    /// previously
    /// set this parameter manually, you can't reset this to use the calculated
    /// settings.
    instance_connection_port_range: ?ConnectionPortRange = null,

    /// A set of ports to add to the container fleet's inbound permissions.
    instance_inbound_permission_authorizations: ?[]const IpPermission = null,

    /// A set of ports to remove from the container fleet's inbound permissions.
    instance_inbound_permission_revocations: ?[]const IpPermission = null,

    /// The method for collecting container logs for the fleet.
    log_configuration: ?LogConfiguration = null,

    /// The name of an Amazon Web Services CloudWatch metric group to add this fleet
    /// to.
    metric_groups: ?[]const []const u8 = null,

    /// The game session protection policy to apply to all new game sessions that
    /// are started
    /// in this fleet. Game sessions that already exist are not affected.
    new_game_session_protection_policy: ?ProtectionPolicy = null,

    /// The name or ARN value of a new per-instance container group definition to
    /// deploy on
    /// the fleet. If you're updating the fleet to a specific version of a container
    /// group
    /// definition, use the ARN value and include the version number. If you're
    /// updating the
    /// fleet to the latest version of a container group definition, you can use the
    /// name
    /// value.
    ///
    /// Update a container group definition by calling
    /// [UpdateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateContainerGroupDefinition.html).
    /// This operation creates a
    /// [ContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerGroupDefinition.html)
    /// resource with an incremented version.
    ///
    /// To remove a fleet's per-instance container group definition, leave this
    /// parameter empty
    /// and use the parameter `RemoveAttributes`.
    per_instance_container_group_definition_name: ?[]const u8 = null,

    /// If set, this update removes a fleet's per-instance container group
    /// definition. You
    /// can't remove a fleet's game server container group definition.
    remove_attributes: ?[]const ContainerFleetRemoveAttribute = null,

    pub const json_field_names = .{
        .deployment_configuration = "DeploymentConfiguration",
        .description = "Description",
        .fleet_id = "FleetId",
        .game_server_container_group_definition_name = "GameServerContainerGroupDefinitionName",
        .game_server_container_groups_per_instance = "GameServerContainerGroupsPerInstance",
        .game_session_creation_limit_policy = "GameSessionCreationLimitPolicy",
        .instance_connection_port_range = "InstanceConnectionPortRange",
        .instance_inbound_permission_authorizations = "InstanceInboundPermissionAuthorizations",
        .instance_inbound_permission_revocations = "InstanceInboundPermissionRevocations",
        .log_configuration = "LogConfiguration",
        .metric_groups = "MetricGroups",
        .new_game_session_protection_policy = "NewGameSessionProtectionPolicy",
        .per_instance_container_group_definition_name = "PerInstanceContainerGroupDefinitionName",
        .remove_attributes = "RemoveAttributes",
    };
};

pub const UpdateContainerFleetOutput = struct {
    /// A collection of container fleet objects for all fleets that match the
    /// request
    /// criteria.
    container_fleet: ?ContainerFleet = null,

    pub const json_field_names = .{
        .container_fleet = "ContainerFleet",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContainerFleetInput, options: CallOptions) !UpdateContainerFleetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "gamelift");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateContainerFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.UpdateContainerFleet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateContainerFleetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateContainerFleetOutput, body, allocator);
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
