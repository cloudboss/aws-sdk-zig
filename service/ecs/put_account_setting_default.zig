const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SettingName = @import("setting_name.zig").SettingName;
const Setting = @import("setting.zig").Setting;

pub const PutAccountSettingDefaultInput = struct {
    /// The resource name for which to modify the account setting.
    ///
    /// The following are the valid values for the account setting name.
    ///
    /// * `serviceLongArnFormat` - When modified, the Amazon Resource Name (ARN) and
    ///   resource ID format of the resource type for a specified user, role, or the
    ///   root user for an account is affected. The opt-in and opt-out account
    ///   setting must be set for each Amazon ECS resource separately. The ARN and
    ///   resource ID format of a resource is defined by the opt-in status of the
    ///   user or role that created the resource. You must turn on this setting to
    ///   use Amazon ECS features such as resource tagging.
    /// * `taskLongArnFormat` - When modified, the Amazon Resource Name (ARN) and
    ///   resource ID format of the resource type for a specified user, role, or the
    ///   root user for an account is affected. The opt-in and opt-out account
    ///   setting must be set for each Amazon ECS resource separately. The ARN and
    ///   resource ID format of a resource is defined by the opt-in status of the
    ///   user or role that created the resource. You must turn on this setting to
    ///   use Amazon ECS features such as resource tagging.
    /// * `containerInstanceLongArnFormat` - When modified, the Amazon Resource Name
    ///   (ARN) and resource ID format of the resource type for a specified user,
    ///   role, or the root user for an account is affected. The opt-in and opt-out
    ///   account setting must be set for each Amazon ECS resource separately. The
    ///   ARN and resource ID format of a resource is defined by the opt-in status
    ///   of the user or role that created the resource. You must turn on this
    ///   setting to use Amazon ECS features such as resource tagging.
    /// * `awsvpcTrunking` - When modified, the elastic network interface (ENI)
    ///   limit for any new container instances that support the feature is changed.
    ///   If `awsvpcTrunking` is turned on, any new container instances that support
    ///   the feature are launched have the increased ENI limits available to them.
    ///   For more information, see [Elastic Network Interface
    ///   Trunking](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/container-instance-eni.html) in the *Amazon Elastic Container Service Developer Guide*.
    /// * `containerInsights` - Container Insights with enhanced observability
    ///   provides all the Container Insights metrics, plus additional task and
    ///   container metrics. This version supports enhanced observability for Amazon
    ///   ECS clusters using the Amazon EC2 and Fargate launch types. After you
    ///   configure Container Insights with enhanced observability on Amazon ECS,
    ///   Container Insights auto-collects detailed infrastructure telemetry from
    ///   the cluster level down to the container level in your environment and
    ///   displays these critical performance data in curated dashboards removing
    ///   the heavy lifting in observability set-up.
    ///
    /// To use Container Insights with enhanced observability, set the
    /// `containerInsights` account setting to `enhanced`.
    ///
    /// To use Container Insights, set the `containerInsights` account setting to
    /// `enabled`.
    ///
    /// For more information, see [Monitor Amazon ECS containers using Container
    /// Insights with enhanced
    /// observability](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-container-insights.html) in the *Amazon Elastic Container Service Developer Guide*.
    /// * `dualStackIPv6` - When turned on, when using a VPC in dual stack mode,
    ///   your tasks using the `awsvpc` network mode can have an IPv6 address
    ///   assigned. For more information on using IPv6 with tasks launched on Amazon
    ///   EC2 instances, see [Using a VPC in dual-stack
    ///   mode](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking-awsvpc.html#task-networking-vpc-dual-stack). For more information on using IPv6 with tasks launched on Fargate, see [Using a VPC in dual-stack mode](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-task-networking.html#fargate-task-networking-vpc-dual-stack).
    /// * `fargateFIPSMode` - If you specify `fargateFIPSMode`, Fargate FIPS 140
    ///   compliance is affected.
    /// * `fargateTaskRetirementWaitPeriod` - When Amazon Web Services determines
    ///   that a security or infrastructure update is needed for an Amazon ECS task
    ///   hosted on Fargate, the tasks need to be stopped and new tasks launched to
    ///   replace them. Use `fargateTaskRetirementWaitPeriod` to configure the wait
    ///   time to retire a Fargate task. For information about the Fargate tasks
    ///   maintenance, see [Amazon Web Services Fargate task
    ///   maintenance](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-maintenance.html) in the *Amazon ECS Developer Guide*.
    /// * `fargateEventWindows` - When Amazon Web Services determines that a
    ///   security or infrastructure update is needed for an Amazon ECS task hosted
    ///   on Fargate, the tasks need to be stopped and new tasks launched to replace
    ///   them. Use `fargateEventWindows` to use EC2 Event Windows associated with
    ///   Fargate tasks to configure time windows for task retirement.
    /// * `tagResourceAuthorization` - Amazon ECS is introducing tagging
    ///   authorization for resource creation. Users must have permissions for
    ///   actions that create the resource, such as `ecsCreateCluster`. If tags are
    ///   specified when you create a resource, Amazon Web Services performs
    ///   additional authorization to verify if users or roles have permissions to
    ///   create tags. Therefore, you must grant explicit permissions to use the
    ///   `ecs:TagResource` action. For more information, see [Grant permission to
    ///   tag resources on
    ///   creation](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/supported-iam-actions-tagging.html) in the *Amazon ECS Developer Guide*.
    /// * `defaultLogDriverMode` -Amazon ECS supports setting a default delivery
    ///   mode of log messages from a container to the `logDriver` that you specify
    ///   in the container's `logConfiguration`. The delivery mode affects
    ///   application stability when the flow of logs from the container to the log
    ///   driver is interrupted. The `defaultLogDriverMode` setting supports two
    ///   values: `blocking` and `non-blocking`. If you don't specify a delivery
    ///   mode in your container definition's `logConfiguration`, the mode you
    ///   specify using this account setting will be used as the default. For more
    ///   information about log delivery modes, see
    ///   [LogConfiguration](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html).
    ///
    /// On June 25, 2025, Amazon ECS changed the default log driver mode from
    /// `blocking` to `non-blocking` to prioritize task availability over logging.
    /// To continue using the `blocking` mode after this change, do one of the
    /// following:
    ///
    /// * Set the `mode` option in your container definition's `logConfiguration` as
    ///   `blocking`.
    /// * Set the `defaultLogDriverMode` account setting to `blocking`.
    ///
    /// * `guardDutyActivate` - The `guardDutyActivate` parameter is read-only in
    ///   Amazon ECS and indicates whether Amazon ECS Runtime Monitoring is enabled
    ///   or disabled by your security administrator in your Amazon ECS account.
    ///   Amazon GuardDuty controls this account setting on your behalf. For more
    ///   information, see [Protecting Amazon ECS workloads with Amazon ECS Runtime
    ///   Monitoring](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-guard-duty-integration.html).
    name: SettingName,

    /// The account setting value for the specified principal ARN. Accepted values
    /// are `enabled`, `disabled`, `on`, `enhanced`, and `off`.
    ///
    /// When you specify `fargateTaskRetirementWaitPeriod` for the `name`, the
    /// following are the valid values:
    ///
    /// * `0` - Amazon Web Services sends the notification, and immediately retires
    ///   the affected tasks.
    /// * `7` - Amazon Web Services sends the notification, and waits 7 calendar
    ///   days to retire the tasks.
    /// * `14` - Amazon Web Services sends the notification, and waits 14 calendar
    ///   days to retire the tasks.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};

pub const PutAccountSettingDefaultOutput = struct {
    /// The current setting for a resource.
    setting: ?Setting = null,

    pub const json_field_names = .{
        .setting = "setting",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAccountSettingDefaultInput, options: CallOptions) !PutAccountSettingDefaultOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAccountSettingDefaultInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.PutAccountSettingDefault");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAccountSettingDefaultOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutAccountSettingDefaultOutput, body, allocator);
}
