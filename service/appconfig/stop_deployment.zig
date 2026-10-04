const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppliedExtension = @import("applied_extension.zig").AppliedExtension;
const DeploymentEvent = @import("deployment_event.zig").DeploymentEvent;
const GrowthType = @import("growth_type.zig").GrowthType;
const DeploymentState = @import("deployment_state.zig").DeploymentState;

pub const StopDeploymentInput = struct {
    /// A Boolean that enables AppConfig to rollback a `COMPLETED`
    /// deployment to the previous configuration version. This action moves the
    /// deployment to a
    /// status of `REVERTED`.
    allow_revert: ?bool = null,

    /// The application ID.
    application_id: []const u8,

    /// The sequence number of the deployment.
    deployment_number: ?i32 = null,

    /// The environment ID.
    environment_id: []const u8,

    pub const json_field_names = .{
        .allow_revert = "AllowRevert",
        .application_id = "ApplicationId",
        .deployment_number = "DeploymentNumber",
        .environment_id = "EnvironmentId",
    };
};

pub const StopDeploymentOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StopDeploymentInput, options: CallOptions) !StopDeploymentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appconfig", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StopDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/deployments/");
    try path_buf.appendSlice(allocator, input.deployment_number);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.allow_revert) |v| {
        try request.headers.put(allocator, "Allow-Revert", if (v) "true" else "false");
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StopDeploymentOutput {
    var result: StopDeploymentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StopDeploymentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
