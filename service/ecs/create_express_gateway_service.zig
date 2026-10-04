const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExpressCpuArchitecture = @import("express_cpu_architecture.zig").ExpressCpuArchitecture;
const ExpressGatewayServiceNetworkConfiguration = @import("express_gateway_service_network_configuration.zig").ExpressGatewayServiceNetworkConfiguration;
const ExpressGatewayContainer = @import("express_gateway_container.zig").ExpressGatewayContainer;
const ExpressGatewayScalingTarget = @import("express_gateway_scaling_target.zig").ExpressGatewayScalingTarget;
const Tag = @import("tag.zig").Tag;
const ECSExpressGatewayService = @import("ecs_express_gateway_service.zig").ECSExpressGatewayService;

pub const CreateExpressGatewayServiceInput = struct {
    /// The short name or full Amazon Resource Name (ARN) of the cluster on which to
    /// create the Express service. If you do not specify a cluster, the `default`
    /// cluster is assumed.
    cluster: ?[]const u8 = null,

    /// The number of CPU units used by the task. This parameter determines the CPU
    /// allocation for each task in the Express service. The default value for an
    /// Express service is 256 (.25 vCPU).
    cpu: ?[]const u8 = null,

    /// The CPU architecture that the task runs on. If you don't specify a value,
    /// the default is `X86_64`.
    ///
    /// Valid values:
    ///
    /// * `X86_64` - The x86 64-bit architecture.
    /// * `ARM64` - The 64-bit ARM architecture.
    ///
    /// Ensure that the container image you specify supports the architecture you
    /// choose. The operating system family for an Express service is always
    /// `LINUX`.
    ///
    /// You can't specify `cpuArchitecture` together with `taskDefinitionArn`.
    cpu_architecture: ?ExpressCpuArchitecture = null,

    /// The Amazon Resource Name (ARN) of the task execution role that grants the
    /// Amazon ECS container agent permission to make Amazon Web Services API calls
    /// on your behalf. This role is required for Amazon ECS to pull container
    /// images from Amazon ECR, send container logs to Amazon CloudWatch Logs, and
    /// retrieve sensitive data from Amazon Web Services Systems Manager Parameter
    /// Store or Amazon Web Services Secrets Manager.
    ///
    /// The execution role must include the `AmazonECSTaskExecutionRolePolicy`
    /// managed policy or equivalent permissions. For Express services, this role is
    /// used during task startup and runtime for container management operations.
    execution_role_arn: ?[]const u8 = null,

    /// The path on the container that the Application Load Balancer uses for health
    /// checks. This should be a valid HTTP endpoint that returns a successful
    /// response (HTTP 200) when the application is healthy.
    ///
    /// If not specified, the default health check path is `/ping`. The health check
    /// path must start with a forward slash and can include query parameters.
    /// Examples: `/health`, `/api/status`, `/ping?format=json`.
    health_check_path: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the infrastructure role that grants Amazon
    /// ECS permission to create and manage Amazon Web Services resources on your
    /// behalf for the Express service. This role is used to provision and manage
    /// Application Load Balancers, target groups, security groups, auto-scaling
    /// policies, and other Amazon Web Services infrastructure components.
    ///
    /// The infrastructure role must include permissions for Elastic Load Balancing,
    /// Application Auto Scaling, Amazon EC2 (for security groups), and other
    /// services required for managed infrastructure. This role is only used during
    /// Express service creation, updates, and deletion operations.
    infrastructure_role_arn: []const u8,

    /// The amount of memory (in MiB) used by the task. This parameter determines
    /// the memory allocation for each task in the Express service. The default
    /// value for an express service is 512 MiB.
    memory: ?[]const u8 = null,

    /// The network configuration for the Express service tasks. This specifies the
    /// VPC subnets and security groups for the tasks.
    ///
    /// For Express services, you can specify custom security groups and subnets. If
    /// not provided, Amazon ECS will use the default VPC configuration and create
    /// appropriate security groups automatically. The network configuration
    /// determines how your service integrates with your VPC and what network access
    /// it has.
    network_configuration: ?ExpressGatewayServiceNetworkConfiguration = null,

    /// The primary container configuration for the Express service. This defines
    /// the main application container that will receive traffic from the
    /// Application Load Balancer.
    ///
    /// The primary container must specify at minimum a container image. You can
    /// also configure the container port (defaults to 80), logging configuration,
    /// environment variables, secrets, and startup commands. The container image
    /// can be from Amazon ECR, Docker Hub, or any other container registry
    /// accessible to your execution role.
    primary_container: ?ExpressGatewayContainer = null,

    /// The auto-scaling configuration for the Express service. This defines how the
    /// service automatically adjusts the number of running tasks based on demand.
    ///
    /// You can specify the minimum and maximum number of tasks, the scaling metric
    /// (CPU utilization, memory utilization, or request count per target), and the
    /// target value for the metric. If not specified, the default target value for
    /// an Express service is 60.
    scaling_target: ?ExpressGatewayScalingTarget = null,

    /// The name of the Express service. This name must be unique within the
    /// specified cluster and can contain up to 255 letters (uppercase and
    /// lowercase), numbers, underscores, and hyphens. The name is used to identify
    /// the service in the Amazon ECS console and API operations.
    ///
    /// If you don't specify a service name, Amazon ECS generates a unique name for
    /// the service. The service name becomes part of the service ARN and cannot be
    /// changed after the service is created.
    service_name: ?[]const u8 = null,

    /// The metadata that you apply to the Express service to help categorize and
    /// organize it. Each tag consists of a key and an optional value. You can apply
    /// up to 50 tags to a service.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of a task definition to use to create the
    /// Express Gateway service. This allows you to manage your own task definition,
    /// giving you more control over the service configuration such as adding
    /// sidecar containers.
    ///
    /// The task definition must have a container named `Main` with a single TCP
    /// port mapping that includes a container port and port name. The task
    /// definition must also have `FARGATE` compatibility.
    ///
    /// If you provide a task definition ARN, you cannot also specify
    /// `primaryContainer`, `executionRoleArn`, `taskRoleArn`, `cpu`, `memory`, or
    /// `cpuArchitecture`.
    task_definition_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that containers in this task
    /// can assume. This role allows your application code to access other Amazon
    /// Web Services services securely.
    ///
    /// The task role is different from the execution role. While the execution role
    /// is used by the Amazon ECS agent to set up the task, the task role is used by
    /// your application code running inside the container to make Amazon Web
    /// Services API calls. If your application doesn't need to access Amazon Web
    /// Services services, you can omit this parameter.
    task_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster = "cluster",
        .cpu = "cpu",
        .cpu_architecture = "cpuArchitecture",
        .execution_role_arn = "executionRoleArn",
        .health_check_path = "healthCheckPath",
        .infrastructure_role_arn = "infrastructureRoleArn",
        .memory = "memory",
        .network_configuration = "networkConfiguration",
        .primary_container = "primaryContainer",
        .scaling_target = "scalingTarget",
        .service_name = "serviceName",
        .tags = "tags",
        .task_definition_arn = "taskDefinitionArn",
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateExpressGatewayServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
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
