const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ExpressGatewayServiceNetworkConfiguration = @import("express_gateway_service_network_configuration.zig").ExpressGatewayServiceNetworkConfiguration;
const ExpressGatewayContainer = @import("express_gateway_container.zig").ExpressGatewayContainer;
const ExpressGatewayScalingTarget = @import("express_gateway_scaling_target.zig").ExpressGatewayScalingTarget;
const Tag = @import("tag.zig").Tag;
const ECSExpressGatewayService = @import("ecs_express_gateway_service.zig").ECSExpressGatewayService;

pub const CreateExpressGatewayServiceInput = struct {
    /// The short name or full Amazon Resource Name (ARN) of the cluster on which to
    /// create the
    /// Express service. If you do not specify a cluster, the `default` cluster is
    /// assumed.
    cluster: ?[]const u8 = null,

    /// The number of CPU units used by the task. This parameter determines the CPU
    /// allocation
    /// for each task in the Express service. The default value for an Express
    /// service is 256 (.25 vCPU).
    cpu: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the task execution role that grants the
    /// Amazon ECS
    /// container agent permission to make Amazon Web Services API calls on your
    /// behalf. This role is required
    /// for Amazon ECS to pull container images from Amazon ECR, send container logs
    /// to Amazon
    /// CloudWatch Logs, and retrieve sensitive data from Amazon Web Services
    /// Systems Manager Parameter Store or
    /// Amazon Web Services Secrets Manager.
    ///
    /// The execution role must include the `AmazonECSTaskExecutionRolePolicy`
    /// managed policy or equivalent permissions. For Express services, this role is
    /// used during
    /// task startup and runtime for container management operations.
    execution_role_arn: []const u8,

    /// The path on the container that the Application Load Balancer uses for health
    /// checks.
    /// This should be a valid HTTP endpoint that returns a successful response
    /// (HTTP 200) when the
    /// application is healthy.
    ///
    /// If not specified, the default health check path is `/ping`. The health check
    /// path
    /// must start with a forward slash and can include query parameters. Examples:
    /// `/health`, `/api/status`, `/ping?format=json`.
    health_check_path: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the infrastructure role that grants Amazon
    /// ECS permission
    /// to create and manage Amazon Web Services resources on your behalf for the
    /// Express service. This role is
    /// used to provision and manage Application Load Balancers, target groups,
    /// security groups,
    /// auto-scaling policies, and other Amazon Web Services infrastructure
    /// components.
    ///
    /// The infrastructure role must include permissions for Elastic Load Balancing,
    /// Application
    /// Auto Scaling, Amazon EC2 (for security groups), and other services required
    /// for managed
    /// infrastructure. This role is only used during Express service creation,
    /// updates, and
    /// deletion operations.
    infrastructure_role_arn: []const u8,

    /// The amount of memory (in MiB) used by the task. This parameter determines
    /// the memory
    /// allocation for each task in the Express service. The default value for an
    /// express service is 512 MiB.
    memory: ?[]const u8 = null,

    /// The network configuration for the Express service tasks. This specifies the
    /// VPC subnets
    /// and security groups for the tasks.
    ///
    /// For Express services, you can specify custom security groups and subnets. If
    /// not
    /// provided, Amazon ECS will use the default VPC configuration and create
    /// appropriate security
    /// groups automatically. The network configuration determines how your service
    /// integrates with
    /// your VPC and what network access it has.
    network_configuration: ?ExpressGatewayServiceNetworkConfiguration = null,

    /// The primary container configuration for the Express service. This defines
    /// the main
    /// application container that will receive traffic from the Application Load
    /// Balancer.
    ///
    /// The primary container must specify at minimum a container image. You can
    /// also configure
    /// the container port (defaults to 80), logging configuration, environment
    /// variables, secrets,
    /// and startup commands. The container image can be from Amazon ECR, Docker
    /// Hub, or any other
    /// container registry accessible to your execution role.
    primary_container: ExpressGatewayContainer,

    /// The auto-scaling configuration for the Express service. This defines how the
    /// service
    /// automatically adjusts the number of running tasks based on demand.
    ///
    /// You can specify the minimum and maximum number of tasks, the scaling metric
    /// (CPU
    /// utilization, memory utilization, or request count per target), and the
    /// target value for the
    /// metric. If not specified, the default target value for an Express service is
    /// 60.
    scaling_target: ?ExpressGatewayScalingTarget = null,

    /// The name of the Express service. This name must be unique within the
    /// specified cluster
    /// and can contain up to 255 letters (uppercase and lowercase), numbers,
    /// underscores, and
    /// hyphens. The name is used to identify the service in the Amazon ECS console
    /// and API
    /// operations.
    ///
    /// If you don't specify a service name, Amazon ECS generates a unique name for
    /// the service. The
    /// service name becomes part of the service ARN and cannot be changed after the
    /// service is
    /// created.
    service_name: ?[]const u8 = null,

    /// The metadata that you apply to the Express service to help categorize and
    /// organize it.
    /// Each tag consists of a key and an optional value. You can apply up to 50
    /// tags to a
    /// service.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of the IAM role that containers in this task
    /// can assume.
    /// This role allows your application code to access other Amazon Web Services
    /// services securely.
    ///
    /// The task role is different from the execution role. While the execution role
    /// is used by
    /// the Amazon ECS agent to set up the task, the task role is used by your
    /// application code running
    /// inside the container to make Amazon Web Services API calls. If your
    /// application doesn't need to access
    /// Amazon Web Services services, you can omit this parameter.
    task_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster = "cluster",
        .cpu = "cpu",
        .execution_role_arn = "executionRoleArn",
        .health_check_path = "healthCheckPath",
        .infrastructure_role_arn = "infrastructureRoleArn",
        .memory = "memory",
        .network_configuration = "networkConfiguration",
        .primary_container = "primaryContainer",
        .scaling_target = "scalingTarget",
        .service_name = "serviceName",
        .tags = "tags",
        .task_role_arn = "taskRoleArn",
    };
};

