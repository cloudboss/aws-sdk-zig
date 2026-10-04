const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const AutoRollbackConfiguration = @import("auto_rollback_configuration.zig").AutoRollbackConfiguration;
const BlueGreenDeploymentConfiguration = @import("blue_green_deployment_configuration.zig").BlueGreenDeploymentConfiguration;
const DeploymentStyle = @import("deployment_style.zig").DeploymentStyle;
const EC2TagFilter = @import("ec2_tag_filter.zig").EC2TagFilter;
const EC2TagSet = @import("ec2_tag_set.zig").EC2TagSet;
const ECSService = @import("ecs_service.zig").ECSService;
const LoadBalancerInfo = @import("load_balancer_info.zig").LoadBalancerInfo;
const TagFilter = @import("tag_filter.zig").TagFilter;
const OnPremisesTagSet = @import("on_premises_tag_set.zig").OnPremisesTagSet;
const OutdatedInstancesStrategy = @import("outdated_instances_strategy.zig").OutdatedInstancesStrategy;
const Tag = @import("tag.zig").Tag;
const TriggerConfig = @import("trigger_config.zig").TriggerConfig;

pub const CreateDeploymentGroupInput = struct {
    /// Information to add about Amazon CloudWatch alarms when the deployment group
    /// is
    /// created.
    alarm_configuration: ?AlarmConfiguration = null,

    /// The name of an CodeDeploy application associated with the user or Amazon Web
    /// Services account.
    application_name: []const u8,

    /// Configuration information for an automatic rollback that is added when a
    /// deployment
    /// group is created.
    auto_rollback_configuration: ?AutoRollbackConfiguration = null,

    /// A list of associated Amazon EC2 Auto Scaling groups.
    auto_scaling_groups: ?[]const []const u8 = null,

    /// Information about blue/green deployment options for a deployment group.
    blue_green_deployment_configuration: ?BlueGreenDeploymentConfiguration = null,

    /// If specified, the deployment configuration name can be either one of the
    /// predefined
    /// configurations provided with CodeDeploy or a custom deployment configuration
    /// that you create by calling the create deployment configuration operation.
    ///
    /// `CodeDeployDefault.OneAtATime` is the default deployment configuration. It
    /// is used if a configuration isn't specified for the deployment or deployment
    /// group.
    ///
    /// For more information about the predefined deployment configurations in
    /// CodeDeploy, see [Working with
    /// Deployment Configurations in
    /// CodeDeploy](https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-configurations.html) in the *CodeDeploy User Guide*.
    deployment_config_name: ?[]const u8 = null,

    /// The name of a new deployment group for the specified application.
    deployment_group_name: []const u8,

    /// Information about the type of deployment, in-place or blue/green, that you
    /// want to run
    /// and whether to route deployment traffic behind a load balancer.
    deployment_style: ?DeploymentStyle = null,

    /// The Amazon EC2 tags on which to filter. The deployment group includes Amazon
    /// EC2 instances with any of the specified tags. Cannot be used in the same
    /// call
    /// as ec2TagSet.
    ec_2_tag_filters: ?[]const EC2TagFilter = null,

    /// Information about groups of tags applied to Amazon EC2 instances. The
    /// deployment group includes only Amazon EC2 instances identified by all the
    /// tag
    /// groups. Cannot be used in the same call as `ec2TagFilters`.
    ec_2_tag_set: ?EC2TagSet = null,

    /// The target Amazon ECS services in the deployment group. This applies only to
    /// deployment groups that use the Amazon ECS compute platform. A target Amazon
    /// ECS service is specified as an Amazon ECS cluster and service name
    /// pair using the format `:`.
    ecs_services: ?[]const ECSService = null,

    /// Information about the load balancer used in a deployment.
    load_balancer_info: ?LoadBalancerInfo = null,

    /// The on-premises instance tags on which to filter. The deployment group
    /// includes
    /// on-premises instances with any of the specified tags. Cannot be used in the
    /// same call as
    /// `OnPremisesTagSet`.
    on_premises_instance_tag_filters: ?[]const TagFilter = null,

    /// Information about groups of tags applied to on-premises instances. The
    /// deployment
    /// group includes only on-premises instances identified by all of the tag
    /// groups. Cannot be
    /// used in the same call as `onPremisesInstanceTagFilters`.
    on_premises_tag_set: ?OnPremisesTagSet = null,

    /// Indicates what happens when new Amazon EC2 instances are launched
    /// mid-deployment and do not receive the deployed application revision.
    ///
    /// If this option is set to `UPDATE` or is unspecified, CodeDeploy initiates
    /// one or more 'auto-update outdated instances' deployments to apply the
    /// deployed
    /// application revision to the new Amazon EC2 instances.
    ///
    /// If this option is set to `IGNORE`, CodeDeploy does not initiate a
    /// deployment to update the new Amazon EC2 instances. This may result in
    /// instances
    /// having different revisions.
    outdated_instances_strategy: ?OutdatedInstancesStrategy = null,

    /// A service role Amazon Resource Name (ARN) that allows CodeDeploy to act on
    /// the user's behalf when interacting with Amazon Web Services services.
    service_role_arn: []const u8,

    /// The metadata that you apply to CodeDeploy deployment groups to help you
    /// organize and
    /// categorize them. Each tag consists of a key and an optional value, both of
    /// which you
    /// define.
    tags: ?[]const Tag = null,

    /// This parameter only applies if you are using CodeDeploy with Amazon EC2 Auto
    /// Scaling. For more information, see [Integrating
    /// CodeDeploy with Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/codedeploy/latest/userguide/integrations-aws-auto-scaling.html) in the *CodeDeploy User Guide*.
    ///
    /// Set `terminationHookEnabled` to `true` to have CodeDeploy install a
    /// termination hook into your Auto Scaling group when you create a
    /// deployment group. When this hook is installed, CodeDeploy will perform
    /// termination deployments.
    ///
    /// For information about termination deployments, see [Enabling termination
    /// deployments during Auto Scaling scale-in
    /// events](https://docs.aws.amazon.com/codedeploy/latest/userguide/integrations-aws-auto-scaling.html#integrations-aws-auto-scaling-behaviors-hook-enable) in the
    /// *CodeDeploy User Guide*.
    ///
    /// For more information about Auto Scaling scale-in events, see the [Scale
    /// in](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-lifecycle.html#as-lifecycle-scale-in) topic in the *Amazon EC2 Auto Scaling User
    /// Guide*.
    termination_hook_enabled: ?bool = null,

    /// Information about triggers to create when the deployment group is created.
    /// For
    /// examples, see [Create a Trigger for an
    /// CodeDeploy
    /// Event](https://docs.aws.amazon.com/codedeploy/latest/userguide/how-to-notify-sns.html) in the *CodeDeploy
    /// User Guide*.
    trigger_configurations: ?[]const TriggerConfig = null,

    pub const json_field_names = .{
        .alarm_configuration = "alarmConfiguration",
        .application_name = "applicationName",
        .auto_rollback_configuration = "autoRollbackConfiguration",
        .auto_scaling_groups = "autoScalingGroups",
        .blue_green_deployment_configuration = "blueGreenDeploymentConfiguration",
        .deployment_config_name = "deploymentConfigName",
        .deployment_group_name = "deploymentGroupName",
        .deployment_style = "deploymentStyle",
        .ec_2_tag_filters = "ec2TagFilters",
        .ec_2_tag_set = "ec2TagSet",
        .ecs_services = "ecsServices",
        .load_balancer_info = "loadBalancerInfo",
        .on_premises_instance_tag_filters = "onPremisesInstanceTagFilters",
        .on_premises_tag_set = "onPremisesTagSet",
        .outdated_instances_strategy = "outdatedInstancesStrategy",
        .service_role_arn = "serviceRoleArn",
        .tags = "tags",
        .termination_hook_enabled = "terminationHookEnabled",
        .trigger_configurations = "triggerConfigurations",
    };
};

pub const CreateDeploymentGroupOutput = struct {
    /// A unique deployment group ID.
    deployment_group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_group_id = "deploymentGroupId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDeploymentGroupInput, options: CallOptions) !CreateDeploymentGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codedeploy", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDeploymentGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codedeploy", "CodeDeploy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.CreateDeploymentGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDeploymentGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDeploymentGroupOutput, body, allocator);
}
