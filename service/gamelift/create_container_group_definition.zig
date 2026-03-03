const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ContainerGroupType = @import("container_group_type.zig").ContainerGroupType;
const GameServerContainerDefinitionInput = @import("game_server_container_definition_input.zig").GameServerContainerDefinitionInput;
const ContainerOperatingSystem = @import("container_operating_system.zig").ContainerOperatingSystem;
const SupportContainerDefinitionInput = @import("support_container_definition_input.zig").SupportContainerDefinitionInput;
const Tag = @import("tag.zig").Tag;
const ContainerGroupDefinition = @import("container_group_definition.zig").ContainerGroupDefinition;

pub const CreateContainerGroupDefinitionInput = struct {
    /// The type of container group being defined. Container group type determines
    /// how Amazon GameLift Servers
    /// deploys the container group on each fleet instance.
    ///
    /// Default value: `GAME_SERVER`
    container_group_type: ?ContainerGroupType = null,

    /// The definition for the game server container in this group. Define a game
    /// server container
    /// only when the container group type is `GAME_SERVER`. Game server containers
    /// specify
    /// a container image with your game server build. You can pass in your
    /// container definitions as a
    /// JSON file.
    game_server_container_definition: ?GameServerContainerDefinitionInput = null,

    /// A descriptive identifier for the container group definition. The name value
    /// must be unique in an Amazon Web Services Region.
    name: []const u8,

    /// The platform that all containers in the group use. Containers in a group
    /// must run on the
    /// same operating system.
    ///
    /// Default value: `AMAZON_LINUX_2023`
    ///
    /// Amazon Linux 2 (AL2) will reach end of support on 6/30/2026. See more
    /// details in the [Amazon Linux 2
    /// FAQs](http://aws.amazon.com/amazon-linux-2/faqs/). For game
    /// servers that are hosted on AL2 and use server SDK version 4.x for Amazon
    /// GameLift Servers, first update the game
    /// server build to server SDK 5.x, and then deploy to AL2023 instances. See [
    /// Migrate to
    /// server SDK version
    /// 5.](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-serversdk5-migration.html)
    operating_system: ContainerOperatingSystem,

    /// One or more definition for support containers in this group. You can define
    /// a support
    /// container in any type of container group. You can pass in your container
    /// definitions as a JSON
    /// file.
    support_container_definitions: ?[]const SupportContainerDefinitionInput = null,

    /// A list of labels to assign to the container group definition resource. Tags
    /// are
    /// developer-defined key-value pairs. Tagging Amazon Web Services resources are
    /// useful for resource management,
    /// access management and cost allocation. For more information, see [ Tagging
    /// Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the
    /// *Amazon Web Services General Reference*.
    tags: ?[]const Tag = null,

    /// The maximum amount of memory (in MiB) to allocate to the container group.
    /// All containers in
    /// the group share this memory. If you specify memory limits for an individual
    /// container, the
    /// total value must be greater than any individual container's memory limit.
    ///
    /// Default value: 1024
    total_memory_limit_mebibytes: i32,

    /// The maximum amount of vCPU units to allocate to the container group (1 vCPU
    /// is equal to 1024
    /// CPU units). All containers in the group share this memory. If you specify
    /// vCPU limits for
    /// individual containers, the total value must be equal to or greater than the
    /// sum of the CPU
    /// limits for all containers in the group.
    ///
    /// Default value: 1
    total_vcpu_limit: f64,

    /// A description for the initial version of this container group definition.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_group_type = "ContainerGroupType",
        .game_server_container_definition = "GameServerContainerDefinition",
        .name = "Name",
        .operating_system = "OperatingSystem",
        .support_container_definitions = "SupportContainerDefinitions",
        .tags = "Tags",
        .total_memory_limit_mebibytes = "TotalMemoryLimitMebibytes",
        .total_vcpu_limit = "TotalVcpuLimit",
        .version_description = "VersionDescription",
    };
};

pub const CreateContainerGroupDefinitionOutput = struct {
    /// The properties of the new container group definition resource. You can use
    /// this resource to
    /// create a container fleet.
    container_group_definition: ?ContainerGroupDefinition = null,

    pub const json_field_names = .{
        .container_group_definition = "ContainerGroupDefinition",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContainerGroupDefinitionInput, options: CallOptions) !CreateContainerGroupDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateContainerGroupDefinitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.CreateContainerGroupDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateContainerGroupDefinitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateContainerGroupDefinitionOutput, body, allocator);
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
