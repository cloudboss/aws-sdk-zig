const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ContainerFleetBillingType = @import("container_fleet_billing_type.zig").ContainerFleetBillingType;
const GameSessionCreationLimitPolicy = @import("game_session_creation_limit_policy.zig").GameSessionCreationLimitPolicy;
const ConnectionPortRange = @import("connection_port_range.zig").ConnectionPortRange;
const IpPermission = @import("ip_permission.zig").IpPermission;
const LocationConfiguration = @import("location_configuration.zig").LocationConfiguration;
const LogConfiguration = @import("log_configuration.zig").LogConfiguration;
const ProtectionPolicy = @import("protection_policy.zig").ProtectionPolicy;
const Tag = @import("tag.zig").Tag;
const ContainerFleet = @import("container_fleet.zig").ContainerFleet;

pub const CreateContainerFleetInput = struct {
    /// Indicates whether to use On-Demand or Spot instances for this fleet. Learn
    /// more about
    /// when to use [ On-Demand versus Spot
    /// Instances](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-ec2-instances.html#gamelift-ec2-instances-spot). This fleet property can't be changed after the fleet is created.
    ///
    /// By default, this property is set to `ON_DEMAND`.
    ///
    /// You can't update this fleet property later.
    billing_type: ?ContainerFleetBillingType = null,

    /// A meaningful description of the container fleet.
    description: ?[]const u8 = null,

    /// The unique identifier for an Identity and Access Management (IAM) role with
    /// permissions to run your
    /// containers on resources that are managed by Amazon GameLift Servers. Use an
    /// IAM service role with the
    /// `GameLiftContainerFleetPolicy` managed policy attached. For more
    /// information, see [Set up an IAM service
    /// role](https://docs.aws.amazon.com/gamelift/latest/developerguide/setting-up-role.html). You can't change this fleet property after the fleet is
    /// created.
    ///
    /// IAM role ARN values use the following pattern: `arn:aws:iam::[Amazon Web
    /// Services account]:role/[role name]`.
    fleet_role_arn: []const u8,

    /// A container group definition resource that describes how to deploy
    /// containers with
    /// your game server build and support software onto each fleet instance. You
    /// can specify
    /// the container group definition's name to use the latest version.
    /// Alternatively, provide
    /// an ARN value with a specific version number.
    ///
    /// Create a container group definition by calling
    /// [CreateContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_CreateContainerGroupDefinition.html).
    /// This operation creates a
    /// [ContainerGroupDefinition](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerGroupDefinition.html) resource.
    game_server_container_group_definition_name: ?[]const u8 = null,

    /// The number of times to replicate the game server container group on each
    /// fleet
    /// instance.
    ///
    /// By default, Amazon GameLift Servers calculates the maximum number of game
    /// server container groups that
    /// can fit on each instance. This calculation is based on the CPU and memory
    /// resources of
    /// the fleet's instance type). To use the calculated maximum, don't set this
    /// parameter. If
    /// you set this number manually, Amazon GameLift Servers uses your value as
    /// long as it's less than the
    /// calculated maximum.
    game_server_container_groups_per_instance: ?i32 = null,

    /// A policy that limits the number of game sessions that each individual player
    /// can create
    /// on instances in this fleet. The limit applies for a specified span of time.
    game_session_creation_limit_policy: ?GameSessionCreationLimitPolicy = null,

    /// The set of port numbers to open on each fleet instance. A fleet's connection
    /// ports map
    /// to container ports that are configured in the fleet's container group
    /// definitions.
    ///
    /// By default, Amazon GameLift Servers calculates an optimal port range based
    /// on your fleet
    /// configuration. To use the calculated range, don't set this parameter. The
    /// values
    /// are:
    ///
    /// * Port range: 4192 to a number calculated based on your fleet configuration.
    /// Amazon GameLift Servers uses the following formula: `4192 + [# of game
    /// server container
    /// groups per fleet instance] * [# of container ports in the game server
    /// container group definition] + [# of container ports in the game server
    /// container group definition]`
    ///
    /// You can also choose to manually set this parameter. When manually setting
    /// this
    /// parameter, you must use port numbers that match the fleet's inbound
    /// permissions port
    /// range.
    ///
    /// If you set values manually, Amazon GameLift Servers no longer calculates a
    /// port range for you,
    /// even if you later remove the manual settings.
    instance_connection_port_range: ?ConnectionPortRange = null,

    /// The IP address ranges and port settings that allow inbound traffic to access
    /// game
    /// server processes and other processes on this fleet. As a best practice, when
    /// remotely
    /// accessing a fleet instance, we recommend opening ports only when you need
    /// them and
    /// closing them when you're finished.
    ///
    /// By default, Amazon GameLift Servers calculates an optimal port range based
    /// on your fleet
    /// configuration. To use the calculated range, don't set this parameter. The
    /// values
    /// are:
    ///
    /// * Protocol: UDP
    ///
    /// * Port range: 4192 to a number calculated based on your fleet configuration.
    ///   Amazon GameLift Servers uses the
    /// following formula: `4192 + [# of game server container groups per fleet
    /// instance] * [# of container ports in the game server container group
    /// definition] + [# of container ports in the game server container group
    /// definition]`
    ///
    /// You can also choose to manually set this parameter. When manually setting
    /// this
    /// parameter, you must use port numbers that match the fleet's connection port
    /// range.
    ///
    /// If you set values manually, Amazon GameLift Servers no longer calculates a
    /// port range for you,
    /// even if you later remove the manual settings.
    instance_inbound_permissions: ?[]const IpPermission = null,

    /// The Amazon EC2 instance type to use for all instances in the fleet. For
    /// multi-location
    /// fleets, the instance type must be available in the home region and all
    /// remote locations.
    /// Instance type determines the computing resources and processing power that's
    /// available
    /// to host your game servers. This includes including CPU, memory, storage, and
    /// networking
    /// capacity.
    ///
    /// By default, Amazon GameLift Servers selects an instance type that fits the
    /// needs of your container
    /// groups and is available in all selected fleet locations. You can also choose
    /// to manually
    /// set this parameter. See [Amazon Elastic Compute Cloud
    /// Instance Types](http://aws.amazon.com/ec2/instance-types/) for detailed
    /// descriptions of Amazon EC2 instance types.
    ///
    /// You can't update this fleet property later.
    instance_type: ?[]const u8 = null,

    /// A set of locations to deploy container fleet instances to. You can add any
    /// Amazon Web Services
    /// Region or Local Zone that's supported by Amazon GameLift Servers. Provide a
    /// list of one or more Amazon Web Services
    /// Region codes, such as `us-west-2`, or Local Zone names. Also include the
    /// fleet's home Region, which is the Amazon Web Services Region where the fleet
    /// is created. For a list of
    /// supported Regions and Local Zones, see [ Amazon GameLift Servers service
    /// locations](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-regions.html) for managed hosting.
    locations: ?[]const LocationConfiguration = null,

    /// A method for collecting container logs for the fleet. Amazon GameLift
    /// Servers saves all standard
    /// output for each container in logs, including game session logs. You can
    /// select from the
    /// following methods:
    ///
    /// * `CLOUDWATCH` -- Send logs to an Amazon CloudWatch log group that you
    ///   define. Each container
    /// emits a log stream, which is organized in the log group.
    ///
    /// * `S3` -- Store logs in an Amazon S3 bucket that you define.
    ///
    /// * `NONE` -- Don't collect container logs.
    ///
    /// By default, this property is set to `CLOUDWATCH`.
    ///
    /// Amazon GameLift Servers requires permissions to send logs other Amazon Web
    /// Services services in your account. These permissions are included in the IAM
    /// fleet role for this container fleet (see `FleetRoleArn)`.
    log_configuration: ?LogConfiguration = null,

    /// The name of an Amazon Web Services CloudWatch metric group to add this fleet
    /// to. You can use a metric group
    /// to aggregate metrics for multiple fleets. You can specify an existing metric
    /// group name or use a new name to create a new metric group. Each fleet can
    /// have only one metric group,
    /// but you can change this value at any time.
    metric_groups: ?[]const []const u8 = null,

    /// Determines whether Amazon GameLift Servers can shut down game sessions on
    /// the fleet that are actively
    /// running and hosting players. Amazon GameLift Servers might prompt an
    /// instance shutdown when scaling down
    /// fleet capacity or when retiring unhealthy instances. You can also set game
    /// session
    /// protection for individual game sessions using
    /// [UpdateGameSession](gamelift/latest/apireference/API_UpdateGameSession.html).
    ///
    /// * **NoProtection** -- Game sessions can be shut down
    /// during active gameplay.
    ///
    /// * **FullProtection** -- Game sessions in
    /// `ACTIVE` status can't be shut down.
    ///
    /// By default, this property is set to `NoProtection`.
    new_game_session_protection_policy: ?ProtectionPolicy = null,

    /// The name of a container group definition resource that describes a set of
    /// axillary
    /// software. A fleet instance has one process for executables in this container
    /// group. A
    /// per-instance container group is optional. You can update the fleet to add or
    /// remove a
    /// per-instance container group at any time. You can specify the container
    /// group
    /// definition's name to use the latest version. Alternatively, provide an ARN
    /// value with a
    /// specific version number.
    ///
    /// Create a container group definition by calling
    /// [https://docs.aws.amazon.com/gamelift/latest/apireference/API_CreateContainerGroupDefinition.html](https://docs.aws.amazon.com/gamelift/latest/apireference/API_CreateContainerGroupDefinition.html).
    /// This operation creates a
    /// [https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerGroupDefinition.html](https://docs.aws.amazon.com/gamelift/latest/apireference/API_ContainerGroupDefinition.html) resource.
    per_instance_container_group_definition_name: ?[]const u8 = null,

    /// A list of labels to assign to the new fleet resource. Tags are
    /// developer-defined
    /// key-value pairs. Tagging Amazon Web Services resources are useful for
    /// resource management, access
    /// management and cost allocation. For more information, see [ Tagging Amazon
    /// Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the
    /// *Amazon Web Services General Reference*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .billing_type = "BillingType",
        .description = "Description",
        .fleet_role_arn = "FleetRoleArn",
        .game_server_container_group_definition_name = "GameServerContainerGroupDefinitionName",
        .game_server_container_groups_per_instance = "GameServerContainerGroupsPerInstance",
        .game_session_creation_limit_policy = "GameSessionCreationLimitPolicy",
        .instance_connection_port_range = "InstanceConnectionPortRange",
        .instance_inbound_permissions = "InstanceInboundPermissions",
        .instance_type = "InstanceType",
        .locations = "Locations",
        .log_configuration = "LogConfiguration",
        .metric_groups = "MetricGroups",
        .new_game_session_protection_policy = "NewGameSessionProtectionPolicy",
        .per_instance_container_group_definition_name = "PerInstanceContainerGroupDefinitionName",
        .tags = "Tags",
    };
};

pub const CreateContainerFleetOutput = struct {
    /// The properties for the new container fleet, including current status. All
    /// fleets are
    /// initially placed in `PENDING` status.
    container_fleet: ?ContainerFleet = null,

    pub const json_field_names = .{
        .container_fleet = "ContainerFleet",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContainerFleetInput, options: Options) !CreateContainerFleetOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateContainerFleetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.CreateContainerFleet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateContainerFleetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateContainerFleetOutput, body, allocator);
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
