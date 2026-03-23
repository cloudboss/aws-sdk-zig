const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const EngineType = @import("engine_type.zig").EngineType;
const HighAvailabilityConfig = @import("high_availability_config.zig").HighAvailabilityConfig;
const NetworkType = @import("network_type.zig").NetworkType;
const PendingMaintenance = @import("pending_maintenance.zig").PendingMaintenance;
const EnvironmentLifecycle = @import("environment_lifecycle.zig").EnvironmentLifecycle;
const StorageConfiguration = @import("storage_configuration.zig").StorageConfiguration;

pub const GetEnvironmentInput = struct {
    /// The unique identifier of the runtime environment.
    environment_id: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
    };
};

pub const GetEnvironmentOutput = struct {
    /// The number of instances included in the runtime environment. A standalone
    /// runtime
    /// environment has a maximum of one instance. Currently, a high availability
    /// runtime
    /// environment has a maximum of two instances.
    actual_capacity: ?i32 = null,

    /// The timestamp when the runtime environment was created.
    creation_time: i64,

    /// The description of the runtime environment.
    description: ?[]const u8 = null,

    /// The target platform for the runtime environment.
    engine_type: EngineType,

    /// The version of the runtime engine.
    engine_version: []const u8,

    /// The Amazon Resource Name (ARN) of the runtime environment.
    environment_arn: []const u8,

    /// The unique identifier of the runtime environment.
    environment_id: []const u8,

    /// The desired capacity of the high availability configuration for the runtime
    /// environment.
    high_availability_config: ?HighAvailabilityConfig = null,

    /// The type of instance underlying the runtime environment.
    instance_type: []const u8,

    /// The identifier of a customer managed key.
    kms_key_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the load balancer used with the runtime
    /// environment.
    load_balancer_arn: ?[]const u8 = null,

    /// The name of the runtime environment. Must be unique within the account.
    name: []const u8,

    /// The network type supported by the runtime environment.
    network_type: ?NetworkType = null,

    /// Indicates the pending maintenance scheduled on this environment.
    pending_maintenance: ?PendingMaintenance = null,

    /// The maintenance window for the runtime environment. If you don't
    /// provide a value for the maintenance window, the service assigns a random
    /// value.
    preferred_maintenance_window: ?[]const u8 = null,

    /// Whether applications running in this runtime environment are publicly
    /// accessible.
    publicly_accessible: ?bool = null,

    /// The unique identifiers of the security groups assigned to this runtime
    /// environment.
    security_group_ids: ?[]const []const u8 = null,

    /// The status of the runtime environment. If the Amazon Web Services Mainframe
    /// Modernization environment is missing a connection to
    /// the customer owned dependent resource, the status will be `Unhealthy`.
    status: EnvironmentLifecycle,

    /// The reason for the reported status.
    status_reason: ?[]const u8 = null,

    /// The storage configurations defined for the runtime environment.
    storage_configurations: ?[]const StorageConfiguration = null,

    /// The unique identifiers of the subnets assigned to this runtime environment.
    subnet_ids: ?[]const []const u8 = null,

    /// The tags defined for this runtime environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The unique identifier for the VPC used with this runtime environment.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .actual_capacity = "actualCapacity",
        .creation_time = "creationTime",
        .description = "description",
        .engine_type = "engineType",
        .engine_version = "engineVersion",
        .environment_arn = "environmentArn",
        .environment_id = "environmentId",
        .high_availability_config = "highAvailabilityConfig",
        .instance_type = "instanceType",
        .kms_key_id = "kmsKeyId",
        .load_balancer_arn = "loadBalancerArn",
        .name = "name",
        .network_type = "networkType",
        .pending_maintenance = "pendingMaintenance",
        .preferred_maintenance_window = "preferredMaintenanceWindow",
        .publicly_accessible = "publiclyAccessible",
        .security_group_ids = "securityGroupIds",
        .status = "status",
        .status_reason = "statusReason",
        .storage_configurations = "storageConfigurations",
        .subnet_ids = "subnetIds",
        .tags = "tags",
        .vpc_id = "vpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEnvironmentInput, options: CallOptions) !GetEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "m2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEnvironmentOutput {
    var result: GetEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetEnvironmentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExecutionTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .execution_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
