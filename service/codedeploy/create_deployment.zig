const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoRollbackConfiguration = @import("auto_rollback_configuration.zig").AutoRollbackConfiguration;
const DeploymentMode = @import("deployment_mode.zig").DeploymentMode;
const FileExistsBehavior = @import("file_exists_behavior.zig").FileExistsBehavior;
const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const RevisionLocation = @import("revision_location.zig").RevisionLocation;
const TargetInstances = @import("target_instances.zig").TargetInstances;

pub const CreateDeploymentInput = struct {
    /// The name of an CodeDeploy application associated with the user or Amazon Web
    /// Services account.
    application_name: []const u8,

    /// Configuration information for an automatic rollback that is added when a
    /// deployment is
    /// created.
    auto_rollback_configuration: ?AutoRollbackConfiguration = null,

    /// The name of a deployment configuration associated with the user or Amazon
    /// Web Services account.
    ///
    /// If not specified, the value configured in the deployment group is used as
    /// the default.
    /// If the deployment group does not have a deployment configuration associated
    /// with it,
    /// `CodeDeployDefault`.`OneAtATime` is used by default.
    deployment_config_name: ?[]const u8 = null,

    /// The name of the deployment group.
    deployment_group_name: ?[]const u8 = null,

    /// The type of deployment to create. Valid values are:
    ///
    /// * `STANDARD`: Deploys the specified revision. This is the default
    /// behavior if `deploymentMode` is not specified.
    ///
    /// * `RESTART`: Restarts the application on the target instances using
    /// the revision from the deployment group's last successful deployment, without
    /// downloading a new revision. `RESTART` is supported only for
    /// EC2/On-premises in-place deployments.
    ///
    /// When `deploymentMode` is `RESTART`, the following
    /// apply:
    ///
    /// * The call is rejected for Amazon ECS and Lambda
    /// deployments.
    ///
    /// * The `revision` parameter (including its
    /// `s3Location` and `gitHubLocation`) must not be
    /// specified, and is rejected if provided. The revision is resolved by the
    /// service from the deployment group's last successful deployment.
    ///
    /// * The `updateOutdatedInstancesOnly` parameter must not be
    /// set to `true`, and is rejected if provided.
    deployment_mode: ?DeploymentMode = null,

    /// A comment about the deployment.
    description: ?[]const u8 = null,

    /// Information about how CodeDeploy handles files that already exist in a
    /// deployment target location but weren't part of the previous successful
    /// deployment.
    ///
    /// The `fileExistsBehavior` parameter takes any of the following
    /// values:
    ///
    /// * DISALLOW: The deployment fails. This is also the default behavior if no
    ///   option
    /// is specified.
    ///
    /// * OVERWRITE: The version of the file from the application revision currently
    /// being deployed replaces the version already on the instance.
    ///
    /// * RETAIN: The version of the file already on the instance is kept and used
    ///   as
    /// part of the new deployment.
    file_exists_behavior: ?FileExistsBehavior = null,

    /// If true, then if an `ApplicationStop`, `BeforeBlockTraffic`, or
    /// `AfterBlockTraffic` deployment lifecycle event to an instance fails, then
    /// the deployment continues to the next deployment lifecycle event. For
    /// example, if
    /// `ApplicationStop` fails, the deployment continues with
    /// `DownloadBundle`. If `BeforeBlockTraffic` fails, the
    /// deployment continues with `BlockTraffic`. If `AfterBlockTraffic`
    /// fails, the deployment continues with `ApplicationStop`.
    ///
    /// If false or not specified, then if a lifecycle event fails during a
    /// deployment to an
    /// instance, that deployment fails. If deployment to that instance is part of
    /// an overall
    /// deployment and the number of healthy hosts is not less than the minimum
    /// number of
    /// healthy hosts, then a deployment to the next instance is attempted.
    ///
    /// During a deployment, the CodeDeploy agent runs the scripts specified for
    /// `ApplicationStop`, `BeforeBlockTraffic`, and
    /// `AfterBlockTraffic` in the AppSpec file from the previous successful
    /// deployment. (All other scripts are run from the AppSpec file in the current
    /// deployment.)
    /// If one of these scripts contains an error and does not run successfully, the
    /// deployment
    /// can fail.
    ///
    /// If the cause of the failure is a script from the last successful deployment
    /// that will
    /// never run successfully, create a new deployment and use
    /// `ignoreApplicationStopFailures` to specify that the
    /// `ApplicationStop`, `BeforeBlockTraffic`, and
    /// `AfterBlockTraffic` failures should be ignored.
    ignore_application_stop_failures: ?bool = null,

    /// Allows you to specify information about alarms associated with a deployment.
    /// The alarm
    /// configuration that you specify here will override the alarm configuration at
    /// the
    /// deployment group level. Consider overriding the alarm configuration if you
    /// have set up
    /// alarms at the deployment group level that are causing deployment failures.
    /// In this case,
    /// you would call `CreateDeployment` to create a new deployment that uses a
    /// previous application revision that is known to work, and set its alarm
    /// configuration to
    /// turn off alarm polling. Turning off alarm polling ensures that the new
    /// deployment
    /// proceeds without being blocked by the alarm that was generated by the
    /// previous, failed,
    /// deployment.
    ///
    /// If you specify an `overrideAlarmConfiguration`, you need the
    /// `UpdateDeploymentGroup`
    /// IAM permission when calling `CreateDeployment`.
    override_alarm_configuration: ?AlarmConfiguration = null,

    /// The type and location of the revision to deploy.
    revision: ?RevisionLocation = null,

    /// Information about the instances that belong to the replacement environment
    /// in a
    /// blue/green deployment.
    target_instances: ?TargetInstances = null,

    /// Indicates whether to deploy to all instances or only to instances that are
    /// not
    /// running the latest application revision.
    update_outdated_instances_only: ?bool = null,

    pub const json_field_names = .{
        .application_name = "applicationName",
        .auto_rollback_configuration = "autoRollbackConfiguration",
        .deployment_config_name = "deploymentConfigName",
        .deployment_group_name = "deploymentGroupName",
        .deployment_mode = "deploymentMode",
        .description = "description",
        .file_exists_behavior = "fileExistsBehavior",
        .ignore_application_stop_failures = "ignoreApplicationStopFailures",
        .override_alarm_configuration = "overrideAlarmConfiguration",
        .revision = "revision",
        .target_instances = "targetInstances",
        .update_outdated_instances_only = "updateOutdatedInstancesOnly",
    };
};

pub const CreateDeploymentOutput = struct {
    /// The unique ID of a deployment.
    deployment_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .deployment_id = "deploymentId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDeploymentInput, options: CallOptions) !CreateDeploymentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDeploymentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeDeploy_20141006.CreateDeployment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDeploymentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDeploymentOutput, body, allocator);
}
