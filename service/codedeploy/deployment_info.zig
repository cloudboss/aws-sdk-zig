const AutoRollbackConfiguration = @import("auto_rollback_configuration.zig").AutoRollbackConfiguration;
const BlueGreenDeploymentConfiguration = @import("blue_green_deployment_configuration.zig").BlueGreenDeploymentConfiguration;
const ComputePlatform = @import("compute_platform.zig").ComputePlatform;
const DeploymentCreator = @import("deployment_creator.zig").DeploymentCreator;
const DeploymentOverview = @import("deployment_overview.zig").DeploymentOverview;
const DeploymentStyle = @import("deployment_style.zig").DeploymentStyle;
const ErrorInformation = @import("error_information.zig").ErrorInformation;
const FileExistsBehavior = @import("file_exists_behavior.zig").FileExistsBehavior;
const LoadBalancerInfo = @import("load_balancer_info.zig").LoadBalancerInfo;
const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const RevisionLocation = @import("revision_location.zig").RevisionLocation;
const RelatedDeployments = @import("related_deployments.zig").RelatedDeployments;
const RollbackInfo = @import("rollback_info.zig").RollbackInfo;
const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;
const TargetInstances = @import("target_instances.zig").TargetInstances;

/// Information about a deployment.
pub const DeploymentInfo = struct {
    /// Provides information about the results of a deployment, such as whether
    /// instances in
    /// the original environment in a blue/green deployment were not terminated.
    additional_deployment_status_info: ?[]const u8,

    /// The application name.
    application_name: ?[]const u8,

    /// Information about the automatic rollback configuration associated with the
    /// deployment.
    auto_rollback_configuration: ?AutoRollbackConfiguration,

    /// Information about blue/green deployment options for this deployment.
    blue_green_deployment_configuration: ?BlueGreenDeploymentConfiguration,

    /// A timestamp that indicates when the deployment was complete.
    complete_time: ?i64,

    /// The destination platform type for the deployment (`Lambda`,
    /// `Server`, or `ECS`).
    compute_platform: ?ComputePlatform,

    /// A timestamp that indicates when the deployment was created.
    create_time: ?i64,

    /// The means by which the deployment was created:
    ///
    /// * `user`: A user created the deployment.
    ///
    /// * `autoscaling`: Amazon EC2 Auto Scaling created the deployment.
    ///
    /// * `codeDeployRollback`: A rollback process created the
    /// deployment.
    ///
    /// * `CodeDeployAutoUpdate`: An auto-update process created the
    /// deployment when it detected outdated Amazon EC2 instances.
    creator: ?DeploymentCreator,

    /// The deployment configuration name.
    deployment_config_name: ?[]const u8,

    /// The deployment group name.
    deployment_group_name: ?[]const u8,

    /// The unique ID of a deployment.
    deployment_id: ?[]const u8,

    /// A summary of the deployment status of the instances in the deployment.
    deployment_overview: ?DeploymentOverview,

    /// Messages that contain information about the status of a deployment.
    deployment_status_messages: ?[]const []const u8,

    /// Information about the type of deployment, either in-place or blue/green, you
    /// want to
    /// run and whether to route deployment traffic behind a load balancer.
    deployment_style: ?DeploymentStyle,

    /// A comment about the deployment.
    description: ?[]const u8,

    /// Information about any error associated with this deployment.
    error_information: ?ErrorInformation,

    /// The unique ID for an external resource (for example, a CloudFormation stack
    /// ID) that is linked to this deployment.
    external_id: ?[]const u8,

    /// Information about how CodeDeploy handles files that already exist in a
    /// deployment target location but weren't part of the previous successful
    /// deployment.
    ///
    /// * `DISALLOW`: The deployment fails. This is also the default behavior
    /// if no option is specified.
    ///
    /// * `OVERWRITE`: The version of the file from the application revision
    /// currently being deployed replaces the version already on the instance.
    ///
    /// * `RETAIN`: The version of the file already on the instance is kept
    /// and used as part of the new deployment.
    file_exists_behavior: ?FileExistsBehavior,

    /// If true, then if an `ApplicationStop`, `BeforeBlockTraffic`, or
    /// `AfterBlockTraffic` deployment lifecycle event to an instance fails, then
    /// the deployment continues to the next deployment lifecycle event. For
    /// example, if
    /// `ApplicationStop` fails, the deployment continues with DownloadBundle. If
    /// `BeforeBlockTraffic` fails, the deployment continues with
    /// `BlockTraffic`. If `AfterBlockTraffic` fails, the deployment
    /// continues with `ApplicationStop`.
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
    ignore_application_stop_failures: bool = false,

    /// Indicates whether the wait period set for the termination of instances in
    /// the original
    /// environment has started. Status is 'false' if the KEEP_ALIVE option is
    /// specified.
    /// Otherwise, 'true' as soon as the termination wait period starts.
    instance_termination_wait_time_started: bool = false,

    /// Information about the load balancer used in the deployment.
    load_balancer_info: ?LoadBalancerInfo,

    override_alarm_configuration: ?AlarmConfiguration,

    /// Information about the application revision that was deployed to the
    /// deployment group
    /// before the most recent successful deployment.
    previous_revision: ?RevisionLocation,

    related_deployments: ?RelatedDeployments,

    /// Information about the location of stored application artifacts and the
    /// service from
    /// which to retrieve them.
    revision: ?RevisionLocation,

    /// Information about a deployment rollback.
    rollback_info: ?RollbackInfo,

    /// A timestamp that indicates when the deployment was deployed to the
    /// deployment
    /// group.
    ///
    /// In some cases, the reported value of the start time might be later than the
    /// complete
    /// time. This is due to differences in the clock settings of backend servers
    /// that
    /// participate in the deployment process.
    start_time: ?i64,

    /// The current state of the deployment as a whole.
    status: ?DeploymentStatus,

    /// Information about the instances that belong to the replacement environment
    /// in a
    /// blue/green deployment.
    target_instances: ?TargetInstances,

    /// Indicates whether only instances that are not running the latest application
    /// revision
    /// are to be deployed to.
    update_outdated_instances_only: bool = false,

    pub const json_field_names = .{
        .additional_deployment_status_info = "additionalDeploymentStatusInfo",
        .application_name = "applicationName",
        .auto_rollback_configuration = "autoRollbackConfiguration",
        .blue_green_deployment_configuration = "blueGreenDeploymentConfiguration",
        .complete_time = "completeTime",
        .compute_platform = "computePlatform",
        .create_time = "createTime",
        .creator = "creator",
        .deployment_config_name = "deploymentConfigName",
        .deployment_group_name = "deploymentGroupName",
        .deployment_id = "deploymentId",
        .deployment_overview = "deploymentOverview",
        .deployment_status_messages = "deploymentStatusMessages",
        .deployment_style = "deploymentStyle",
        .description = "description",
        .error_information = "errorInformation",
        .external_id = "externalId",
        .file_exists_behavior = "fileExistsBehavior",
        .ignore_application_stop_failures = "ignoreApplicationStopFailures",
        .instance_termination_wait_time_started = "instanceTerminationWaitTimeStarted",
        .load_balancer_info = "loadBalancerInfo",
        .override_alarm_configuration = "overrideAlarmConfiguration",
        .previous_revision = "previousRevision",
        .related_deployments = "relatedDeployments",
        .revision = "revision",
        .rollback_info = "rollbackInfo",
        .start_time = "startTime",
        .status = "status",
        .target_instances = "targetInstances",
        .update_outdated_instances_only = "updateOutdatedInstancesOnly",
    };
};
