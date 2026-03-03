const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ComponentDeploymentSpecification = @import("component_deployment_specification.zig").ComponentDeploymentSpecification;
const DeploymentPolicies = @import("deployment_policies.zig").DeploymentPolicies;
const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;
const DeploymentIoTJobConfiguration = @import("deployment_io_t_job_configuration.zig").DeploymentIoTJobConfiguration;

pub const GetDeploymentInput = struct {
    /// The ID of the deployment.
    deployment_id: []const u8,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
    };
};

pub const GetDeploymentOutput = struct {
    /// The components to deploy. This is a dictionary, where each key is the name
    /// of a component,
    /// and each key's value is the version and configuration to deploy for that
    /// component.
    components: ?[]const aws.map.MapEntry(ComponentDeploymentSpecification) = null,

    /// The time at which the deployment was created, expressed in ISO 8601 format.
    creation_timestamp: ?i64 = null,

    /// The ID of the deployment.
    deployment_id: ?[]const u8 = null,

    /// The name of the deployment.
    deployment_name: ?[]const u8 = null,

    /// The deployment policies for the deployment. These policies define how the
    /// deployment
    /// updates components and handles failure.
    deployment_policies: ?DeploymentPolicies = null,

    /// The status of the deployment.
    deployment_status: ?DeploymentStatus = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the IoT job that applies the deployment to target devices.
    iot_job_arn: ?[]const u8 = null,

    /// The job configuration for the deployment configuration. The job
    /// configuration specifies
    /// the rollout, timeout, and stop configurations for the deployment
    /// configuration.
    iot_job_configuration: ?DeploymentIoTJobConfiguration = null,

    /// The ID of the IoT job that applies the deployment to target devices.
    iot_job_id: ?[]const u8 = null,

    /// Whether or not the deployment is the latest revision for its target.
    is_latest_for_target: ?bool = null,

    /// The parent deployment's target
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) within a subdeployment.
    parent_target_arn: ?[]const u8 = null,

    /// The revision number of the deployment.
    revision_id: ?[]const u8 = null,

    /// A list of key-value pairs that contain metadata for the resource. For more
    /// information, see [Tag your
    /// resources](https://docs.aws.amazon.com/greengrass/v2/developerguide/tag-resources.html) in the *IoT Greengrass V2 Developer Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the target IoT thing or thing group.
    target_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .components = "components",
        .creation_timestamp = "creationTimestamp",
        .deployment_id = "deploymentId",
        .deployment_name = "deploymentName",
        .deployment_policies = "deploymentPolicies",
        .deployment_status = "deploymentStatus",
        .iot_job_arn = "iotJobArn",
        .iot_job_configuration = "iotJobConfiguration",
        .iot_job_id = "iotJobId",
        .is_latest_for_target = "isLatestForTarget",
        .parent_target_arn = "parentTargetArn",
        .revision_id = "revisionId",
        .tags = "tags",
        .target_arn = "targetArn",
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "greengrassv2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDeploymentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrassv2", "GreengrassV2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/greengrass/v2/deployments/");
    try path_buf.appendSlice(allocator, input.deployment_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDeploymentOutput {
    var result: GetDeploymentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDeploymentOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestAlreadyInProgressException")) {
        return .{ .arena = arena, .kind = .{ .request_already_in_progress_exception = .{
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
