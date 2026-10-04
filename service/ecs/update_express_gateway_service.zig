const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExpressCpuArchitecture = @import("express_cpu_architecture.zig").ExpressCpuArchitecture;
const ExpressGatewayServiceNetworkConfiguration = @import("express_gateway_service_network_configuration.zig").ExpressGatewayServiceNetworkConfiguration;
const ExpressGatewayContainer = @import("express_gateway_container.zig").ExpressGatewayContainer;
const ExpressGatewayScalingTarget = @import("express_gateway_scaling_target.zig").ExpressGatewayScalingTarget;
const UpdatedExpressGatewayService = @import("updated_express_gateway_service.zig").UpdatedExpressGatewayService;

pub const UpdateExpressGatewayServiceInput = struct {
    /// The number of CPU units used by the task.
    cpu: ?[]const u8 = null,

    /// The CPU architecture that the task runs on. If you don't specify a value,
    /// the service keeps its current architecture.
    ///
    /// Valid values:
    ///
    /// * `X86_64` - The x86 64-bit architecture.
    /// * `ARM64` - The 64-bit ARM architecture.
    ///
    /// Changing the architecture starts a new deployment that replaces the running
    /// tasks. Ensure that the container image you specify supports the architecture
    /// you choose. The operating system family for an Express service is always
    /// `LINUX`.
    ///
    /// You can't specify `cpuArchitecture` together with `taskDefinitionArn`.
    cpu_architecture: ?ExpressCpuArchitecture = null,

    /// The Amazon Resource Name (ARN) of the task execution role for the Express
    /// service.
    execution_role_arn: ?[]const u8 = null,

    /// The path on the container for Application Load Balancer health checks.
    health_check_path: ?[]const u8 = null,

    /// The amount of memory (in MiB) used by the task.
    memory: ?[]const u8 = null,

    /// The network configuration for the Express service tasks. By default, the
    /// network configuration for an Express service uses the default VPC.
    network_configuration: ?ExpressGatewayServiceNetworkConfiguration = null,

    /// The primary container configuration for the Express service.
    primary_container: ?ExpressGatewayContainer = null,

    /// The auto-scaling configuration for the Express service.
    scaling_target: ?ExpressGatewayScalingTarget = null,

    /// The Amazon Resource Name (ARN) of the Express service to update.
    service_arn: []const u8,

    /// The Amazon Resource Name (ARN) of a task definition to use to update the
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

    /// The Amazon Resource Name (ARN) of the IAM role for containers in this task.
    task_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cpu = "cpu",
        .cpu_architecture = "cpuArchitecture",
        .execution_role_arn = "executionRoleArn",
        .health_check_path = "healthCheckPath",
        .memory = "memory",
        .network_configuration = "networkConfiguration",
        .primary_container = "primaryContainer",
        .scaling_target = "scalingTarget",
        .service_arn = "serviceArn",
        .task_definition_arn = "taskDefinitionArn",
        .task_role_arn = "taskRoleArn",
    };
};

pub const UpdateExpressGatewayServiceOutput = struct {
    /// The full description of your express gateway service following the update
    /// call.
    service: ?UpdatedExpressGatewayService = null,

    pub const json_field_names = .{
        .service = "service",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateExpressGatewayServiceInput, options: CallOptions) !UpdateExpressGatewayServiceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateExpressGatewayServiceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.UpdateExpressGatewayService");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateExpressGatewayServiceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateExpressGatewayServiceOutput, body, allocator);
}
