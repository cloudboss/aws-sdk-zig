const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Architecture = @import("architecture.zig").Architecture;
const AutoStartConfig = @import("auto_start_config.zig").AutoStartConfig;
const AutoStopConfig = @import("auto_stop_config.zig").AutoStopConfig;
const DiskEncryptionConfiguration = @import("disk_encryption_configuration.zig").DiskEncryptionConfiguration;
const IdentityCenterConfigurationInput = @import("identity_center_configuration_input.zig").IdentityCenterConfigurationInput;
const ImageConfigurationInput = @import("image_configuration_input.zig").ImageConfigurationInput;
const InitialCapacityConfig = @import("initial_capacity_config.zig").InitialCapacityConfig;
const InteractiveConfiguration = @import("interactive_configuration.zig").InteractiveConfiguration;
const JobLevelCostAllocationConfiguration = @import("job_level_cost_allocation_configuration.zig").JobLevelCostAllocationConfiguration;
const MaximumAllowedResources = @import("maximum_allowed_resources.zig").MaximumAllowedResources;
const MonitoringConfiguration = @import("monitoring_configuration.zig").MonitoringConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const Configuration = @import("configuration.zig").Configuration;
const SchedulerConfiguration = @import("scheduler_configuration.zig").SchedulerConfiguration;
const WorkerTypeSpecificationInput = @import("worker_type_specification_input.zig").WorkerTypeSpecificationInput;

pub const CreateApplicationInput = struct {
    /// The CPU architecture of an application.
    architecture: ?Architecture = null,

    /// The configuration for an application to automatically start on job
    /// submission.
    auto_start_configuration: ?AutoStartConfig = null,

    /// The configuration for an application to automatically stop after a certain
    /// amount of time being idle.
    auto_stop_configuration: ?AutoStopConfig = null,

    /// The client idempotency token of the application to create. Its value must be
    /// unique for each request.
    client_token: []const u8,

    /// The configuration object that allows encrypting local disks.
    disk_encryption_configuration: ?DiskEncryptionConfiguration = null,

    /// The IAM Identity Center Configuration accepts the Identity Center instance
    /// parameter required to enable trusted identity propagation. This
    /// configuration allows identity propagation between integrated services and
    /// the Identity Center instance.
    identity_center_configuration: ?IdentityCenterConfigurationInput = null,

    /// The image configuration for all worker types. You can either set this
    /// parameter or `imageConfiguration` for each worker type in
    /// `workerTypeSpecifications`.
    image_configuration: ?ImageConfigurationInput = null,

    /// The capacity to initialize when the application is created.
    initial_capacity: ?[]const aws.map.MapEntry(InitialCapacityConfig) = null,

    /// The interactive configuration object that enables the interactive use cases
    /// to use when running an application.
    interactive_configuration: ?InteractiveConfiguration = null,

    /// The configuration object that enables job level cost allocation.
    job_level_cost_allocation_configuration: ?JobLevelCostAllocationConfiguration = null,

    /// The maximum capacity to allocate when the application is created. This is
    /// cumulative across all workers at any given point in time, not just when an
    /// application is created. No new resources will be created once any one of the
    /// defined limits is hit.
    maximum_capacity: ?MaximumAllowedResources = null,

    /// The configuration setting for monitoring.
    monitoring_configuration: ?MonitoringConfiguration = null,

    /// The name of the application.
    name: ?[]const u8 = null,

    /// The network configuration for customer VPC connectivity.
    network_configuration: ?NetworkConfiguration = null,

    /// The Amazon EMR release associated with the application.
    release_label: []const u8,

    /// The
    /// [Configuration](https://docs.aws.amazon.com/emr-serverless/latest/APIReference/API_Configuration.html) specifications to use when creating an application. Each configuration consists of a classification and properties. This configuration is applied to all the job runs submitted under the application.
    runtime_configuration: ?[]const Configuration = null,

    /// The scheduler configuration for batch and streaming jobs running on this
    /// application. Supported with release labels emr-7.0.0 and above.
    scheduler_configuration: ?SchedulerConfiguration = null,

    /// The tags assigned to the application.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of application you want to start, such as Spark or Hive.
    @"type": []const u8,

    /// The key-value pairs that specify worker type to
    /// `WorkerTypeSpecificationInput`. This parameter must contain all valid worker
    /// types for a Spark or Hive application. Valid worker types include `Driver`
    /// and `Executor` for Spark applications and `HiveDriver` and `TezTask` for
    /// Hive applications. You can either set image details in this parameter for
    /// each worker type, or in `imageConfiguration` for all worker types.
    worker_type_specifications: ?[]const aws.map.MapEntry(WorkerTypeSpecificationInput) = null,

    pub const json_field_names = .{
        .architecture = "architecture",
        .auto_start_configuration = "autoStartConfiguration",
        .auto_stop_configuration = "autoStopConfiguration",
        .client_token = "clientToken",
        .disk_encryption_configuration = "diskEncryptionConfiguration",
        .identity_center_configuration = "identityCenterConfiguration",
        .image_configuration = "imageConfiguration",
        .initial_capacity = "initialCapacity",
        .interactive_configuration = "interactiveConfiguration",
        .job_level_cost_allocation_configuration = "jobLevelCostAllocationConfiguration",
        .maximum_capacity = "maximumCapacity",
        .monitoring_configuration = "monitoringConfiguration",
        .name = "name",
        .network_configuration = "networkConfiguration",
        .release_label = "releaseLabel",
        .runtime_configuration = "runtimeConfiguration",
        .scheduler_configuration = "schedulerConfiguration",
        .tags = "tags",
        .@"type" = "type",
        .worker_type_specifications = "workerTypeSpecifications",
    };
};

pub const CreateApplicationOutput = struct {
    /// The output contains the application ID.
    application_id: []const u8,

    /// The output contains the ARN of the application.
    arn: []const u8,

    /// The output contains the name of the application.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .arn = "arn",
        .name = "name",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApplicationInput, options: Options) !CreateApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "emrserverless");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emrserverless", "EMR Serverless", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/applications";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.architecture) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"architecture\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_start_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoStartConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_stop_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"autoStopConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.disk_encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"diskEncryptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.identity_center_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"identityCenterConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.image_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"imageConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.initial_capacity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"initialCapacity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.interactive_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"interactiveConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.job_level_cost_allocation_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"jobLevelCostAllocationConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maximum_capacity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maximumCapacity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.monitoring_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"monitoringConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.network_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"networkConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"releaseLabel\":");
    try aws.json.writeValue(@TypeOf(input.release_label), input.release_label, allocator, &body_buf);
    has_prev = true;
    if (input.runtime_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"runtimeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scheduler_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"schedulerConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;
    if (input.worker_type_specifications) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workerTypeSpecifications\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApplicationOutput {
    var result: CreateApplicationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateApplicationOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
