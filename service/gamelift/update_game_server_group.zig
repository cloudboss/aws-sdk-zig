const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const BalancingStrategy = @import("balancing_strategy.zig").BalancingStrategy;
const GameServerProtectionPolicy = @import("game_server_protection_policy.zig").GameServerProtectionPolicy;
const InstanceDefinition = @import("instance_definition.zig").InstanceDefinition;
const GameServerGroup = @import("game_server_group.zig").GameServerGroup;

pub const UpdateGameServerGroupInput = struct {
    /// Indicates how Amazon GameLift Servers FleetIQ balances the use of Spot
    /// Instances and On-Demand Instances in the
    /// game server group. Method options include the following:
    ///
    /// * `SPOT_ONLY` - Only Spot Instances are used in the game server group. If
    ///   Spot
    /// Instances are unavailable or not viable for game hosting, the game server
    /// group
    /// provides no hosting capacity until Spot Instances can again be used. Until
    /// then,
    /// no new instances are started, and the existing nonviable Spot Instances are
    /// terminated (after current gameplay ends) and are not replaced.
    ///
    /// * `SPOT_PREFERRED` - (default value) Spot Instances are used whenever
    ///   available in
    /// the game server group. If Spot Instances are unavailable, the game server
    /// group
    /// continues to provide hosting capacity by falling back to On-Demand
    /// Instances.
    /// Existing nonviable Spot Instances are terminated (after current gameplay
    /// ends)
    /// and are replaced with new On-Demand Instances.
    ///
    /// * `ON_DEMAND_ONLY` - Only On-Demand Instances are used in the game
    /// server group. No Spot Instances are used, even when available, while this
    /// balancing strategy is in force.
    balancing_strategy: ?BalancingStrategy = null,

    /// A unique identifier for the game server group. Use either the name or ARN
    /// value.
    game_server_group_name: []const u8,

    /// A flag that indicates whether instances in the game server group are
    /// protected
    /// from early termination. Unprotected instances that have active game servers
    /// running might
    /// be terminated during a scale-down event, causing players to be dropped from
    /// the game.
    /// Protected instances cannot be terminated while there are active game servers
    /// running except
    /// in the event of a forced game server group deletion (see ). An exception to
    /// this is with Spot
    /// Instances, which can be terminated by Amazon Web Services regardless of
    /// protection status. This property is set to `NO_PROTECTION` by default.
    game_server_protection_policy: ?GameServerProtectionPolicy = null,

    /// An updated list of Amazon EC2 instance types to use in the Auto Scaling
    /// group. The instance
    /// definitions must specify at least two different instance types that are
    /// supported by
    /// Amazon GameLift Servers FleetIQ. This updated list replaces the entire
    /// current list of instance definitions for
    /// the game server group. For more information on instance types, see [EC2
    /// Instance
    /// Types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) in the *Amazon EC2 User Guide*. You can optionally
    /// specify capacity weighting for each instance type. If no weight value is
    /// specified for
    /// an instance type, it is set to the default value "1". For more information
    /// about
    /// capacity weighting, see [ Instance Weighting for
    /// Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/autoscaling/ec2/userguide/asg-instance-weighting.html) in the Amazon EC2 Auto Scaling User Guide.
    instance_definitions: ?[]const InstanceDefinition = null,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// for an IAM role that
    /// allows Amazon GameLift Servers to access your Amazon EC2 Auto Scaling
    /// groups.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .balancing_strategy = "BalancingStrategy",
        .game_server_group_name = "GameServerGroupName",
        .game_server_protection_policy = "GameServerProtectionPolicy",
        .instance_definitions = "InstanceDefinitions",
        .role_arn = "RoleArn",
    };
};

pub const UpdateGameServerGroupOutput = struct {
    /// An object that describes the game server group resource with updated
    /// properties.
    game_server_group: ?GameServerGroup = null,

    pub const json_field_names = .{
        .game_server_group = "GameServerGroup",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGameServerGroupInput, options: Options) !UpdateGameServerGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "gamelift");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateGameServerGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "GameLift.UpdateGameServerGroup");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateGameServerGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateGameServerGroupOutput, body, alloc);
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
