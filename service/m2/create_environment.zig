const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EngineType = @import("engine_type.zig").EngineType;
const HighAvailabilityConfig = @import("high_availability_config.zig").HighAvailabilityConfig;
const NetworkType = @import("network_type.zig").NetworkType;
const StorageConfiguration = @import("storage_configuration.zig").StorageConfiguration;

pub const CreateEnvironmentInput = struct {
    /// Unique, case-sensitive identifier you provide to ensure the idempotency of
    /// the request
    /// to create an environment. The service generates the clientToken when the API
    /// call is
    /// triggered. The token expires after one hour, so if you retry the API within
    /// this timeframe
    /// with the same clientToken, you will get the same response. The service also
    /// handles
    /// deleting the clientToken after it expires.
    client_token: ?[]const u8 = null,

    /// The description of the runtime environment.
    description: ?[]const u8 = null,

    /// The engine type for the runtime environment.
    engine_type: EngineType,

    /// The version of the engine type for the runtime environment.
    engine_version: ?[]const u8 = null,

    /// The details of a high availability configuration for this runtime
    /// environment.
    high_availability_config: ?HighAvailabilityConfig = null,

    /// The type of instance for the runtime environment.
    instance_type: []const u8,

    /// The identifier of a customer managed key.
    kms_key_id: ?[]const u8 = null,

    /// The name of the runtime environment. Must be unique within the account.
    name: []const u8,

    /// The network type required for the runtime environment.
    network_type: ?NetworkType = null,

    /// Configures the maintenance window that you want for the runtime environment.
    /// The maintenance window must have the format `ddd:hh24:mi-ddd:hh24:mi` and
    /// must be less than 24 hours. The following two examples are valid maintenance
    /// windows: `sun:23:45-mon:00:15` or `sat:01:00-sat:03:00`.
    ///
    /// If you do not provide a value, a random system-generated value will be
    /// assigned.
    preferred_maintenance_window: ?[]const u8 = null,

    /// Specifies whether the runtime environment is publicly accessible.
    publicly_accessible: ?bool = null,

    /// The list of security groups for the VPC associated with this runtime
    /// environment.
    security_group_ids: ?[]const []const u8 = null,

    /// Optional. The storage configurations for this runtime environment.
    storage_configurations: ?[]const StorageConfiguration = null,

    /// The list of subnets associated with the VPC for this runtime environment.
    subnet_ids: ?[]const []const u8 = null,

    /// The tags for the runtime environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .engine_type = "engineType",
        .engine_version = "engineVersion",
        .high_availability_config = "highAvailabilityConfig",
        .instance_type = "instanceType",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .network_type = "networkType",
        .preferred_maintenance_window = "preferredMaintenanceWindow",
        .publicly_accessible = "publiclyAccessible",
        .security_group_ids = "securityGroupIds",
        .storage_configurations = "storageConfigurations",
        .subnet_ids = "subnetIds",
        .tags = "tags",
    };
};

pub const CreateEnvironmentOutput = struct {
    /// The unique identifier of the runtime environment.
    environment_id: []const u8,

    pub const json_field_names = .{
        .environment_id = "environmentId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentInput, options: CallOptions) !CreateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "m2", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/environments";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"engineType\":");
    try aws.json.writeValue(@TypeOf(input.engine_type), input.engine_type, allocator, &body_buf);
    has_prev = true;
    if (input.engine_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"engineVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.high_availability_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"highAvailabilityConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"instanceType\":");
    try aws.json.writeValue(@TypeOf(input.instance_type), input.instance_type, allocator, &body_buf);
    has_prev = true;
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.network_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"networkType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.preferred_maintenance_window) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"preferredMaintenanceWindow\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.publicly_accessible) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"publiclyAccessible\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.security_group_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"securityGroupIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.storage_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storageConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.subnet_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"subnetIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentOutput {
    const result: CreateEnvironmentOutput = try aws.json.parseJsonObject(
        CreateEnvironmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
