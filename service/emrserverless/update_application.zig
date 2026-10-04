const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
const Application = @import("application.zig").Application;

pub const UpdateApplicationInput = struct {
    /// The ID of the application to update.
    application_id: []const u8,

    /// The CPU architecture of an application.
    architecture: ?Architecture = null,

    /// The configuration for an application to automatically start on job
    /// submission.
    auto_start_configuration: ?AutoStartConfig = null,

    /// The configuration for an application to automatically stop after a certain
    /// amount of time being idle.
    auto_stop_configuration: ?AutoStopConfig = null,

    /// The client idempotency token of the application to update. Its value must be
    /// unique for each request.
    client_token: []const u8,

    /// The configuration object that allows encrypting local disks.
    disk_encryption_configuration: ?DiskEncryptionConfiguration = null,

    /// Specifies the IAM Identity Center configuration used to enable or disable
    /// trusted identity propagation. When provided, this configuration determines
    /// how the application interacts with IAM Identity Center for user
    /// authentication and access control.
    identity_center_configuration: ?IdentityCenterConfigurationInput = null,

    /// The image configuration to be used for all worker types. You can either set
    /// this parameter or `imageConfiguration` for each worker type in
    /// `WorkerTypeSpecificationInput`.
    image_configuration: ?ImageConfigurationInput = null,

    /// The capacity to initialize when the application is updated.
    initial_capacity: ?[]const aws.map.MapEntry(InitialCapacityConfig) = null,

    /// The interactive configuration object that contains new interactive use cases
    /// when the application is updated.
    interactive_configuration: ?InteractiveConfiguration = null,

    /// The configuration object that enables job level cost allocation.
    job_level_cost_allocation_configuration: ?JobLevelCostAllocationConfiguration = null,

    /// The maximum capacity to allocate when the application is updated. This is
    /// cumulative across all workers at any given point in time during the lifespan
    /// of the application. No new resources will be created once any one of the
    /// defined limits is hit.
    maximum_capacity: ?MaximumAllowedResources = null,

    /// The configuration setting for monitoring.
    monitoring_configuration: ?MonitoringConfiguration = null,

    network_configuration: ?NetworkConfiguration = null,

    /// The Amazon EMR release label for the application. You can change the release
    /// label to use a different release of Amazon EMR.
    release_label: ?[]const u8 = null,

    /// The
    /// [Configuration](https://docs.aws.amazon.com/emr-serverless/latest/APIReference/API_Configuration.html) specifications to use when updating an application. Each configuration consists of a classification and properties. This configuration is applied across all the job runs submitted under the application.
    runtime_configuration: ?[]const Configuration = null,

    /// The scheduler configuration for batch and streaming jobs running on this
    /// application. Supported with release labels emr-7.0.0 and above.
    scheduler_configuration: ?SchedulerConfiguration = null,

    /// The key-value pairs that specify worker type to
    /// `WorkerTypeSpecificationInput`. This parameter must contain all valid worker
    /// types for a Spark or Hive application. Valid worker types include `Driver`
    /// and `Executor` for Spark applications and `HiveDriver` and `TezTask` for
    /// Hive applications. You can either set image details in this parameter for
    /// each worker type, or in `imageConfiguration` for all worker types.
    worker_type_specifications: ?[]const aws.map.MapEntry(WorkerTypeSpecificationInput) = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
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
        .network_configuration = "networkConfiguration",
        .release_label = "releaseLabel",
        .runtime_configuration = "runtimeConfiguration",
        .scheduler_configuration = "schedulerConfiguration",
        .worker_type_specifications = "workerTypeSpecifications",
    };
};

pub const UpdateApplicationOutput = struct {
    /// Information about the updated application.
    application: ?Application = null,

    pub const json_field_names = .{
        .application = "application",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApplicationInput, options: CallOptions) !UpdateApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "emr-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emr-serverless", "EMR Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
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
    if (input.network_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"networkConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.release_label) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"releaseLabel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.worker_type_specifications) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workerTypeSpecifications\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApplicationOutput {
    const result: UpdateApplicationOutput = try aws.json.parseJsonObject(
        UpdateApplicationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
