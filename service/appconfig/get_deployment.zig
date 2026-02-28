const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AppliedExtension = @import("applied_extension.zig").AppliedExtension;
const DeploymentEvent = @import("deployment_event.zig").DeploymentEvent;
const GrowthType = @import("growth_type.zig").GrowthType;
const DeploymentState = @import("deployment_state.zig").DeploymentState;

pub const GetDeploymentInput = struct {
    /// The ID of the application that includes the deployment you want to get.
    application_id: []const u8,

    /// The sequence number of the deployment.
    deployment_number: ?i32 = null,

    /// The ID of the environment that includes the deployment you want to get.
    environment_id: []const u8,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .deployment_number = "DeploymentNumber",
        .environment_id = "EnvironmentId",
    };
};

pub const GetDeploymentOutput = struct {
    /// The ID of the application that was deployed.
    application_id: ?[]const u8 = null,

    /// A list of extensions that were processed as part of the deployment. The
    /// extensions that
    /// were previously associated to the configuration profile, environment, or the
    /// application
    /// when `StartDeployment` was called.
    applied_extensions: ?[]const AppliedExtension = null,

    /// The time the deployment completed.
    completed_at: ?i64 = null,

    /// Information about the source location of the configuration.
    configuration_location_uri: ?[]const u8 = null,

    /// The name of the configuration.
    configuration_name: ?[]const u8 = null,

    /// The ID of the configuration profile that was deployed.
    configuration_profile_id: ?[]const u8 = null,

    /// The configuration version that was deployed.
    configuration_version: ?[]const u8 = null,

    /// Total amount of time the deployment lasted.
    deployment_duration_in_minutes: ?i32 = null,

    /// The sequence number of the deployment.
    deployment_number: ?i32 = null,

    /// The ID of the deployment strategy that was deployed.
    deployment_strategy_id: ?[]const u8 = null,

    /// The description of the deployment.
    description: ?[]const u8 = null,

    /// The ID of the environment that was deployed.
    environment_id: ?[]const u8 = null,

    /// A list containing all events related to a deployment. The most recent events
    /// are
    /// displayed first.
    event_log: ?[]const DeploymentEvent = null,

    /// The amount of time that AppConfig monitored for alarms before considering
    /// the
    /// deployment to be complete and no longer eligible for automatic rollback.
    final_bake_time_in_minutes: ?i32 = null,

    /// The percentage of targets to receive a deployed configuration during each
    /// interval.
    growth_factor: ?f32 = null,

    /// The algorithm used to define how percentage grew over time.
    growth_type: ?GrowthType = null,

    /// The Amazon Resource Name of the Key Management Service key used to encrypt
    /// configuration
    /// data. You can encrypt secrets stored in Secrets Manager, Amazon Simple
    /// Storage Service
    /// (Amazon S3) objects encrypted with SSE-KMS, or secure string parameters
    /// stored in Amazon Web Services Systems Manager
    /// Parameter Store.
    kms_key_arn: ?[]const u8 = null,

    /// The Key Management Service key identifier (key ID, key alias, or key ARN)
    /// provided when
    /// the resource was created or updated.
    kms_key_identifier: ?[]const u8 = null,

    /// The percentage of targets for which the deployment is available.
    percentage_complete: ?f32 = null,

    /// The time the deployment started.
    started_at: ?i64 = null,

    /// The state of the deployment.
    state: ?DeploymentState = null,

    /// A user-defined label for an AppConfig hosted configuration version.
    version_label: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .applied_extensions = "AppliedExtensions",
        .completed_at = "CompletedAt",
        .configuration_location_uri = "ConfigurationLocationUri",
        .configuration_name = "ConfigurationName",
        .configuration_profile_id = "ConfigurationProfileId",
        .configuration_version = "ConfigurationVersion",
        .deployment_duration_in_minutes = "DeploymentDurationInMinutes",
        .deployment_number = "DeploymentNumber",
        .deployment_strategy_id = "DeploymentStrategyId",
        .description = "Description",
        .environment_id = "EnvironmentId",
        .event_log = "EventLog",
        .final_bake_time_in_minutes = "FinalBakeTimeInMinutes",
        .growth_factor = "GrowthFactor",
        .growth_type = "GrowthType",
        .kms_key_arn = "KmsKeyArn",
        .kms_key_identifier = "KmsKeyIdentifier",
        .percentage_complete = "PercentageComplete",
        .started_at = "StartedAt",
        .state = "State",
        .version_label = "VersionLabel",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDeploymentInput, options: Options) !GetDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appconfig");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/applications/");
    try path_buf.appendSlice(alloc, input.application_id);
    try path_buf.appendSlice(alloc, "/environments/");
    try path_buf.appendSlice(alloc, input.environment_id);
    try path_buf.appendSlice(alloc, "/deployments/");
    try path_buf.appendSlice(alloc, input.deployment_number);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetDeploymentOutput {
    var result: GetDeploymentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDeploymentOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PayloadTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .payload_too_large_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