pub const CreateExpressGatewayServiceOutput = struct {
    /// The full description of your Express service following the create operation.
    service: ?ECSExpressGatewayService = null,

    pub const json_field_names = .{
        .service = "service",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateExpressGatewayServiceInput, options: CallOptions) !CreateExpressGatewayServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ecs");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateExpressGatewayServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.CreateExpressGatewayService");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateExpressGatewayServiceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateExpressGatewayServiceOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "AttributeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .attribute_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BlockedException")) {
        return .{ .arena = arena, .kind = .{ .blocked_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterContainsCapacityProviderException")) {
        return .{ .arena = arena, .kind = .{ .cluster_contains_capacity_provider_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterContainsContainerInstancesException")) {
        return .{ .arena = arena, .kind = .{ .cluster_contains_container_instances_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterContainsServicesException")) {
        return .{ .arena = arena, .kind = .{ .cluster_contains_services_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterContainsTasksException")) {
        return .{ .arena = arena, .kind = .{ .cluster_contains_tasks_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ClusterNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .cluster_not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
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
    if (std.mem.eql(u8, error_code, "MissingVersionException")) {
        return .{ .arena = arena, .kind = .{ .missing_version_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NamespaceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .namespace_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoUpdateAvailableException")) {
        return .{ .arena = arena, .kind = .{ .no_update_available_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PlatformTaskDefinitionIncompatibilityException")) {
        return .{ .arena = arena, .kind = .{ .platform_task_definition_incompatibility_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PlatformUnknownException")) {
        return .{ .arena = arena, .kind = .{ .platform_unknown_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceDeploymentNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .service_deployment_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceNotActiveException")) {
        return .{ .arena = arena, .kind = .{ .service_not_active_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .service_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetNotConnectedException")) {
        return .{ .arena = arena, .kind = .{ .target_not_connected_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TargetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .target_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TaskSetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .task_set_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedFeatureException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_feature_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UpdateInProgressException")) {
        return .{ .arena = arena, .kind = .{ .update_in_progress_exception = .{
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
