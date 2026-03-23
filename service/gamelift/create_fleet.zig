const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AnywhereConfiguration = @import("anywhere_configuration.zig").AnywhereConfiguration;
const CertificateConfiguration = @import("certificate_configuration.zig").CertificateConfiguration;
const ComputeType = @import("compute_type.zig").ComputeType;
const IpPermission = @import("ip_permission.zig").IpPermission;
const EC2InstanceType = @import("ec2_instance_type.zig").EC2InstanceType;
const FleetType = @import("fleet_type.zig").FleetType;
const InstanceRoleCredentialsProvider = @import("instance_role_credentials_provider.zig").InstanceRoleCredentialsProvider;
const LocationConfiguration = @import("location_configuration.zig").LocationConfiguration;
const ProtectionPolicy = @import("protection_policy.zig").ProtectionPolicy;
const ResourceCreationLimitPolicy = @import("resource_creation_limit_policy.zig").ResourceCreationLimitPolicy;
const RuntimeConfiguration = @import("runtime_configuration.zig").RuntimeConfiguration;
const Tag = @import("tag.zig").Tag;
const FleetAttributes = @import("fleet_attributes.zig").FleetAttributes;
const LocationState = @import("location_state.zig").LocationState;

pub const CreateFleetInput = struct {
    /// Amazon GameLift Servers Anywhere configuration options.
    anywhere_configuration: ?AnywhereConfiguration = null,

    /// The unique identifier for a custom game server build to be deployed to a
    /// fleet with
    /// compute type `EC2`. You can use either the build ID or ARN. The build must
    /// be
    /// uploaded to Amazon GameLift Servers and in `READY` status. This fleet
    /// property can't be changed after the fleet is created.
    build_id: ?[]const u8 = null,

    /// Prompts Amazon GameLift Servers to generate a TLS/SSL certificate for the
    /// fleet. Amazon GameLift Servers uses the
    /// certificates to encrypt traffic between game clients and the game servers
    /// running on
    /// Amazon GameLift Servers. By default, the `CertificateConfiguration` is
    /// `DISABLED`.
    /// You can't change this property after you create the fleet.
    ///
    /// Certificate Manager (ACM) certificates expire after 13 months.
    /// Certificate expiration can cause fleets to fail, preventing players from
    /// connecting to
    /// instances in the fleet. We recommend you replace fleets before 13 months,
    /// consider using
    /// fleet aliases for a smooth transition.
    ///
    /// ACM isn't available in all Amazon Web Services regions. A fleet creation
    /// request
    /// with certificate generation enabled in an unsupported Region, fails with a
    /// 4xx
    /// error. For more information about the supported Regions, see [Supported
    /// Regions](https://docs.aws.amazon.com/acm/latest/userguide/acm-regions.html)
    /// in the *Certificate Manager User
    /// Guide*.
    certificate_configuration: ?CertificateConfiguration = null,

    /// The type of compute resource used to host your game servers.
    ///
    /// * `EC2` – The game server build is deployed to Amazon EC2 instances for
    /// cloud hosting. This is the default setting.
    ///
    /// * `ANYWHERE` – Game servers
    /// and supporting software are deployed to compute resources that you provide
    /// and
    /// manage. With this compute type, you can also set the
    /// `AnywhereConfiguration` parameter.
    compute_type: ?ComputeType = null,

    /// A description for the fleet.
    description: ?[]const u8 = null,

    /// The IP address ranges and port settings that allow inbound traffic to access
    /// game
    /// server processes and other processes on this fleet. Set this parameter for
    /// managed EC2 fleets. You can leave this parameter empty when creating the
    /// fleet, but you must call
    /// [https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateFleetPortSettings](https://docs.aws.amazon.com/gamelift/latest/apireference/API_UpdateFleetPortSettings) to set it before players can connect to game sessions.
    /// As a best practice, we recommend
    /// opening ports for remote access only when you need them and closing them
    /// when you're finished.
    /// For Amazon GameLift Servers Realtime fleets, Amazon GameLift Servers
    /// automatically sets TCP and UDP ranges.
    ec2_inbound_permissions: ?[]const IpPermission = null,

    /// The Amazon GameLift Servers-supported Amazon EC2 instance type to use with
    /// managed EC2 fleets.
    /// Instance type determines the computing resources that will be used to host
    /// your game
    /// servers, including CPU, memory, storage, and networking capacity. See
    /// [Amazon Elastic Compute Cloud Instance
    /// Types](http://aws.amazon.com/ec2/instance-types/) for
    /// detailed descriptions of Amazon EC2 instance types.
    ec2_instance_type: ?EC2InstanceType = null,

    /// Indicates whether to use On-Demand or Spot instances for this fleet. By
    /// default, this
    /// property is set to `ON_DEMAND`. Learn more about when to use [ On-Demand
    /// versus Spot
    /// Instances](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-ec2-instances.html#gamelift-ec2-instances-spot). This fleet property can't be changed after the fleet is created.
    fleet_type: ?FleetType = null,

    /// A unique identifier for an IAM role that manages access to your Amazon Web
    /// Services services.
    /// With an instance role ARN set, any application that runs on an instance in
    /// this fleet can assume the role,
    /// including install scripts, server processes, and daemons (background
    /// processes). Create a role or look up a role's
    /// ARN by using the [IAM dashboard](https://console.aws.amazon.com/iam/) in the
    /// Amazon Web Services Management Console.
    /// Learn more about using on-box credentials for your game servers at
    /// [
    /// Access external resources from a game
    /// server](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-server-resources.html). This fleet property can't be changed after the fleet is created.
    instance_role_arn: ?[]const u8 = null,

    /// Prompts Amazon GameLift Servers to generate a shared credentials file for
    /// the IAM role
    /// that's defined in `InstanceRoleArn`. The shared credentials file is stored
    /// on
    /// each fleet instance and refreshed as needed. Use shared credentials for
    /// applications
    /// that are deployed along with the game server executable, if the game server
    /// is
    /// integrated with server SDK version 5.x. For more information about using
    /// shared
    /// credentials, see [ Communicate
    /// with other Amazon Web Services resources from your
    /// fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-server-resources.html).
    instance_role_credentials_provider: ?InstanceRoleCredentialsProvider = null,

    /// A set of remote locations to deploy additional instances to and manage as a
    /// multi-location fleet. Use this parameter when creating a fleet in Amazon Web
    /// Services Regions that
    /// support multiple locations. You can add any Amazon Web Services Region or
    /// Local Zone that's supported
    /// by Amazon GameLift Servers. Provide a list of one or more Amazon Web
    /// Services Region codes, such as
    /// `us-west-2`, or Local Zone names. When using this parameter, Amazon GameLift
    /// Servers
    /// requires you to include your home location in the request. For a list of
    /// supported
    /// Regions and Local Zones, see
    /// [
    /// Amazon GameLift Servers service
    /// locations](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-regions.html) for managed hosting.
    locations: ?[]const LocationConfiguration = null,

    /// **This parameter is no longer used.** To specify where
    /// Amazon GameLift Servers should store log files once a server process shuts
    /// down, use the Amazon GameLift Servers server
    /// API `ProcessReady()` and specify one or more directory paths in
    /// `logParameters`. For more information, see [Initialize the server
    /// process](https://docs.aws.amazon.com/gamelift/latest/developerguide/gamelift-sdk-server-api.html#gamelift-sdk-server-initialize) in the *Amazon GameLift Servers Developer
    /// Guide*.
    log_paths: ?[]const []const u8 = null,

    /// The name of an Amazon Web Services CloudWatch metric group to add this fleet
    /// to. A metric group is
    /// used to aggregate the metrics for multiple fleets. You can specify an
    /// existing metric
    /// group name or set a new name to create a new metric group. A fleet can be
    /// included in
    /// only one metric group at a time.
    metric_groups: ?[]const []const u8 = null,

    /// A descriptive label that is associated with a fleet. Fleet names do not need
    /// to be unique.
    name: []const u8,

    /// The status of termination protection for active game sessions on the fleet.
    /// By
    /// default, this property is set to `NoProtection`. You can also set game
    /// session protection for an individual game session by calling
    /// [UpdateGameSession](gamelift/latest/apireference/API_UpdateGameSession.html).
    ///
    /// * **NoProtection** - Game sessions can be terminated
    /// during active gameplay as a result of a scale-down event.
    ///
    /// * **FullProtection** - Game sessions in
    /// `ACTIVE` status cannot be terminated during a scale-down
    /// event.
    new_game_session_protection_policy: ?ProtectionPolicy = null,

    /// Used when peering your Amazon GameLift Servers fleet with a VPC, the unique
    /// identifier for the Amazon Web Services
    /// account that owns the VPC. You can find your account ID in the Amazon Web
    /// Services Management Console under account
    /// settings.
    peer_vpc_aws_account_id: ?[]const u8 = null,

    /// A unique identifier for a VPC with resources to be accessed by your Amazon
    /// GameLift Servers fleet. The
    /// VPC must be in the same Region as your fleet. To look up a VPC ID, use the
    /// [VPC Dashboard](https://console.aws.amazon.com/vpc/) in the Amazon Web
    /// Services Management Console.
    /// Learn more about VPC peering in [VPC Peering with Amazon GameLift Servers
    /// Fleets](https://docs.aws.amazon.com/gamelift/latest/developerguide/vpc-peering.html).
    peer_vpc_id: ?[]const u8 = null,

    /// A policy that limits the number of game sessions that an individual player
    /// can create
    /// on instances in this fleet within a specified span of time.
    resource_creation_limit_policy: ?ResourceCreationLimitPolicy = null,

    /// Instructions for how to launch and run server processes on the fleet. Set
    /// runtime
    /// configuration for managed EC2 fleets. For an Anywhere fleets, set this
    /// parameter only if the fleet is running the Amazon GameLift Servers Agent.
    /// The runtime configuration
    /// defines one or more server process configurations. Each server process
    /// identifies a game
    /// executable or Realtime script file and the number of processes to run
    /// concurrently.
    ///
    /// This parameter replaces the parameters `ServerLaunchPath` and
    /// `ServerLaunchParameters`, which are still supported for backward
    /// compatibility.
    runtime_configuration: ?RuntimeConfiguration = null,

    /// The unique identifier for a Realtime configuration script to be deployed to
    /// a fleet with
    /// compute type `EC2`. You can use either the script ID or ARN. Scripts must be
    /// uploaded to Amazon GameLift Servers prior to creating the fleet. This fleet
    /// property can't be changed after the fleet is created.
    script_id: ?[]const u8 = null,

    /// **This parameter is no longer used.** Specify server
    /// launch parameters using the `RuntimeConfiguration` parameter. Requests that
    /// use this parameter instead continue to be valid.
    server_launch_parameters: ?[]const u8 = null,

    /// **This parameter is no longer used.** Specify a server
    /// launch path using the `RuntimeConfiguration` parameter. Requests that use
    /// this parameter instead continue to be valid.
    server_launch_path: ?[]const u8 = null,

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
        .anywhere_configuration = "AnywhereConfiguration",
        .build_id = "BuildId",
        .certificate_configuration = "CertificateConfiguration",
        .compute_type = "ComputeType",
        .description = "Description",
        .ec2_inbound_permissions = "EC2InboundPermissions",
        .ec2_instance_type = "EC2InstanceType",
        .fleet_type = "FleetType",
        .instance_role_arn = "InstanceRoleArn",
        .instance_role_credentials_provider = "InstanceRoleCredentialsProvider",
        .locations = "Locations",
        .log_paths = "LogPaths",
        .metric_groups = "MetricGroups",
        .name = "Name",
        .new_game_session_protection_policy = "NewGameSessionProtectionPolicy",
        .peer_vpc_aws_account_id = "PeerVpcAwsAccountId",
        .peer_vpc_id = "PeerVpcId",
        .resource_creation_limit_policy = "ResourceCreationLimitPolicy",
        .runtime_configuration = "RuntimeConfiguration",
        .script_id = "ScriptId",
        .server_launch_parameters = "ServerLaunchParameters",
        .server_launch_path = "ServerLaunchPath",
        .tags = "Tags",
    };
};

pub const CreateFleetOutput = struct {
    /// The properties for the new fleet, including the current status. All fleets
    /// are placed
    /// in `NEW` status on creation.
    fleet_attributes: ?FleetAttributes = null,

    /// The fleet's locations and life-cycle status of each location. For new
    /// fleets, the
    /// status of all locations is set to `NEW`. During fleet creation, Amazon
    /// GameLift Servers
    /// updates each location status as instances are deployed there and prepared
    /// for game
    /// hosting. This list includes an entry for the fleet's home Region. For fleets
    /// with no
    /// remote locations, only one entry, representing the home Region, is returned.
    location_states: ?[]const LocationState = null,

    pub const json_field_names = .{
        .fleet_attributes = "FleetAttributes",
        .location_states = "LocationStates",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFleetInput, options: CallOptions) !CreateFleetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFleetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.CreateFleet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFleetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFleetOutput, body, allocator);
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
