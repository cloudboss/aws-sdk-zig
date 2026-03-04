const aws = @import("aws");
const std = @import("std");

const create_capacity_provider = @import("create_capacity_provider.zig");
const create_cluster = @import("create_cluster.zig");
const create_express_gateway_service = @import("create_express_gateway_service.zig");
const create_service = @import("create_service.zig");
const create_task_set = @import("create_task_set.zig");
const delete_account_setting = @import("delete_account_setting.zig");
const delete_attributes = @import("delete_attributes.zig");
const delete_capacity_provider = @import("delete_capacity_provider.zig");
const delete_cluster = @import("delete_cluster.zig");
const delete_express_gateway_service = @import("delete_express_gateway_service.zig");
const delete_service = @import("delete_service.zig");
const delete_task_definitions = @import("delete_task_definitions.zig");
const delete_task_set = @import("delete_task_set.zig");
const deregister_container_instance = @import("deregister_container_instance.zig");
const deregister_task_definition = @import("deregister_task_definition.zig");
const describe_capacity_providers = @import("describe_capacity_providers.zig");
const describe_clusters = @import("describe_clusters.zig");
const describe_container_instances = @import("describe_container_instances.zig");
const describe_express_gateway_service = @import("describe_express_gateway_service.zig");
const describe_service_deployments = @import("describe_service_deployments.zig");
const describe_service_revisions = @import("describe_service_revisions.zig");
const describe_services = @import("describe_services.zig");
const describe_task_definition = @import("describe_task_definition.zig");
const describe_task_sets = @import("describe_task_sets.zig");
const describe_tasks = @import("describe_tasks.zig");
const discover_poll_endpoint = @import("discover_poll_endpoint.zig");
const execute_command = @import("execute_command.zig");
const get_task_protection = @import("get_task_protection.zig");
const list_account_settings = @import("list_account_settings.zig");
const list_attributes = @import("list_attributes.zig");
const list_clusters = @import("list_clusters.zig");
const list_container_instances = @import("list_container_instances.zig");
const list_service_deployments = @import("list_service_deployments.zig");
const list_services = @import("list_services.zig");
const list_services_by_namespace = @import("list_services_by_namespace.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_task_definition_families = @import("list_task_definition_families.zig");
const list_task_definitions = @import("list_task_definitions.zig");
const list_tasks = @import("list_tasks.zig");
const put_account_setting = @import("put_account_setting.zig");
const put_account_setting_default = @import("put_account_setting_default.zig");
const put_attributes = @import("put_attributes.zig");
const put_cluster_capacity_providers = @import("put_cluster_capacity_providers.zig");
const register_container_instance = @import("register_container_instance.zig");
const register_task_definition = @import("register_task_definition.zig");
const run_task = @import("run_task.zig");
const start_task = @import("start_task.zig");
const stop_service_deployment = @import("stop_service_deployment.zig");
const stop_task = @import("stop_task.zig");
const submit_attachment_state_changes = @import("submit_attachment_state_changes.zig");
const submit_container_state_change = @import("submit_container_state_change.zig");
const submit_task_state_change = @import("submit_task_state_change.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_capacity_provider = @import("update_capacity_provider.zig");
const update_cluster = @import("update_cluster.zig");
const update_cluster_settings = @import("update_cluster_settings.zig");
const update_container_agent = @import("update_container_agent.zig");
const update_container_instances_state = @import("update_container_instances_state.zig");
const update_express_gateway_service = @import("update_express_gateway_service.zig");
const update_service = @import("update_service.zig");
const update_service_primary_task_set = @import("update_service_primary_task_set.zig");
const update_task_protection = @import("update_task_protection.zig");
const update_task_set = @import("update_task_set.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ECS";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a capacity provider. Capacity providers are associated with a
    /// cluster and are
    /// used in capacity provider strategies to facilitate cluster auto scaling. You
    /// can create
    /// capacity providers for Amazon ECS Managed Instances and EC2 instances.
    /// Fargate has the
    /// predefined `FARGATE` and `FARGATE_SPOT` capacity providers.
    pub fn createCapacityProvider(self: *Self, allocator: std.mem.Allocator, input: create_capacity_provider.CreateCapacityProviderInput, options: CallOptions) !create_capacity_provider.CreateCapacityProviderOutput {
        return create_capacity_provider.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon ECS cluster. By default, your account receives a
    /// `default` cluster when you launch your first container instance. However,
    /// you can create your own cluster with a unique name.
    ///
    /// When you call the
    /// [CreateCluster](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateCluster.html)
    /// API operation, Amazon ECS attempts to create the Amazon ECS service-linked
    /// role for
    /// your account. This is so that it can manage required resources in other
    /// Amazon Web
    /// Services services on your behalf. However, if the user that makes the
    /// call doesn't have permissions to create the service-linked role, it isn't
    /// created.
    /// For more information, see [Using
    /// service-linked roles for Amazon
    /// ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/using-service-linked-roles.html) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    pub fn createCluster(self: *Self, allocator: std.mem.Allocator, input: create_cluster.CreateClusterInput, options: CallOptions) !create_cluster.CreateClusterOutput {
        return create_cluster.execute(self, allocator, input, options);
    }

    /// Creates an Express service that simplifies deploying containerized web
    /// applications on
    /// Amazon ECS with managed Amazon Web Services infrastructure. This operation
    /// provisions and configures
    /// Application Load Balancers, target groups, security groups, and auto-scaling
    /// policies
    /// automatically.
    ///
    /// Specify a primary container configuration with your application image and
    /// basic
    /// settings. Amazon ECS creates the necessary Amazon Web Services resources for
    /// traffic distribution, health
    /// monitoring, network access control, and capacity management.
    ///
    /// Provide an execution role for task operations and an infrastructure role for
    /// managing
    /// Amazon Web Services resources on your behalf.
    pub fn createExpressGatewayService(self: *Self, allocator: std.mem.Allocator, input: create_express_gateway_service.CreateExpressGatewayServiceInput, options: CallOptions) !create_express_gateway_service.CreateExpressGatewayServiceOutput {
        return create_express_gateway_service.execute(self, allocator, input, options);
    }

    /// Runs and maintains your desired number of tasks from a specified task
    /// definition. If
    /// the number of tasks running in a service drops below the `desiredCount`,
    /// Amazon ECS runs another copy of the task in the specified cluster. To update
    /// an existing
    /// service, use
    /// [UpdateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_UpdateService.html).
    ///
    /// On March 21, 2024, a change was made to resolve the task definition revision
    /// before authorization. When a task definition revision is not specified,
    /// authorization will occur using the latest revision of a task definition.
    ///
    /// Amazon Elastic Inference (EI) is no longer available to customers.
    ///
    /// In addition to maintaining the desired count of tasks in your service, you
    /// can
    /// optionally run your service behind one or more load balancers. The load
    /// balancers
    /// distribute traffic across the tasks that are associated with the service.
    /// For more
    /// information, see [Service load
    /// balancing](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-load-balancing.html) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    ///
    /// You can attach Amazon EBS volumes to Amazon ECS tasks by configuring the
    /// volume when
    /// creating or updating a service. `volumeConfigurations` is only supported for
    /// REPLICA service and not DAEMON service. For more information, see [Amazon
    /// EBS
    /// volumes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ebs-volumes.html#ebs-volume-types) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    ///
    /// Tasks for services that don't use a load balancer are considered healthy if
    /// they're in
    /// the `RUNNING` state. Tasks for services that use a load balancer are
    /// considered healthy if they're in the `RUNNING` state and are reported as
    /// healthy by the load balancer.
    ///
    /// There are two service scheduler strategies available:
    ///
    /// * `REPLICA` - The replica scheduling strategy places and maintains
    /// your desired number of tasks across your cluster. By default, the service
    /// scheduler spreads tasks across Availability Zones. You can use task
    /// placement
    /// strategies and constraints to customize task placement decisions. For more
    /// information, see [Service scheduler
    /// concepts](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_services.html) in the
    /// *Amazon Elastic Container Service Developer
    /// Guide*.
    ///
    /// * `DAEMON` - The daemon scheduling strategy deploys exactly one task
    /// on each active container instance that meets all of the task placement
    /// constraints that you specify in your cluster. The service scheduler also
    /// evaluates the task placement constraints for running tasks. It also stops
    /// tasks
    /// that don't meet the placement constraints. When using this strategy, you
    /// don't
    /// need to specify a desired number of tasks, a task placement strategy, or use
    /// Service Auto Scaling policies. For more information, see [Amazon ECS
    /// services](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_services.html) in the *Amazon Elastic Container
    /// Service Developer Guide*.
    ///
    /// The deployment controller is the mechanism that determines how tasks are
    /// deployed for
    /// your service. The valid options are:
    ///
    /// * ECS
    ///
    /// When you create a service which uses the `ECS` deployment
    /// controller, you can choose between the following deployment strategies
    /// (which
    /// you can set in the “`strategy`” field in
    /// “`deploymentConfiguration`”): :
    ///
    /// * `ROLLING`: When you create a service which uses the
    /// *rolling update* (`ROLLING`)
    /// deployment strategy, the Amazon ECS service scheduler replaces the
    /// currently running tasks with new tasks. The number of tasks that Amazon
    /// ECS adds or removes from the service during a rolling update is
    /// controlled by the service deployment configuration. For more
    /// information, see [Deploy Amazon ECS services by replacing
    /// tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-ecs.html) in the *Amazon Elastic Container Service
    /// Developer Guide*.
    ///
    /// Rolling update deployments are best suited for the following
    /// scenarios:
    ///
    /// * Gradual service updates: You need to update your service
    /// incrementally without taking the entire service offline at
    /// once.
    ///
    /// * Limited resource requirements: You want to avoid the
    /// additional resource costs of running two complete environments
    /// simultaneously (as required by blue/green deployments).
    ///
    /// * Acceptable deployment time: Your application can tolerate a
    /// longer deployment process, as rolling updates replace tasks one
    /// by one.
    ///
    /// * No need for instant roll back: Your service can tolerate a
    /// rollback process that takes minutes rather than seconds.
    ///
    /// * Simple deployment process: You prefer a straightforward
    /// deployment approach without the complexity of managing multiple
    /// environments, target groups, and listeners.
    ///
    /// * No load balancer requirement: Your service doesn't use or
    /// require a load balancer, Application Load Balancer, Network Load
    /// Balancer, or Service Connect (which are required for blue/green
    /// deployments).
    ///
    /// * Stateful applications: Your application maintains state that
    /// makes it difficult to run two parallel environments.
    ///
    /// * Cost sensitivity: You want to minimize deployment costs by not
    /// running duplicate environments during deployment.
    ///
    /// Rolling updates are the default deployment strategy for services and
    /// provide a balance between deployment safety and resource efficiency for
    /// many common application scenarios.
    ///
    /// * `BLUE_GREEN`: A *blue/green* deployment
    /// strategy (`BLUE_GREEN`) is a release methodology that reduces
    /// downtime and risk by running two identical production environments
    /// called blue and green. With Amazon ECS blue/green deployments, you can
    /// validate new service revisions before directing production traffic to
    /// them. This approach provides a safer way to deploy changes with the
    /// ability to quickly roll back if needed. For more information, see [Amazon
    /// ECS blue/green
    /// deployments](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-type-blue-green.html) in
    /// the *Amazon Elastic Container Service Developer
    /// Guide*.
    ///
    /// Amazon ECS blue/green deployments are best suited for the following
    /// scenarios:
    ///
    /// * Service validation: When you need to validate new service
    /// revisions before directing production traffic to them
    ///
    /// * Zero downtime: When your service requires zero-downtime
    /// deployments
    ///
    /// * Instant roll back: When you need the ability to quickly roll
    /// back if issues are detected
    ///
    /// * Load balancer requirement: When your service uses Application
    /// Load Balancer, Network Load Balancer, or Service Connect
    ///
    /// * `LINEAR`: A *linear* deployment strategy
    /// (`LINEAR`) gradually shifts traffic from the current
    /// production environment to a new environment in equal percentage
    /// increments. With Amazon ECS linear deployments, you can control the pace
    /// of traffic shifting and validate new service revisions with increasing
    /// amounts of production traffic.
    ///
    /// Linear deployments are best suited for the following scenarios:
    ///
    /// * Gradual validation: When you want to gradually validate your
    /// new service version with increasing traffic
    ///
    /// * Performance monitoring: When you need time to monitor metrics
    /// and performance during the deployment
    ///
    /// * Risk minimization: When you want to minimize risk by exposing
    /// the new version to production traffic incrementally
    ///
    /// * Load balancer requirement: When your service uses Application
    /// Load Balancer or Service Connect
    ///
    /// * `CANARY`: A *canary* deployment strategy
    /// (`CANARY`) shifts a small percentage of traffic to the
    /// new service revision first, then shifts the remaining traffic all at
    /// once after a specified time period. This allows you to test the new
    /// version with a subset of users before full deployment.
    ///
    /// Canary deployments are best suited for the following scenarios:
    ///
    /// * Feature testing: When you want to test new features with a
    /// small subset of users before full rollout
    ///
    /// * Production validation: When you need to validate performance
    /// and functionality with real production traffic
    ///
    /// * Blast radius control: When you want to minimize blast radius
    /// if issues are discovered in the new version
    ///
    /// * Load balancer requirement: When your service uses Application
    /// Load Balancer or Service Connect
    ///
    /// * External
    ///
    /// Use a third-party deployment controller.
    ///
    /// * Blue/green deployment (powered by CodeDeploy)
    ///
    /// CodeDeploy installs an updated version of the application as a new
    /// replacement task set and reroutes production traffic from the original
    /// application task set to the replacement task set. The original task set is
    /// terminated after a successful deployment. Use this deployment controller to
    /// verify a new deployment of a service before sending production traffic to
    /// it.
    ///
    /// When creating a service that uses the `EXTERNAL` deployment controller, you
    /// can specify only parameters that aren't controlled at the task set level.
    /// The only
    /// required parameter is the service name. You control your services using the
    /// [CreateTaskSet](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateTaskSet.html). For more information, see [Amazon ECS deployment types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-types.html) in the *Amazon Elastic Container
    /// Service Developer Guide*.
    ///
    /// When the service scheduler launches new tasks, it determines task placement.
    /// For
    /// information about task placement and task placement strategies, see [Amazon
    /// ECS task
    /// placement](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-placement.html) in the *Amazon Elastic Container Service
    /// Developer Guide*
    pub fn createService(self: *Self, allocator: std.mem.Allocator, input: create_service.CreateServiceInput, options: CallOptions) !create_service.CreateServiceOutput {
        return create_service.execute(self, allocator, input, options);
    }

    /// Create a task set in the specified cluster and service. This is used when a
    /// service
    /// uses the `EXTERNAL` deployment controller type. For more information, see
    /// [Amazon ECS deployment
    /// types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-types.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    ///
    /// On March 21, 2024, a change was made to resolve the task definition revision
    /// before authorization. When a task definition revision is not specified,
    /// authorization will occur using the latest revision of a task definition.
    ///
    /// For information about the maximum number of task sets and other quotas, see
    /// [Amazon ECS service
    /// quotas](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-quotas.html) in the *Amazon Elastic Container Service
    /// Developer Guide*.
    pub fn createTaskSet(self: *Self, allocator: std.mem.Allocator, input: create_task_set.CreateTaskSetInput, options: CallOptions) !create_task_set.CreateTaskSetOutput {
        return create_task_set.execute(self, allocator, input, options);
    }

    /// Disables an account setting for a specified user, role, or the root user for
    /// an
    /// account.
    pub fn deleteAccountSetting(self: *Self, allocator: std.mem.Allocator, input: delete_account_setting.DeleteAccountSettingInput, options: CallOptions) !delete_account_setting.DeleteAccountSettingOutput {
        return delete_account_setting.execute(self, allocator, input, options);
    }

    /// Deletes one or more custom attributes from an Amazon ECS resource.
    pub fn deleteAttributes(self: *Self, allocator: std.mem.Allocator, input: delete_attributes.DeleteAttributesInput, options: CallOptions) !delete_attributes.DeleteAttributesOutput {
        return delete_attributes.execute(self, allocator, input, options);
    }

    /// Deletes the specified capacity provider.
    ///
    /// The `FARGATE` and `FARGATE_SPOT` capacity providers are
    /// reserved and can't be deleted. You can disassociate them from a cluster
    /// using either
    /// [PutClusterCapacityProviders](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutClusterCapacityProviders.html) or by deleting the cluster.
    ///
    /// Prior to a capacity provider being deleted, the capacity provider must be
    /// removed from
    /// the capacity provider strategy from all services. The
    /// [UpdateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_UpdateService.html) API
    /// can be used to remove a capacity provider from a service's capacity provider
    /// strategy.
    /// When updating a service, the `forceNewDeployment` option can be used to
    /// ensure that any tasks using the Amazon EC2 instance capacity provided by the
    /// capacity
    /// provider are transitioned to use the capacity from the remaining capacity
    /// providers.
    /// Only capacity providers that aren't associated with a cluster can be
    /// deleted. To remove
    /// a capacity provider from a cluster, you can either use
    /// [PutClusterCapacityProviders](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutClusterCapacityProviders.html) or delete the cluster.
    pub fn deleteCapacityProvider(self: *Self, allocator: std.mem.Allocator, input: delete_capacity_provider.DeleteCapacityProviderInput, options: CallOptions) !delete_capacity_provider.DeleteCapacityProviderOutput {
        return delete_capacity_provider.execute(self, allocator, input, options);
    }

    /// Deletes the specified cluster. The cluster transitions to the `INACTIVE`
    /// state. Clusters with an `INACTIVE` status might remain discoverable in your
    /// account for a period of time. However, this behavior is subject to change in
    /// the future.
    /// We don't recommend that you rely on `INACTIVE` clusters persisting.
    ///
    /// You must deregister all container instances from this cluster before you may
    /// delete
    /// it. You can list the container instances in a cluster with
    /// [ListContainerInstances](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ListContainerInstances.html) and deregister them with [DeregisterContainerInstance](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DeregisterContainerInstance.html).
    pub fn deleteCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cluster.DeleteClusterInput, options: CallOptions) !delete_cluster.DeleteClusterOutput {
        return delete_cluster.execute(self, allocator, input, options);
    }

    /// Deletes an Express service and removes all associated Amazon Web Services
    /// resources. This operation
    /// stops service tasks, removes the Application Load Balancer, target groups,
    /// security groups,
    /// auto-scaling policies, and other managed infrastructure components.
    ///
    /// The service enters a `DRAINING` state where existing tasks complete current
    /// requests without starting new tasks. After all tasks stop, the service and
    /// infrastructure
    /// are permanently removed.
    ///
    /// This operation cannot be reversed. Back up important data and verify the
    /// service is no
    /// longer needed before deletion.
    pub fn deleteExpressGatewayService(self: *Self, allocator: std.mem.Allocator, input: delete_express_gateway_service.DeleteExpressGatewayServiceInput, options: CallOptions) !delete_express_gateway_service.DeleteExpressGatewayServiceOutput {
        return delete_express_gateway_service.execute(self, allocator, input, options);
    }

    /// Deletes a specified service within a cluster. You can delete a service if
    /// you have no
    /// running tasks in it and the desired task count is zero. If the service is
    /// actively
    /// maintaining tasks, you can't delete it, and you must update the service to a
    /// desired
    /// task count of zero. For more information, see
    /// [UpdateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_UpdateService.html).
    ///
    /// When you delete a service, if there are still running tasks that require
    /// cleanup,
    /// the service status moves from `ACTIVE` to `DRAINING`, and the
    /// service is no longer visible in the console or in the
    /// [ListServices](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ListServices.html)
    /// API operation. After all tasks have transitioned to either `STOPPING` or
    /// `STOPPED` status, the service status moves from `DRAINING`
    /// to `INACTIVE`. Services in the `DRAINING` or
    /// `INACTIVE` status can still be viewed with the
    /// [DescribeServices](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DescribeServices.html) API operation. However, in the future,
    /// `INACTIVE` services may be cleaned up and purged from Amazon ECS
    /// record keeping, and
    /// [DescribeServices](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DescribeServices.html) calls on those services return a
    /// `ServiceNotFoundException` error.
    ///
    /// If you attempt to create a new service with the same name as an existing
    /// service
    /// in either `ACTIVE` or `DRAINING` status, you receive an
    /// error.
    pub fn deleteService(self: *Self, allocator: std.mem.Allocator, input: delete_service.DeleteServiceInput, options: CallOptions) !delete_service.DeleteServiceOutput {
        return delete_service.execute(self, allocator, input, options);
    }

    /// Deletes one or more task definitions.
    ///
    /// You must deregister a task definition revision before you delete it. For
    /// more
    /// information, see
    /// [DeregisterTaskDefinition](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DeregisterTaskDefinition.html).
    ///
    /// When you delete a task definition revision, it is immediately transitions
    /// from the
    /// `INACTIVE` to `DELETE_IN_PROGRESS`. Existing tasks and
    /// services that reference a `DELETE_IN_PROGRESS` task definition revision
    /// continue to run without disruption. Existing services that reference a
    /// `DELETE_IN_PROGRESS` task definition revision can still scale up or down
    /// by modifying the service's desired count.
    ///
    /// You can't use a `DELETE_IN_PROGRESS` task definition revision to run new
    /// tasks or create new services. You also can't update an existing service to
    /// reference a
    /// `DELETE_IN_PROGRESS` task definition revision.
    ///
    /// A task definition revision will stay in `DELETE_IN_PROGRESS` status until
    /// all the associated tasks and services have been terminated.
    ///
    /// When you delete all `INACTIVE` task definition revisions, the task
    /// definition name is not displayed in the console and not returned in the API.
    /// If a task
    /// definition revisions are in the `DELETE_IN_PROGRESS` state, the task
    /// definition name is displayed in the console and returned in the API. The
    /// task definition
    /// name is retained by Amazon ECS and the revision is incremented the next time
    /// you create
    /// a task definition with that name.
    pub fn deleteTaskDefinitions(self: *Self, allocator: std.mem.Allocator, input: delete_task_definitions.DeleteTaskDefinitionsInput, options: CallOptions) !delete_task_definitions.DeleteTaskDefinitionsOutput {
        return delete_task_definitions.execute(self, allocator, input, options);
    }

    /// Deletes a specified task set within a service. This is used when a service
    /// uses the
    /// `EXTERNAL` deployment controller type. For more information, see [Amazon ECS
    /// deployment
    /// types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-types.html) in the *Amazon Elastic Container
    /// Service Developer Guide*.
    pub fn deleteTaskSet(self: *Self, allocator: std.mem.Allocator, input: delete_task_set.DeleteTaskSetInput, options: CallOptions) !delete_task_set.DeleteTaskSetOutput {
        return delete_task_set.execute(self, allocator, input, options);
    }

    /// Deregisters an Amazon ECS container instance from the specified cluster.
    /// This instance
    /// is no longer available to run tasks.
    ///
    /// If you intend to use the container instance for some other purpose after
    /// deregistration, we recommend that you stop all of the tasks running on the
    /// container
    /// instance before deregistration. That prevents any orphaned tasks from
    /// consuming
    /// resources.
    ///
    /// Deregistering a container instance removes the instance from a cluster, but
    /// it doesn't
    /// terminate the EC2 instance. If you are finished using the instance, be sure
    /// to terminate
    /// it in the Amazon EC2 console to stop billing.
    ///
    /// If you terminate a running container instance, Amazon ECS automatically
    /// deregisters the instance from your cluster (stopped container instances or
    /// instances
    /// with disconnected agents aren't automatically deregistered when terminated).
    pub fn deregisterContainerInstance(self: *Self, allocator: std.mem.Allocator, input: deregister_container_instance.DeregisterContainerInstanceInput, options: CallOptions) !deregister_container_instance.DeregisterContainerInstanceOutput {
        return deregister_container_instance.execute(self, allocator, input, options);
    }

    /// Deregisters the specified task definition by family and revision. Upon
    /// deregistration,
    /// the task definition is marked as `INACTIVE`. Existing tasks and services
    /// that
    /// reference an `INACTIVE` task definition continue to run without disruption.
    /// Existing services that reference an `INACTIVE` task definition can still
    /// scale up or down by modifying the service's desired count. If you want to
    /// delete a task
    /// definition revision, you must first deregister the task definition revision.
    ///
    /// You can't use an `INACTIVE` task definition to run new tasks or create new
    /// services, and you can't update an existing service to reference an
    /// `INACTIVE`
    /// task definition. However, there may be up to a 10-minute window following
    /// deregistration
    /// where these restrictions have not yet taken effect.
    ///
    /// At this time, `INACTIVE` task definitions remain discoverable in your
    /// account indefinitely. However, this behavior is subject to change in the
    /// future. We
    /// don't recommend that you rely on `INACTIVE` task definitions persisting
    /// beyond the lifecycle of any associated tasks and services.
    ///
    /// You must deregister a task definition revision before you delete it. For
    /// more
    /// information, see
    /// [DeleteTaskDefinitions](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DeleteTaskDefinitions.html).
    pub fn deregisterTaskDefinition(self: *Self, allocator: std.mem.Allocator, input: deregister_task_definition.DeregisterTaskDefinitionInput, options: CallOptions) !deregister_task_definition.DeregisterTaskDefinitionOutput {
        return deregister_task_definition.execute(self, allocator, input, options);
    }

    /// Describes one or more of your capacity providers.
    pub fn describeCapacityProviders(self: *Self, allocator: std.mem.Allocator, input: describe_capacity_providers.DescribeCapacityProvidersInput, options: CallOptions) !describe_capacity_providers.DescribeCapacityProvidersOutput {
        return describe_capacity_providers.execute(self, allocator, input, options);
    }

    /// Describes one or more of your clusters.
    ///
    /// For CLI
    /// examples, see
    /// [describe-clusters.rst](https://github.com/aws/aws-cli/blob/develop/awscli/examples/ecs/describe-clusters.rst) on GitHub.
    pub fn describeClusters(self: *Self, allocator: std.mem.Allocator, input: describe_clusters.DescribeClustersInput, options: CallOptions) !describe_clusters.DescribeClustersOutput {
        return describe_clusters.execute(self, allocator, input, options);
    }

    /// Describes one or more container instances. Returns metadata about each
    /// container
    /// instance requested.
    pub fn describeContainerInstances(self: *Self, allocator: std.mem.Allocator, input: describe_container_instances.DescribeContainerInstancesInput, options: CallOptions) !describe_container_instances.DescribeContainerInstancesOutput {
        return describe_container_instances.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about an Express service, including current
    /// status,
    /// configuration, managed infrastructure, and service revisions.
    ///
    /// Returns comprehensive service details, active service revisions, ingress
    /// paths with
    /// endpoints, and managed Amazon Web Services resource status including load
    /// balancers and auto-scaling
    /// policies.
    ///
    /// Use the `include` parameter to retrieve additional information such as
    /// resource tags.
    pub fn describeExpressGatewayService(self: *Self, allocator: std.mem.Allocator, input: describe_express_gateway_service.DescribeExpressGatewayServiceInput, options: CallOptions) !describe_express_gateway_service.DescribeExpressGatewayServiceOutput {
        return describe_express_gateway_service.execute(self, allocator, input, options);
    }

    /// Describes one or more of your service deployments.
    ///
    /// A service deployment happens when you release a software update for the
    /// service. For
    /// more information, see [View service history
    /// using Amazon ECS service
    /// deployments](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-deployment.html).
    pub fn describeServiceDeployments(self: *Self, allocator: std.mem.Allocator, input: describe_service_deployments.DescribeServiceDeploymentsInput, options: CallOptions) !describe_service_deployments.DescribeServiceDeploymentsOutput {
        return describe_service_deployments.execute(self, allocator, input, options);
    }

    /// Describes one or more service revisions.
    ///
    /// A service revision is a version of the service that includes the values for
    /// the Amazon
    /// ECS resources (for example, task definition) and the environment resources
    /// (for example,
    /// load balancers, subnets, and security groups). For more information, see
    /// [Amazon ECS service
    /// revisions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-revision.html).
    ///
    /// You can't describe a service revision that was created before October 25,
    /// 2024.
    pub fn describeServiceRevisions(self: *Self, allocator: std.mem.Allocator, input: describe_service_revisions.DescribeServiceRevisionsInput, options: CallOptions) !describe_service_revisions.DescribeServiceRevisionsOutput {
        return describe_service_revisions.execute(self, allocator, input, options);
    }

    /// Describes the specified services running in your cluster.
    pub fn describeServices(self: *Self, allocator: std.mem.Allocator, input: describe_services.DescribeServicesInput, options: CallOptions) !describe_services.DescribeServicesOutput {
        return describe_services.execute(self, allocator, input, options);
    }

    /// Describes a task definition. You can specify a `family` and
    /// `revision` to find information about a specific task definition, or you
    /// can simply specify the family to find the latest `ACTIVE` revision in that
    /// family.
    ///
    /// You can only describe `INACTIVE` task definitions while an active task
    /// or service references them.
    pub fn describeTaskDefinition(self: *Self, allocator: std.mem.Allocator, input: describe_task_definition.DescribeTaskDefinitionInput, options: CallOptions) !describe_task_definition.DescribeTaskDefinitionOutput {
        return describe_task_definition.execute(self, allocator, input, options);
    }

    /// Describes the task sets in the specified cluster and service. This is used
    /// when a
    /// service uses the `EXTERNAL` deployment controller type. For more
    /// information,
    /// see [Amazon ECS Deployment
    /// Types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-types.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    pub fn describeTaskSets(self: *Self, allocator: std.mem.Allocator, input: describe_task_sets.DescribeTaskSetsInput, options: CallOptions) !describe_task_sets.DescribeTaskSetsOutput {
        return describe_task_sets.execute(self, allocator, input, options);
    }

    /// Describes a specified task or tasks.
    ///
    /// Currently, stopped tasks appear in the returned results for at least one
    /// hour.
    ///
    /// If you have tasks with tags, and then delete the cluster, the tagged tasks
    /// are
    /// returned in the response. If you create a new cluster with the same name as
    /// the deleted
    /// cluster, the tagged tasks are not included in the response.
    pub fn describeTasks(self: *Self, allocator: std.mem.Allocator, input: describe_tasks.DescribeTasksInput, options: CallOptions) !describe_tasks.DescribeTasksOutput {
        return describe_tasks.execute(self, allocator, input, options);
    }

    /// This action is only used by the Amazon ECS agent, and it is not intended for
    /// use
    /// outside of the agent.
    ///
    /// Returns an endpoint for the Amazon ECS agent to poll for updates.
    pub fn discoverPollEndpoint(self: *Self, allocator: std.mem.Allocator, input: discover_poll_endpoint.DiscoverPollEndpointInput, options: CallOptions) !discover_poll_endpoint.DiscoverPollEndpointOutput {
        return discover_poll_endpoint.execute(self, allocator, input, options);
    }

    /// Runs a command remotely on a container within a task.
    ///
    /// If you use a condition key in your IAM policy to refine the conditions for
    /// the policy
    /// statement, for example limit the actions to a specific cluster, you receive
    /// an
    /// `AccessDeniedException` when there is a mismatch between the condition
    /// key value and the corresponding parameter value.
    ///
    /// For information about required permissions and considerations, see [Using
    /// Amazon ECS Exec for
    /// debugging](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-exec.html) in the *Amazon ECS Developer
    /// Guide*.
    pub fn executeCommand(self: *Self, allocator: std.mem.Allocator, input: execute_command.ExecuteCommandInput, options: CallOptions) !execute_command.ExecuteCommandOutput {
        return execute_command.execute(self, allocator, input, options);
    }

    /// Retrieves the protection status of tasks in an Amazon ECS service.
    pub fn getTaskProtection(self: *Self, allocator: std.mem.Allocator, input: get_task_protection.GetTaskProtectionInput, options: CallOptions) !get_task_protection.GetTaskProtectionOutput {
        return get_task_protection.execute(self, allocator, input, options);
    }

    /// Lists the account settings for a specified principal.
    pub fn listAccountSettings(self: *Self, allocator: std.mem.Allocator, input: list_account_settings.ListAccountSettingsInput, options: CallOptions) !list_account_settings.ListAccountSettingsOutput {
        return list_account_settings.execute(self, allocator, input, options);
    }

    /// Lists the attributes for Amazon ECS resources within a specified target type
    /// and
    /// cluster. When you specify a target type and cluster, `ListAttributes`
    /// returns
    /// a list of attribute objects, one for each attribute on each resource. You
    /// can filter the
    /// list of results to a single attribute name to only return results that have
    /// that name.
    /// You can also filter the results by attribute name and value. You can do
    /// this, for
    /// example, to see which container instances in a cluster are running a Linux
    /// AMI
    /// (`ecs.os-type=linux`).
    pub fn listAttributes(self: *Self, allocator: std.mem.Allocator, input: list_attributes.ListAttributesInput, options: CallOptions) !list_attributes.ListAttributesOutput {
        return list_attributes.execute(self, allocator, input, options);
    }

    /// Returns a list of existing clusters.
    pub fn listClusters(self: *Self, allocator: std.mem.Allocator, input: list_clusters.ListClustersInput, options: CallOptions) !list_clusters.ListClustersOutput {
        return list_clusters.execute(self, allocator, input, options);
    }

    /// Returns a list of container instances in a specified cluster. You can filter
    /// the
    /// results of a `ListContainerInstances` operation with cluster query language
    /// statements inside the `filter` parameter. For more information, see [Cluster
    /// Query
    /// Language](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-query-language.html) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    pub fn listContainerInstances(self: *Self, allocator: std.mem.Allocator, input: list_container_instances.ListContainerInstancesInput, options: CallOptions) !list_container_instances.ListContainerInstancesOutput {
        return list_container_instances.execute(self, allocator, input, options);
    }

    /// This operation lists all the service deployments that meet the specified
    /// filter
    /// criteria.
    ///
    /// A service deployment happens when you release a software update for the
    /// service. You
    /// route traffic from the running service revisions to the new service revison
    /// and control
    /// the number of running tasks.
    ///
    /// This API returns the values that you use for the request parameters in
    /// [DescribeServiceRevisions](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DescribeServiceRevisions.html).
    pub fn listServiceDeployments(self: *Self, allocator: std.mem.Allocator, input: list_service_deployments.ListServiceDeploymentsInput, options: CallOptions) !list_service_deployments.ListServiceDeploymentsOutput {
        return list_service_deployments.execute(self, allocator, input, options);
    }

    /// Returns a list of services. You can filter the results by cluster, launch
    /// type, and
    /// scheduling strategy.
    pub fn listServices(self: *Self, allocator: std.mem.Allocator, input: list_services.ListServicesInput, options: CallOptions) !list_services.ListServicesOutput {
        return list_services.execute(self, allocator, input, options);
    }

    /// This operation lists all of the services that are associated with a Cloud
    /// Map namespace.
    /// This list might include services in different clusters. In contrast,
    /// `ListServices` can only list services in one cluster at a time. If you
    /// need to filter the list of services in a single cluster by various
    /// parameters, use
    /// `ListServices`. For more information, see [Service
    /// Connect](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-connect.html)
    /// in the *Amazon Elastic Container Service Developer Guide*.
    pub fn listServicesByNamespace(self: *Self, allocator: std.mem.Allocator, input: list_services_by_namespace.ListServicesByNamespaceInput, options: CallOptions) !list_services_by_namespace.ListServicesByNamespaceOutput {
        return list_services_by_namespace.execute(self, allocator, input, options);
    }

    /// List the tags for an Amazon ECS resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of task definition families that are registered to your
    /// account. This
    /// list includes task definition families that no longer have any `ACTIVE` task
    /// definition revisions.
    ///
    /// You can filter out task definition families that don't contain any `ACTIVE`
    /// task definition revisions by setting the `status` parameter to
    /// `ACTIVE`. You can also filter the results with the
    /// `familyPrefix` parameter.
    pub fn listTaskDefinitionFamilies(self: *Self, allocator: std.mem.Allocator, input: list_task_definition_families.ListTaskDefinitionFamiliesInput, options: CallOptions) !list_task_definition_families.ListTaskDefinitionFamiliesOutput {
        return list_task_definition_families.execute(self, allocator, input, options);
    }

    /// Returns a list of task definitions that are registered to your account. You
    /// can filter
    /// the results by family name with the `familyPrefix` parameter or by status
    /// with the `status` parameter.
    pub fn listTaskDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_task_definitions.ListTaskDefinitionsInput, options: CallOptions) !list_task_definitions.ListTaskDefinitionsOutput {
        return list_task_definitions.execute(self, allocator, input, options);
    }

    /// Returns a list of tasks. You can filter the results by cluster, task
    /// definition
    /// family, container instance, launch type, what IAM principal started the
    /// task, or by the
    /// desired status of the task.
    ///
    /// Recently stopped tasks might appear in the returned results.
    pub fn listTasks(self: *Self, allocator: std.mem.Allocator, input: list_tasks.ListTasksInput, options: CallOptions) !list_tasks.ListTasksOutput {
        return list_tasks.execute(self, allocator, input, options);
    }

    /// Modifies an account setting. Account settings are set on a per-Region basis.
    ///
    /// If you change the root user account setting, the default settings are reset
    /// for users
    /// and roles that do not have specified individual account settings. For more
    /// information,
    /// see [Account
    /// Settings](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-account-settings.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    pub fn putAccountSetting(self: *Self, allocator: std.mem.Allocator, input: put_account_setting.PutAccountSettingInput, options: CallOptions) !put_account_setting.PutAccountSettingOutput {
        return put_account_setting.execute(self, allocator, input, options);
    }

    /// Modifies an account setting for all users on an account for whom no
    /// individual account
    /// setting has been specified. Account settings are set on a per-Region basis.
    pub fn putAccountSettingDefault(self: *Self, allocator: std.mem.Allocator, input: put_account_setting_default.PutAccountSettingDefaultInput, options: CallOptions) !put_account_setting_default.PutAccountSettingDefaultOutput {
        return put_account_setting_default.execute(self, allocator, input, options);
    }

    /// Create or update an attribute on an Amazon ECS resource. If the attribute
    /// doesn't
    /// exist, it's created. If the attribute exists, its value is replaced with the
    /// specified
    /// value. To delete an attribute, use
    /// [DeleteAttributes](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_DeleteAttributes.html). For more information, see [Attributes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-placement-constraints.html#attributes) in the *Amazon Elastic Container
    /// Service Developer Guide*.
    pub fn putAttributes(self: *Self, allocator: std.mem.Allocator, input: put_attributes.PutAttributesInput, options: CallOptions) !put_attributes.PutAttributesOutput {
        return put_attributes.execute(self, allocator, input, options);
    }

    /// Modifies the available capacity providers and the default capacity provider
    /// strategy
    /// for a cluster.
    ///
    /// You must specify both the available capacity providers and a default
    /// capacity provider
    /// strategy for the cluster. If the specified cluster has existing capacity
    /// providers
    /// associated with it, you must specify all existing capacity providers in
    /// addition to any
    /// new ones you want to add. Any existing capacity providers that are
    /// associated with a
    /// cluster that are omitted from a
    /// [PutClusterCapacityProviders](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutClusterCapacityProviders.html) API call will be disassociated with the
    /// cluster. You can only disassociate an existing capacity provider from a
    /// cluster if it's
    /// not being used by any existing tasks.
    ///
    /// When creating a service or running a task on a cluster, if no capacity
    /// provider or
    /// launch type is specified, then the cluster's default capacity provider
    /// strategy is used.
    /// We recommend that you define a default capacity provider strategy for your
    /// cluster.
    /// However, you must specify an empty array (`[]`) to bypass defining a default
    /// strategy.
    ///
    /// Amazon ECS Managed Instances doesn't support this, because when you create a
    /// capacity
    /// provider with Amazon ECS Managed Instances, it becomes available only within
    /// the
    /// specified cluster.
    pub fn putClusterCapacityProviders(self: *Self, allocator: std.mem.Allocator, input: put_cluster_capacity_providers.PutClusterCapacityProvidersInput, options: CallOptions) !put_cluster_capacity_providers.PutClusterCapacityProvidersOutput {
        return put_cluster_capacity_providers.execute(self, allocator, input, options);
    }

    /// This action is only used by the Amazon ECS agent, and it is not intended for
    /// use
    /// outside of the agent.
    ///
    /// Registers an EC2 instance into the specified cluster. This instance becomes
    /// available
    /// to place containers on.
    pub fn registerContainerInstance(self: *Self, allocator: std.mem.Allocator, input: register_container_instance.RegisterContainerInstanceInput, options: CallOptions) !register_container_instance.RegisterContainerInstanceOutput {
        return register_container_instance.execute(self, allocator, input, options);
    }

    /// Registers a new task definition from the supplied `family` and
    /// `containerDefinitions`. Optionally, you can add data volumes to your
    /// containers with the `volumes` parameter. For more information about task
    /// definition parameters and defaults, see [Amazon ECS Task
    /// Definitions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_defintions.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    ///
    /// You can specify a role for your task with the `taskRoleArn` parameter. When
    /// you specify a role for a task, its containers can then use the latest
    /// versions of the
    /// CLI or SDKs
    /// to make API requests to the Amazon Web Services services that are specified
    /// in the policy
    /// that's associated with the role. For more information, see [IAM Roles for
    /// Tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    ///
    /// You can specify a Docker networking mode for the containers in your task
    /// definition
    /// with the `networkMode` parameter. If you specify the `awsvpc`
    /// network mode, the task is allocated an elastic network interface, and you
    /// must specify a
    /// [NetworkConfiguration](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_NetworkConfiguration.html) when you create a service or run a task with the task
    /// definition. For more information, see [Task
    /// Networking](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html)
    /// in the *Amazon Elastic Container Service Developer Guide*.
    pub fn registerTaskDefinition(self: *Self, allocator: std.mem.Allocator, input: register_task_definition.RegisterTaskDefinitionInput, options: CallOptions) !register_task_definition.RegisterTaskDefinitionOutput {
        return register_task_definition.execute(self, allocator, input, options);
    }

    /// Starts a new task using the specified task definition.
    ///
    /// On March 21, 2024, a change was made to resolve the task definition revision
    /// before authorization. When a task definition revision is not specified,
    /// authorization will occur using the latest revision of a task definition.
    ///
    /// Amazon Elastic Inference (EI) is no longer available to customers.
    ///
    /// You can allow Amazon ECS to place tasks for you, or you can customize how
    /// Amazon ECS
    /// places tasks using placement constraints and placement strategies. For more
    /// information,
    /// see [Scheduling
    /// Tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/scheduling_tasks.html) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    ///
    /// Alternatively, you can use `StartTask` to use your own scheduler or place
    /// tasks manually on specific container instances.
    ///
    /// You can attach Amazon EBS volumes to Amazon ECS tasks by configuring the
    /// volume when
    /// creating or updating a service. For more information, see [Amazon EBS
    /// volumes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ebs-volumes.html#ebs-volume-types) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    ///
    /// The Amazon ECS API follows an eventual consistency model. This is because of
    /// the
    /// distributed nature of the system supporting the API. This means that the
    /// result of an
    /// API command you run that affects your Amazon ECS resources might not be
    /// immediately
    /// visible to all subsequent commands you run. Keep this in mind when you carry
    /// out an API
    /// command that immediately follows a previous API command.
    ///
    /// To manage eventual consistency, you can do the following:
    ///
    /// * Confirm the state of the resource before you run a command to modify it.
    ///   Run
    /// the DescribeTasks command using an exponential backoff algorithm to ensure
    /// that
    /// you allow enough time for the previous command to propagate through the
    /// system.
    /// To do this, run the DescribeTasks command repeatedly, starting with a couple
    /// of
    /// seconds of wait time and increasing gradually up to five minutes of wait
    /// time.
    ///
    /// * Add wait time between subsequent commands, even if the DescribeTasks
    ///   command
    /// returns an accurate response. Apply an exponential backoff algorithm
    /// starting
    /// with a couple of seconds of wait time, and increase gradually up to about
    /// five
    /// minutes of wait time.
    ///
    /// If you get a `ConflictException` error, the `RunTask` request
    /// could not be processed due to conflicts. The provided `clientToken` is
    /// already in use with a different `RunTask` request. The
    /// `resourceIds` are the existing task ARNs which are already associated
    /// with the `clientToken`.
    ///
    /// To fix this issue:
    ///
    /// * Run `RunTask` with a unique `clientToken`.
    ///
    /// * Run `RunTask` with the `clientToken` and the original
    /// set of parameters
    ///
    /// If you get a `ClientException`error, the `RunTask` could not be
    /// processed because you use managed scaling and there is a capacity error
    /// because the
    /// quota of tasks in the `PROVISIONING` per cluster has been reached. For
    /// information about the service quotas, see [Amazon ECS service
    /// quotas](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-quotas.html).
    pub fn runTask(self: *Self, allocator: std.mem.Allocator, input: run_task.RunTaskInput, options: CallOptions) !run_task.RunTaskOutput {
        return run_task.execute(self, allocator, input, options);
    }

    /// Starts a new task from the specified task definition on the specified
    /// container
    /// instance or instances.
    ///
    /// On March 21, 2024, a change was made to resolve the task definition revision
    /// before authorization. When a task definition revision is not specified,
    /// authorization will occur using the latest revision of a task definition.
    ///
    /// Amazon Elastic Inference (EI) is no longer available to customers.
    ///
    /// Alternatively, you can use`RunTask` to place tasks for you. For more
    /// information, see [Scheduling
    /// Tasks](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/scheduling_tasks.html) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    ///
    /// You can attach Amazon EBS volumes to Amazon ECS tasks by configuring the
    /// volume when
    /// creating or updating a service. For more information, see [Amazon EBS
    /// volumes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ebs-volumes.html#ebs-volume-types) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    pub fn startTask(self: *Self, allocator: std.mem.Allocator, input: start_task.StartTaskInput, options: CallOptions) !start_task.StartTaskOutput {
        return start_task.execute(self, allocator, input, options);
    }

    /// Stops an ongoing service deployment.
    ///
    /// The following stop types are avaiable:
    ///
    /// * ROLLBACK - This option rolls back the service deployment to the previous
    /// service revision.
    ///
    /// You can use this option even if you didn't configure the service deployment
    /// for the rollback option.
    ///
    /// For more information, see [Stopping Amazon
    /// ECS service
    /// deployments](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/stop-service-deployment.html) in the *Amazon Elastic Container Service
    /// Developer Guide*.
    pub fn stopServiceDeployment(self: *Self, allocator: std.mem.Allocator, input: stop_service_deployment.StopServiceDeploymentInput, options: CallOptions) !stop_service_deployment.StopServiceDeploymentOutput {
        return stop_service_deployment.execute(self, allocator, input, options);
    }

    /// Stops a running task. Any tags associated with the task will be deleted.
    ///
    /// When you call `StopTask` on a task, the equivalent of `docker
    /// stop` is issued to the containers running in the task. This results in a
    /// stop signal value and a default 30-second timeout, after which the
    /// `SIGKILL` value is sent and the containers are forcibly stopped. This
    /// signal can be defined in your container image with the `STOPSIGNAL`
    /// instruction
    /// and will default to `SIGTERM`. If the container handles the `SIGTERM`
    /// value gracefully and exits within 30 seconds from receiving it, no `SIGKILL`
    /// value
    /// is sent.
    ///
    /// For Windows containers, POSIX signals do not work and runtime stops the
    /// container by
    /// sending a `CTRL_SHUTDOWN_EVENT`. For more information, see [Unable to react
    /// to graceful shutdown
    /// of (Windows) container #25982](https://github.com/moby/moby/issues/25982) on
    /// GitHub.
    ///
    /// The default 30-second timeout can be configured on the Amazon ECS container
    /// agent
    /// with the `ECS_CONTAINER_STOP_TIMEOUT` variable. For more information, see
    /// [Amazon ECS Container Agent
    /// Configuration](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html) in the
    /// *Amazon Elastic Container Service Developer Guide*.
    pub fn stopTask(self: *Self, allocator: std.mem.Allocator, input: stop_task.StopTaskInput, options: CallOptions) !stop_task.StopTaskOutput {
        return stop_task.execute(self, allocator, input, options);
    }

    /// This action is only used by the Amazon ECS agent, and it is not intended for
    /// use
    /// outside of the agent.
    ///
    /// Sent to acknowledge that an attachment changed states.
    pub fn submitAttachmentStateChanges(self: *Self, allocator: std.mem.Allocator, input: submit_attachment_state_changes.SubmitAttachmentStateChangesInput, options: CallOptions) !submit_attachment_state_changes.SubmitAttachmentStateChangesOutput {
        return submit_attachment_state_changes.execute(self, allocator, input, options);
    }

    /// This action is only used by the Amazon ECS agent, and it is not intended for
    /// use
    /// outside of the agent.
    ///
    /// Sent to acknowledge that a container changed states.
    pub fn submitContainerStateChange(self: *Self, allocator: std.mem.Allocator, input: submit_container_state_change.SubmitContainerStateChangeInput, options: CallOptions) !submit_container_state_change.SubmitContainerStateChangeOutput {
        return submit_container_state_change.execute(self, allocator, input, options);
    }

    /// This action is only used by the Amazon ECS agent, and it is not intended for
    /// use
    /// outside of the agent.
    ///
    /// Sent to acknowledge that a task changed states.
    pub fn submitTaskStateChange(self: *Self, allocator: std.mem.Allocator, input: submit_task_state_change.SubmitTaskStateChangeInput, options: CallOptions) !submit_task_state_change.SubmitTaskStateChangeOutput {
        return submit_task_state_change.execute(self, allocator, input, options);
    }

    /// Associates the specified tags to a resource with the specified
    /// `resourceArn`. If existing tags on a resource aren't specified in the
    /// request parameters, they aren't changed. When a resource is deleted, the
    /// tags that are
    /// associated with that resource are deleted as well.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes specified tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Modifies the parameters for a capacity provider.
    ///
    /// These changes only apply to new Amazon ECS Managed Instances, or EC2
    /// instances, not
    /// existing ones.
    pub fn updateCapacityProvider(self: *Self, allocator: std.mem.Allocator, input: update_capacity_provider.UpdateCapacityProviderInput, options: CallOptions) !update_capacity_provider.UpdateCapacityProviderOutput {
        return update_capacity_provider.execute(self, allocator, input, options);
    }

    /// Updates the cluster.
    pub fn updateCluster(self: *Self, allocator: std.mem.Allocator, input: update_cluster.UpdateClusterInput, options: CallOptions) !update_cluster.UpdateClusterOutput {
        return update_cluster.execute(self, allocator, input, options);
    }

    /// Modifies the settings to use for a cluster.
    pub fn updateClusterSettings(self: *Self, allocator: std.mem.Allocator, input: update_cluster_settings.UpdateClusterSettingsInput, options: CallOptions) !update_cluster_settings.UpdateClusterSettingsOutput {
        return update_cluster_settings.execute(self, allocator, input, options);
    }

    /// Updates the Amazon ECS container agent on a specified container instance.
    /// Updating the
    /// Amazon ECS container agent doesn't interrupt running tasks or services on
    /// the container
    /// instance. The process for updating the agent differs depending on whether
    /// your container
    /// instance was launched with the Amazon ECS-optimized AMI or another operating
    /// system.
    ///
    /// The `UpdateContainerAgent` API isn't supported for container instances
    /// using the Amazon ECS-optimized Amazon Linux 2 (arm64) AMI. To update the
    /// container
    /// agent, you can update the `ecs-init` package. This updates the agent. For
    /// more information, see [Updating the
    /// Amazon ECS container
    /// agent](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/agent-update-ecs-ami.html) in the *Amazon Elastic Container
    /// Service Developer Guide*.
    ///
    /// Agent updates with the `UpdateContainerAgent` API operation do not
    /// apply to Windows container instances. We recommend that you launch new
    /// container
    /// instances to update the agent version in your Windows clusters.
    ///
    /// The `UpdateContainerAgent` API requires an Amazon ECS-optimized AMI or
    /// Amazon Linux AMI with the `ecs-init` service installed and running. For help
    /// updating the Amazon ECS container agent on other operating systems, see
    /// [Manually updating the Amazon ECS container
    /// agent](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-update.html#manually_update_agent) in the *Amazon
    /// Elastic Container Service Developer Guide*.
    pub fn updateContainerAgent(self: *Self, allocator: std.mem.Allocator, input: update_container_agent.UpdateContainerAgentInput, options: CallOptions) !update_container_agent.UpdateContainerAgentOutput {
        return update_container_agent.execute(self, allocator, input, options);
    }

    /// Modifies the status of an Amazon ECS container instance.
    ///
    /// Once a container instance has reached an `ACTIVE` state, you can change the
    /// status of a container instance to `DRAINING` to manually remove an instance
    /// from a cluster, for example to perform system updates, update the Docker
    /// daemon, or
    /// scale down the cluster size.
    ///
    /// A container instance can't be changed to `DRAINING` until it has
    /// reached an `ACTIVE` status. If the instance is in any other status, an
    /// error will be received.
    ///
    /// When you set a container instance to `DRAINING`, Amazon ECS prevents new
    /// tasks from being scheduled for placement on the container instance and
    /// replacement
    /// service tasks are started on other container instances in the cluster if the
    /// resources
    /// are available. Service tasks on the container instance that are in the
    /// `PENDING` state are stopped immediately.
    ///
    /// Service tasks on the container instance that are in the `RUNNING` state are
    /// stopped and replaced according to the service's deployment configuration
    /// parameters,
    /// `minimumHealthyPercent` and `maximumPercent`. You can change
    /// the deployment configuration of your service using
    /// [UpdateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_UpdateService.html).
    ///
    /// * If `minimumHealthyPercent` is below 100%, the scheduler can ignore
    /// `desiredCount` temporarily during task replacement. For example,
    /// `desiredCount` is four tasks, a minimum of 50% allows the
    /// scheduler to stop two existing tasks before starting two new tasks. If the
    /// minimum is 100%, the service scheduler can't remove existing tasks until the
    /// replacement tasks are considered healthy. Tasks for services that do not use
    /// a
    /// load balancer are considered healthy if they're in the `RUNNING`
    /// state. Tasks for services that use a load balancer are considered healthy if
    /// they're in the `RUNNING` state and are reported as healthy by the
    /// load balancer.
    ///
    /// * The `maximumPercent` parameter represents an upper limit on the
    /// number of running tasks during task replacement. You can use this to define
    /// the
    /// replacement batch size. For example, if `desiredCount` is four tasks,
    /// a maximum of 200% starts four new tasks before stopping the four tasks to be
    /// drained, provided that the cluster resources required to do this are
    /// available.
    /// If the maximum is 100%, then replacement tasks can't start until the
    /// draining
    /// tasks have stopped.
    ///
    /// Any `PENDING` or `RUNNING` tasks that do not belong to a service
    /// aren't affected. You must wait for them to finish or stop them manually.
    ///
    /// A container instance has completed draining when it has no more `RUNNING`
    /// tasks. You can verify this using
    /// [ListTasks](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ListTasks.html).
    ///
    /// When a container instance has been drained, you can set a container instance
    /// to
    /// `ACTIVE` status and once it has reached that status the Amazon ECS
    /// scheduler can begin scheduling tasks on the instance again.
    pub fn updateContainerInstancesState(self: *Self, allocator: std.mem.Allocator, input: update_container_instances_state.UpdateContainerInstancesStateInput, options: CallOptions) !update_container_instances_state.UpdateContainerInstancesStateOutput {
        return update_container_instances_state.execute(self, allocator, input, options);
    }

    /// Updates an existing Express service configuration. Modifies container
    /// settings, resource
    /// allocation, auto-scaling configuration, and other service parameters without
    /// recreating the
    /// service.
    ///
    /// Amazon ECS creates a new service revision with updated configuration and
    /// performs a rolling
    /// deployment to replace existing tasks. The service remains available during
    /// updates,
    /// ensuring zero-downtime deployments.
    ///
    /// Some parameters like the infrastructure role cannot be modified after
    /// service creation
    /// and require creating a new service.
    pub fn updateExpressGatewayService(self: *Self, allocator: std.mem.Allocator, input: update_express_gateway_service.UpdateExpressGatewayServiceInput, options: CallOptions) !update_express_gateway_service.UpdateExpressGatewayServiceOutput {
        return update_express_gateway_service.execute(self, allocator, input, options);
    }

    /// Modifies the parameters of a service.
    ///
    /// On March 21, 2024, a change was made to resolve the task definition revision
    /// before authorization. When a task definition revision is not specified,
    /// authorization will occur using the latest revision of a task definition.
    ///
    /// For services using the rolling update (`ECS`) you can update the desired
    /// count, deployment configuration, network configuration, load balancers,
    /// service
    /// registries, enable ECS managed tags option, propagate tags option, task
    /// placement
    /// constraints and strategies, and task definition. When you update any of
    /// these
    /// parameters, Amazon ECS starts new tasks with the new configuration.
    ///
    /// You can attach Amazon EBS volumes to Amazon ECS tasks by configuring the
    /// volume when
    /// starting or running a task, or when creating or updating a service. For more
    /// information, see [Amazon EBS
    /// volumes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ebs-volumes.html#ebs-volume-types) in the *Amazon Elastic
    /// Container Service Developer Guide*. You can update your volume
    /// configurations and trigger a new deployment. `volumeConfigurations` is only
    /// supported for REPLICA service and not DAEMON service. If you leave
    /// `volumeConfigurations`
    /// `null`, it doesn't trigger a new deployment. For more information on
    /// volumes,
    /// see [Amazon EBS
    /// volumes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ebs-volumes.html#ebs-volume-types) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    ///
    /// For services using the blue/green (`CODE_DEPLOY`) deployment controller,
    /// only the desired count, deployment configuration, health check grace period,
    /// task
    /// placement constraints and strategies, enable ECS managed tags option, and
    /// propagate tags
    /// can be updated using this API. If the network configuration, platform
    /// version, task
    /// definition, or load balancer need to be updated, create a new CodeDeploy
    /// deployment. For
    /// more information, see
    /// [CreateDeployment](https://docs.aws.amazon.com/codedeploy/latest/APIReference/API_CreateDeployment.html) in the *CodeDeploy API
    /// Reference*.
    ///
    /// For services using an external deployment controller, you can update only
    /// the desired
    /// count, task placement constraints and strategies, health check grace period,
    /// enable ECS
    /// managed tags option, and propagate tags option, using this API. If the
    /// launch type, load
    /// balancer, network configuration, platform version, or task definition need
    /// to be
    /// updated, create a new task set For more information, see
    /// [CreateTaskSet](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_CreateTaskSet.html).
    ///
    /// You can add to or subtract from the number of instantiations of a task
    /// definition in a
    /// service by specifying the cluster that the service is running in and a new
    /// `desiredCount` parameter.
    ///
    /// You can attach Amazon EBS volumes to Amazon ECS tasks by configuring the
    /// volume when
    /// starting or running a task, or when creating or updating a service. For more
    /// information, see [Amazon EBS
    /// volumes](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ebs-volumes.html#ebs-volume-types) in the *Amazon Elastic
    /// Container Service Developer Guide*.
    ///
    /// If you have updated the container image of your application, you can create
    /// a new task
    /// definition with that image and deploy it to your service. The service
    /// scheduler uses the
    /// minimum healthy percent and maximum percent parameters (in the service's
    /// deployment
    /// configuration) to determine the deployment strategy.
    ///
    /// If your updated Docker image uses the same tag as what is in the existing
    /// task
    /// definition for your service (for example, `my_image:latest`), you don't
    /// need to create a new revision of your task definition. You can update the
    /// service
    /// using the `forceNewDeployment` option. The new tasks launched by the
    /// deployment pull the current image/tag combination from your repository when
    /// they
    /// start.
    ///
    /// You can also update the deployment configuration of a service. When a
    /// deployment is
    /// triggered by updating the task definition of a service, the service
    /// scheduler uses the
    /// deployment configuration parameters, `minimumHealthyPercent` and
    /// `maximumPercent`, to determine the deployment strategy.
    ///
    /// * If `minimumHealthyPercent` is below 100%, the scheduler can ignore
    /// `desiredCount` temporarily during a deployment. For example, if
    /// `desiredCount` is four tasks, a minimum of 50% allows the
    /// scheduler to stop two existing tasks before starting two new tasks. Tasks
    /// for
    /// services that don't use a load balancer are considered healthy if they're in
    /// the
    /// `RUNNING` state. Tasks for services that use a load balancer are
    /// considered healthy if they're in the `RUNNING` state and are reported
    /// as healthy by the load balancer.
    ///
    /// * The `maximumPercent` parameter represents an upper limit on the
    /// number of running tasks during a deployment. You can use it to define the
    /// deployment batch size. For example, if `desiredCount` is four tasks,
    /// a maximum of 200% starts four new tasks before stopping the four older tasks
    /// (provided that the cluster resources required to do this are available).
    ///
    /// When
    /// [UpdateService](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_UpdateService.html)
    /// stops a task during a deployment, the equivalent of `docker stop` is issued
    /// to the containers running in the task. This results in a `SIGTERM` and a
    /// 30-second timeout. After this, `SIGKILL` is sent and the containers are
    /// forcibly stopped. If the container handles the `SIGTERM` gracefully and
    /// exits
    /// within 30 seconds from receiving it, no `SIGKILL` is sent.
    ///
    /// When the service scheduler launches new tasks, it determines task placement
    /// in your
    /// cluster with the following logic.
    ///
    /// * Determine which of the container instances in your cluster can support
    ///   your
    /// service's task definition. For example, they have the required CPU, memory,
    /// ports, and container instance attributes.
    ///
    /// * By default, the service scheduler attempts to balance tasks across
    /// Availability Zones in this manner even though you can choose a different
    /// placement strategy.
    ///
    /// * Sort the valid container instances by the fewest number of running
    /// tasks for this service in the same Availability Zone as the instance.
    /// For example, if zone A has one running service task and zones B and C
    /// each have zero, valid container instances in either zone B or C are
    /// considered optimal for placement.
    ///
    /// * Place the new service task on a valid container instance in an optimal
    /// Availability Zone (based on the previous steps), favoring container
    /// instances with the fewest number of running tasks for this
    /// service.
    ///
    /// When the service scheduler stops running tasks, it attempts to maintain
    /// balance across
    /// the Availability Zones in your cluster using the following logic:
    ///
    /// * Sort the container instances by the largest number of running tasks for
    ///   this
    /// service in the same Availability Zone as the instance. For example, if zone
    /// A
    /// has one running service task and zones B and C each have two, container
    /// instances in either zone B or C are considered optimal for termination.
    ///
    /// * Stop the task on a container instance in an optimal Availability Zone
    ///   (based
    /// on the previous steps), favoring container instances with the largest number
    /// of
    /// running tasks for this service.
    pub fn updateService(self: *Self, allocator: std.mem.Allocator, input: update_service.UpdateServiceInput, options: CallOptions) !update_service.UpdateServiceOutput {
        return update_service.execute(self, allocator, input, options);
    }

    /// Modifies which task set in a service is the primary task set. Any parameters
    /// that are
    /// updated on the primary task set in a service will transition to the service.
    /// This is
    /// used when a service uses the `EXTERNAL` deployment controller type. For more
    /// information, see [Amazon ECS Deployment
    /// Types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-types.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    pub fn updateServicePrimaryTaskSet(self: *Self, allocator: std.mem.Allocator, input: update_service_primary_task_set.UpdateServicePrimaryTaskSetInput, options: CallOptions) !update_service_primary_task_set.UpdateServicePrimaryTaskSetOutput {
        return update_service_primary_task_set.execute(self, allocator, input, options);
    }

    /// Updates the protection status of a task. You can set `protectionEnabled` to
    /// `true` to protect your task from termination during scale-in events from
    /// [Service
    /// Autoscaling](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-auto-scaling.html) or [deployments](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-types.html).
    ///
    /// Task-protection, by default, expires after 2 hours at which point Amazon ECS
    /// clears
    /// the `protectionEnabled` property making the task eligible for termination by
    /// a subsequent scale-in event.
    ///
    /// You can specify a custom expiration period for task protection from 1 minute
    /// to up to
    /// 2,880 minutes (48 hours). To specify the custom expiration period, set the
    /// `expiresInMinutes` property. The `expiresInMinutes` property
    /// is always reset when you invoke this operation for a task that already has
    /// `protectionEnabled` set to `true`. You can keep extending the
    /// protection expiration period of a task by invoking this operation
    /// repeatedly.
    ///
    /// To learn more about Amazon ECS task protection, see [Task scale-in
    /// protection](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-scale-in-protection.html) in the *
    /// Amazon Elastic Container Service
    /// Developer Guide*
    /// .
    ///
    /// This operation is only supported for tasks belonging to an Amazon ECS
    /// service.
    /// Invoking this operation for a standalone task will result in an
    /// `TASK_NOT_VALID` failure. For more information, see [API failure
    /// reasons](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/api_failures_messages.html).
    ///
    /// If you prefer to set task protection from within the container, we recommend
    /// using
    /// the [Task scale-in protection
    /// endpoint](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-scale-in-protection-endpoint.html).
    pub fn updateTaskProtection(self: *Self, allocator: std.mem.Allocator, input: update_task_protection.UpdateTaskProtectionInput, options: CallOptions) !update_task_protection.UpdateTaskProtectionOutput {
        return update_task_protection.execute(self, allocator, input, options);
    }

    /// Modifies a task set. This is used when a service uses the `EXTERNAL`
    /// deployment controller type. For more information, see [Amazon ECS Deployment
    /// Types](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-types.html) in the *Amazon Elastic Container Service Developer
    /// Guide*.
    pub fn updateTaskSet(self: *Self, allocator: std.mem.Allocator, input: update_task_set.UpdateTaskSetInput, options: CallOptions) !update_task_set.UpdateTaskSetOutput {
        return update_task_set.execute(self, allocator, input, options);
    }

    pub fn listAccountSettingsPaginator(self: *Self, params: list_account_settings.ListAccountSettingsInput) paginator.ListAccountSettingsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAttributesPaginator(self: *Self, params: list_attributes.ListAttributesInput) paginator.ListAttributesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listClustersPaginator(self: *Self, params: list_clusters.ListClustersInput) paginator.ListClustersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listContainerInstancesPaginator(self: *Self, params: list_container_instances.ListContainerInstancesInput) paginator.ListContainerInstancesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listServicesPaginator(self: *Self, params: list_services.ListServicesInput) paginator.ListServicesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listServicesByNamespacePaginator(self: *Self, params: list_services_by_namespace.ListServicesByNamespaceInput) paginator.ListServicesByNamespacePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTaskDefinitionFamiliesPaginator(self: *Self, params: list_task_definition_families.ListTaskDefinitionFamiliesInput) paginator.ListTaskDefinitionFamiliesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTaskDefinitionsPaginator(self: *Self, params: list_task_definitions.ListTaskDefinitionsInput) paginator.ListTaskDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTasksPaginator(self: *Self, params: list_tasks.ListTasksInput) paginator.ListTasksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
