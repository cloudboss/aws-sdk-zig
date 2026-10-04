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
const TriggerConfig = @import("trigger_config.zig").TriggerConfig;
const AutoScalingGroup = @import("auto_scaling_group.zig").AutoScalingGroup;

pub const UpdateDeploymentGroupInput = struct {
    /// Information to add or change about Amazon CloudWatch alarms when the
    /// deployment group
    /// is updated.
    alarm_configuration: ?AlarmConfiguration = null,

    /// The application name that corresponds to the deployment group to update.
    application_name: []const u8,

    /// Information for an automatic rollback configuration that is added or changed
    /// when a
    /// deployment group is updated.
    auto_rollback_configuration: ?AutoRollbackConfiguration = null,

    /// The replacement list of Auto Scaling groups to be included in the deployment
    /// group, if you want to change them.
    ///
    /// * To keep the Auto Scaling groups, enter their names or do not specify this
    /// parameter.
    ///
    /// * To remove Auto Scaling groups, specify a non-null empty list of Auto
    ///   Scaling group names to detach all CodeDeploy-managed Auto Scaling
    ///   lifecycle hooks. For examples, see [Amazon EC2 instances in an Amazon EC2
    ///   Auto Scaling group fail to
    /// launch and receive the error "Heartbeat
    /// Timeout"](https://docs.aws.amazon.com/codedeploy/latest/userguide/troubleshooting-auto-scaling.html#troubleshooting-auto-scaling-heartbeat) in the
    /// *CodeDeploy User Guide*.
    auto_scaling_groups: ?[]const []const u8 = null,

    /// Information about blue/green deployment options for a deployment group.
    blue_green_deployment_configuration: ?BlueGreenDeploymentConfiguration = null,

    /// The current name of the deployment group.
    current_deployment_group_name: []const u8,

    /// The replacement deployment configuration name to use, if you want to change
    /// it.
    deployment_config_name: ?[]const u8 = null,

    /// Information about the type of deployment, either in-place or blue/green, you
    /// want to
    /// run and whether to route deployment traffic behind a load balancer.
    deployment_style: ?DeploymentStyle = null,

    /// The replacement set of Amazon EC2 tags on which to filter, if you want to
    /// change them. To keep the existing tags, enter their names. To remove tags,
    /// do not enter
    /// any tag names.
    ec_2_tag_filters: ?[]const EC2TagFilter = null,

    /// Information about groups of tags applied to on-premises instances. The
    /// deployment
    /// group includes only Amazon EC2 instances identified by all the tag
    /// groups.
    ec_2_tag_set: ?EC2TagSet = null,

    /// The target Amazon ECS services in the deployment group. This applies only to
    /// deployment groups that use the Amazon ECS compute platform. A target Amazon
    /// ECS service is specified as an Amazon ECS cluster and service name
    /// pair using the format `:`.
    ecs_services: ?[]const ECSService = null,

    /// Information about the load balancer used in a deployment.
    load_balancer_info: ?LoadBalancerInfo = null,

    /// The new name of the deployment group, if you want to change it.
    new_deployment_group_name: ?[]const u8 = null,

    /// The replacement set of on-premises instance tags on which to filter, if you
    /// want to
    /// change them. To keep the existing tags, enter their names. To remove tags,
    /// do not enter
    /// any tag names.
    on_premises_instance_tag_filters: ?[]const TagFilter = null,

    /// Information about an on-premises instance tag set. The deployment group
    /// includes only
    /// on-premises instances identified by all the tag groups.
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

    /// A replacement ARN for the service role, if you want to change it.
    service_role_arn: ?[]const u8 = null,

    /// This parameter only applies if you are using CodeDeploy with Amazon EC2 Auto
    /// Scaling. For more information, see [Integrating
    /// CodeDeploy with Amazon EC2 Auto
    /// Scaling](https://docs.aws.amazon.com/codedeploy/latest/userguide/integrations-aws-auto-scaling.html) in the *CodeDeploy User Guide*.
    ///
    /// Set `terminationHookEnabled` to `true` to have CodeDeploy install a
    /// termination hook into your Auto Scaling group when you update a
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

    /// Information about triggers to change when the deployment group is updated.
    /// For
    /// examples, see [Edit a Trigger in a
    /// CodeDeploy Deployment
    /// Group](https://docs.aws.amazon.com/codedeploy/latest/userguide/how-to-notify-edit.html) in the *CodeDeploy User
    /// Guide*.
    trigger_configurations: ?[]const TriggerConfig = null,

    pub const json_field_names = .{
        .alarm_configuration = "alarmConfiguration",
        .application_name = "applicationName",
        .auto_rollback_configuration = "autoRollbackConfiguration",
        .auto_scaling_groups = "autoScalingGroups",
        .blue_green_deployment_configuration = "blueGreenDeploymentConfiguration",
        .current_deployment_group_name = "currentDeploymentGroupName",
        .deployment_config_name = "deploymentConfigName",
        .deployment_style = "deploymentStyle",
        .ec_2_tag_filters = "ec2TagFilters",
        .ec_2_tag_set = "ec2TagSet",
        .ecs_services = "ecsServices",
        .load_balancer_info = "loadBalancerInfo",
        .new_deployment_group_name = "newDeploymentGroupName",
        .on_premises_instance_tag_filters = "onPremisesInstanceTagFilters",
        .on_premises_tag_set = "onPremisesTagSet",
        .outdated_instances_strategy = "outdatedInstancesStrategy",
        .service_role_arn = "serviceRoleArn",
        .termination_hook_enabled = "terminationHookEnabled",
        .trigger_configurations = "triggerConfigurations",
    };
};

pub const UpdateDeploymentGroupOutput = struct {
    /// If the output contains no data, and the corresponding deployment group
    /// contained at
    /// least one Auto Scaling group, CodeDeploy successfully removed all
    /// corresponding Auto Scaling lifecycle event hooks from the Amazon Web
    /// Services account. If the output contains data, CodeDeploy could not remove
    /// some Auto Scaling lifecycle event hooks from the Amazon Web Services
    /// account.
    hooks_not_cleaned_up: ?[]const AutoScalingGroup = null,

    pub const json_field_names = .{
        .hooks_not_cleaned_up = "hooksNotCleanedUp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDeploymentGroupInput, options: CallOptions) !UpdateDeploymentGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDeploymentGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.UpdateDeploymentGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDeploymentGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateDeploymentGroupOutput, body, allocator);
}
