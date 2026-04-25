const ServiceDeploymentAlarms = @import("service_deployment_alarms.zig").ServiceDeploymentAlarms;
const ServiceDeploymentCircuitBreaker = @import("service_deployment_circuit_breaker.zig").ServiceDeploymentCircuitBreaker;
const DeploymentConfiguration = @import("deployment_configuration.zig").DeploymentConfiguration;
const ServiceDeploymentLifecycleStage = @import("service_deployment_lifecycle_stage.zig").ServiceDeploymentLifecycleStage;
const Rollback = @import("rollback.zig").Rollback;
const ServiceRevisionSummary = @import("service_revision_summary.zig").ServiceRevisionSummary;
const ServiceDeploymentStatus = @import("service_deployment_status.zig").ServiceDeploymentStatus;

/// Information about the service deployment.
///
/// Service deployments provide a comprehensive view of your deployments. For
/// information about service deployments, see [View service history using
/// Amazon ECS service
/// deployments](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-deployment.html) in the * Amazon Elastic Container Service Developer Guide* .
pub const ServiceDeployment = struct {
    /// The CloudWatch alarms that determine when a service deployment fails.
    alarms: ?ServiceDeploymentAlarms = null,

    /// The ARN of the cluster that hosts the service.
    cluster_arn: ?[]const u8 = null,

    /// The time the service deployment was created. The format is yyyy-MM-dd
    /// HH:mm:ss.SSSSSS.
    created_at: ?i64 = null,

    /// The circuit breaker configuration that determines a service deployment
    /// failed.
    deployment_circuit_breaker: ?ServiceDeploymentCircuitBreaker = null,

    deployment_configuration: ?DeploymentConfiguration = null,

    /// The time the service deployment finished. The format is yyyy-MM-dd
    /// HH:mm:ss.SSSSSS.
    finished_at: ?i64 = null,

    /// The current lifecycle stage of the deployment. Possible values include:
    ///
    /// * RECONCILE_SERVICE
    ///
    /// The reconciliation stage that only happens when you start a new service
    /// deployment with more than 1 service revision in an ACTIVE state.
    /// * PRE_SCALE_UP
    ///
    /// The green service revision has not started. The blue service revision is
    /// handling 100% of the production traffic. There is no test traffic.
    /// * SCALE_UP
    ///
    /// The stage when the green service revision scales up to 100% and launches new
    /// tasks. The green service revision is not serving any traffic at this point.
    /// * POST_SCALE_UP
    ///
    /// The green service revision has started. The blue service revision is
    /// handling 100% of the production traffic. There is no test traffic.
    /// * TEST_TRAFFIC_SHIFT
    ///
    /// The blue and green service revisions are running. The blue service revision
    /// handles 100% of the production traffic. The green service revision is
    /// migrating from 0% to 100% of test traffic.
    /// * POST_TEST_TRAFFIC_SHIFT
    ///
    /// The test traffic shift is complete. The green service revision handles 100%
    /// of the test traffic.
    /// * PRODUCTION_TRAFFIC_SHIFT
    ///
    /// Production traffic is shifting to the green service revision. The green
    /// service revision is migrating from 0% to 100% of production traffic.
    /// * POST_PRODUCTION_TRAFFIC_SHIFT
    ///
    /// The production traffic shift is complete.
    /// * BAKE_TIME
    ///
    /// The stage when both blue and green service revisions are running
    /// simultaneously after the production traffic has shifted.
    /// * CLEAN_UP
    ///
    /// The stage when the blue service revision has completely scaled down to 0
    /// running tasks. The green service revision is now the production service
    /// revision after this stage.
    lifecycle_stage: ?ServiceDeploymentLifecycleStage = null,

    /// The rollback options the service deployment uses when the deployment fails.
    rollback: ?Rollback = null,

    /// The ARN of the service for this service deployment.
    service_arn: ?[]const u8 = null,

    /// The ARN of the service deployment.
    service_deployment_arn: ?[]const u8 = null,

    /// The currently deployed workload configuration.
    source_service_revisions: ?[]const ServiceRevisionSummary = null,

    /// The time the service deployment statred. The format is yyyy-MM-dd
    /// HH:mm:ss.SSSSSS.
    started_at: ?i64 = null,

    /// The service deployment state.
    status: ?ServiceDeploymentStatus = null,

    /// Information about why the service deployment is in the current status. For
    /// example, the circuit breaker detected a failure.
    status_reason: ?[]const u8 = null,

    /// The time the service deployment stopped. The format is yyyy-MM-dd
    /// HH:mm:ss.SSSSSS.
    ///
    /// The service deployment stops when any of the following actions happen:
    ///
    /// * A user manually stops the deployment
    /// * The rollback option is not in use for the failure detection mechanism (the
    ///   circuit breaker or alarm-based) and the service fails.
    stopped_at: ?i64 = null,

    /// The workload configuration being deployed.
    target_service_revision: ?ServiceRevisionSummary = null,

    /// The time that the service deployment was last updated. The format is
    /// yyyy-MM-dd HH:mm:ss.SSSSSS.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .alarms = "alarms",
        .cluster_arn = "clusterArn",
        .created_at = "createdAt",
        .deployment_circuit_breaker = "deploymentCircuitBreaker",
        .deployment_configuration = "deploymentConfiguration",
        .finished_at = "finishedAt",
        .lifecycle_stage = "lifecycleStage",
        .rollback = "rollback",
        .service_arn = "serviceArn",
        .service_deployment_arn = "serviceDeploymentArn",
        .source_service_revisions = "sourceServiceRevisions",
        .started_at = "startedAt",
        .status = "status",
        .status_reason = "statusReason",
        .stopped_at = "stoppedAt",
        .target_service_revision = "targetServiceRevision",
        .updated_at = "updatedAt",
    };
};
