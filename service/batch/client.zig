const aws = @import("aws");
const std = @import("std");

const cancel_job = @import("cancel_job.zig");
const create_compute_environment = @import("create_compute_environment.zig");
const create_consumable_resource = @import("create_consumable_resource.zig");
const create_job_queue = @import("create_job_queue.zig");
const create_scheduling_policy = @import("create_scheduling_policy.zig");
const create_service_environment = @import("create_service_environment.zig");
const delete_compute_environment = @import("delete_compute_environment.zig");
const delete_consumable_resource = @import("delete_consumable_resource.zig");
const delete_job_queue = @import("delete_job_queue.zig");
const delete_scheduling_policy = @import("delete_scheduling_policy.zig");
const delete_service_environment = @import("delete_service_environment.zig");
const deregister_job_definition = @import("deregister_job_definition.zig");
const describe_compute_environments = @import("describe_compute_environments.zig");
const describe_consumable_resource = @import("describe_consumable_resource.zig");
const describe_job_definitions = @import("describe_job_definitions.zig");
const describe_job_queues = @import("describe_job_queues.zig");
const describe_jobs = @import("describe_jobs.zig");
const describe_scheduling_policies = @import("describe_scheduling_policies.zig");
const describe_service_environments = @import("describe_service_environments.zig");
const describe_service_job = @import("describe_service_job.zig");
const get_job_queue_snapshot = @import("get_job_queue_snapshot.zig");
const list_consumable_resources = @import("list_consumable_resources.zig");
const list_jobs = @import("list_jobs.zig");
const list_jobs_by_consumable_resource = @import("list_jobs_by_consumable_resource.zig");
const list_scheduling_policies = @import("list_scheduling_policies.zig");
const list_service_jobs = @import("list_service_jobs.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const register_job_definition = @import("register_job_definition.zig");
const submit_job = @import("submit_job.zig");
const submit_service_job = @import("submit_service_job.zig");
const tag_resource = @import("tag_resource.zig");
const terminate_job = @import("terminate_job.zig");
const terminate_service_job = @import("terminate_service_job.zig");
const untag_resource = @import("untag_resource.zig");
const update_compute_environment = @import("update_compute_environment.zig");
const update_consumable_resource = @import("update_consumable_resource.zig");
const update_job_queue = @import("update_job_queue.zig");
const update_scheduling_policy = @import("update_scheduling_policy.zig");
const update_service_environment = @import("update_service_environment.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Batch";

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

    /// Cancels a job in an Batch job queue. Jobs that are in a `SUBMITTED`,
    /// `PENDING`, or `RUNNABLE` state are cancelled and the job status is updated
    /// to `FAILED`.
    ///
    /// A `PENDING` job is canceled after all dependency jobs are completed.
    /// Therefore, it may take longer than expected to cancel a job in `PENDING`
    /// status.
    ///
    /// When you try to cancel an array parent job in `PENDING`, Batch attempts to
    /// cancel all child jobs. The array parent job is canceled when all child jobs
    /// are
    /// completed.
    ///
    /// Jobs that progressed to the `STARTING` or
    /// `RUNNING` state aren't canceled. However, the API operation still succeeds,
    /// even
    /// if no job is canceled. These jobs must be terminated with the TerminateJob
    /// operation.
    pub fn cancelJob(self: *Self, allocator: std.mem.Allocator, input: cancel_job.CancelJobInput, options: CallOptions) !cancel_job.CancelJobOutput {
        return cancel_job.execute(self, allocator, input, options);
    }

    /// Creates an Batch compute environment. You can create `MANAGED` or
    /// `UNMANAGED` compute environments. `MANAGED` compute environments can
    /// use Amazon EC2 or Fargate resources. `UNMANAGED` compute environments can
    /// only use
    /// EC2 resources.
    ///
    /// In a managed compute environment, Batch manages the capacity and instance
    /// types of the
    /// compute resources within the environment. This is based on the compute
    /// resource specification
    /// that you define or the [launch
    /// template](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html) that you
    /// specify when you create the compute environment. Either, you can choose to
    /// use EC2 On-Demand
    /// Instances and EC2 Spot Instances. Or, you can use Fargate and Fargate Spot
    /// capacity in
    /// your managed compute environment. You can optionally set a maximum price so
    /// that Spot
    /// Instances only launch when the Spot Instance price is less than a specified
    /// percentage of the
    /// On-Demand price.
    ///
    /// In an unmanaged compute environment, you can manage your own EC2 compute
    /// resources and
    /// have flexibility with how you configure your compute resources. For example,
    /// you can use
    /// custom AMIs. However, you must verify that each of your AMIs meet the Amazon
    /// ECS container instance
    /// AMI specification. For more information, see [container instance
    /// AMIs](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/container_instance_AMIs.html) in the
    /// *Amazon Elastic Container Service Developer Guide*. After you created your
    /// unmanaged compute environment,
    /// you can use the DescribeComputeEnvironments operation to find the Amazon ECS
    /// cluster that's associated with it. Then, launch your container instances
    /// into that Amazon ECS
    /// cluster. For more information, see [Launching an Amazon ECS container
    /// instance](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_container_instance.html) in the *Amazon Elastic Container Service Developer Guide*.
    ///
    /// Batch doesn't automatically upgrade the AMIs in a compute environment after
    /// it's
    /// created. For more information on how to update a compute environment's AMI,
    /// see [Updating compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the *Batch User Guide*.
    pub fn createComputeEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_compute_environment.CreateComputeEnvironmentInput, options: CallOptions) !create_compute_environment.CreateComputeEnvironmentOutput {
        return create_compute_environment.execute(self, allocator, input, options);
    }

    /// Creates an Batch consumable resource.
    pub fn createConsumableResource(self: *Self, allocator: std.mem.Allocator, input: create_consumable_resource.CreateConsumableResourceInput, options: CallOptions) !create_consumable_resource.CreateConsumableResourceOutput {
        return create_consumable_resource.execute(self, allocator, input, options);
    }

    /// Creates an Batch job queue. When you create a job queue, you associate one
    /// or more
    /// compute environments to the queue and assign an order of preference for the
    /// compute
    /// environments.
    ///
    /// You also set a priority to the job queue that determines the order that the
    /// Batch
    /// scheduler places jobs onto its associated compute environments. For example,
    /// if a compute
    /// environment is associated with more than one job queue, the job queue with a
    /// higher priority
    /// is given preference for scheduling jobs to that compute environment.
    pub fn createJobQueue(self: *Self, allocator: std.mem.Allocator, input: create_job_queue.CreateJobQueueInput, options: CallOptions) !create_job_queue.CreateJobQueueOutput {
        return create_job_queue.execute(self, allocator, input, options);
    }

    /// Creates an Batch scheduling policy.
    pub fn createSchedulingPolicy(self: *Self, allocator: std.mem.Allocator, input: create_scheduling_policy.CreateSchedulingPolicyInput, options: CallOptions) !create_scheduling_policy.CreateSchedulingPolicyOutput {
        return create_scheduling_policy.execute(self, allocator, input, options);
    }

    /// Creates a service environment for running service jobs. Service environments
    /// define capacity limits for specific service types such as SageMaker Training
    /// jobs.
    pub fn createServiceEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_service_environment.CreateServiceEnvironmentInput, options: CallOptions) !create_service_environment.CreateServiceEnvironmentOutput {
        return create_service_environment.execute(self, allocator, input, options);
    }

    /// Deletes an Batch compute environment.
    ///
    /// Before you can delete a compute environment, you must set its state to
    /// `DISABLED` with the UpdateComputeEnvironment API operation and
    /// disassociate it from any job queues with the UpdateJobQueue API operation.
    /// Compute environments that use Fargate resources must terminate all active
    /// jobs on that
    /// compute environment before deleting the compute environment. If this isn't
    /// done, the compute
    /// environment enters an invalid state.
    pub fn deleteComputeEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_compute_environment.DeleteComputeEnvironmentInput, options: CallOptions) !delete_compute_environment.DeleteComputeEnvironmentOutput {
        return delete_compute_environment.execute(self, allocator, input, options);
    }

    /// Deletes the specified consumable resource.
    pub fn deleteConsumableResource(self: *Self, allocator: std.mem.Allocator, input: delete_consumable_resource.DeleteConsumableResourceInput, options: CallOptions) !delete_consumable_resource.DeleteConsumableResourceOutput {
        return delete_consumable_resource.execute(self, allocator, input, options);
    }

    /// Deletes the specified job queue. You must first disable submissions for a
    /// queue with the
    /// UpdateJobQueue operation. All jobs in the queue are eventually terminated
    /// when you delete a job queue. The jobs are terminated at a rate of about 16
    /// jobs each
    /// second.
    ///
    /// It's not necessary to disassociate compute environments from a queue before
    /// submitting a
    /// `DeleteJobQueue` request.
    pub fn deleteJobQueue(self: *Self, allocator: std.mem.Allocator, input: delete_job_queue.DeleteJobQueueInput, options: CallOptions) !delete_job_queue.DeleteJobQueueOutput {
        return delete_job_queue.execute(self, allocator, input, options);
    }

    /// Deletes the specified scheduling policy.
    ///
    /// You can't delete a scheduling policy that's used in any job queues.
    pub fn deleteSchedulingPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_scheduling_policy.DeleteSchedulingPolicyInput, options: CallOptions) !delete_scheduling_policy.DeleteSchedulingPolicyOutput {
        return delete_scheduling_policy.execute(self, allocator, input, options);
    }

    /// Deletes a Service environment. Before you can delete a service environment,
    /// you must first set its state to `DISABLED` with the
    /// `UpdateServiceEnvironment` API operation and disassociate it from any job
    /// queues with the `UpdateJobQueue` API operation.
    pub fn deleteServiceEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_service_environment.DeleteServiceEnvironmentInput, options: CallOptions) !delete_service_environment.DeleteServiceEnvironmentOutput {
        return delete_service_environment.execute(self, allocator, input, options);
    }

    /// Deregisters an Batch job definition. Job definitions are permanently deleted
    /// after 180
    /// days.
    pub fn deregisterJobDefinition(self: *Self, allocator: std.mem.Allocator, input: deregister_job_definition.DeregisterJobDefinitionInput, options: CallOptions) !deregister_job_definition.DeregisterJobDefinitionOutput {
        return deregister_job_definition.execute(self, allocator, input, options);
    }

    /// Describes one or more of your compute environments.
    ///
    /// If you're using an unmanaged compute environment, you can use the
    /// `DescribeComputeEnvironment` operation to determine the
    /// `ecsClusterArn` that you launch your Amazon ECS container instances into.
    pub fn describeComputeEnvironments(self: *Self, allocator: std.mem.Allocator, input: describe_compute_environments.DescribeComputeEnvironmentsInput, options: CallOptions) !describe_compute_environments.DescribeComputeEnvironmentsOutput {
        return describe_compute_environments.execute(self, allocator, input, options);
    }

    /// Returns a description of the specified consumable resource.
    pub fn describeConsumableResource(self: *Self, allocator: std.mem.Allocator, input: describe_consumable_resource.DescribeConsumableResourceInput, options: CallOptions) !describe_consumable_resource.DescribeConsumableResourceOutput {
        return describe_consumable_resource.execute(self, allocator, input, options);
    }

    /// Describes a list of job definitions. You can specify a `status` (such as
    /// `ACTIVE`) to only return job definitions that match that status.
    pub fn describeJobDefinitions(self: *Self, allocator: std.mem.Allocator, input: describe_job_definitions.DescribeJobDefinitionsInput, options: CallOptions) !describe_job_definitions.DescribeJobDefinitionsOutput {
        return describe_job_definitions.execute(self, allocator, input, options);
    }

    /// Describes one or more of your job queues.
    pub fn describeJobQueues(self: *Self, allocator: std.mem.Allocator, input: describe_job_queues.DescribeJobQueuesInput, options: CallOptions) !describe_job_queues.DescribeJobQueuesOutput {
        return describe_job_queues.execute(self, allocator, input, options);
    }

    /// Describes a list of Batch jobs.
    pub fn describeJobs(self: *Self, allocator: std.mem.Allocator, input: describe_jobs.DescribeJobsInput, options: CallOptions) !describe_jobs.DescribeJobsOutput {
        return describe_jobs.execute(self, allocator, input, options);
    }

    /// Describes one or more of your scheduling policies.
    pub fn describeSchedulingPolicies(self: *Self, allocator: std.mem.Allocator, input: describe_scheduling_policies.DescribeSchedulingPoliciesInput, options: CallOptions) !describe_scheduling_policies.DescribeSchedulingPoliciesOutput {
        return describe_scheduling_policies.execute(self, allocator, input, options);
    }

    /// Describes one or more of your service environments.
    pub fn describeServiceEnvironments(self: *Self, allocator: std.mem.Allocator, input: describe_service_environments.DescribeServiceEnvironmentsInput, options: CallOptions) !describe_service_environments.DescribeServiceEnvironmentsOutput {
        return describe_service_environments.execute(self, allocator, input, options);
    }

    /// The details of a service job.
    pub fn describeServiceJob(self: *Self, allocator: std.mem.Allocator, input: describe_service_job.DescribeServiceJobInput, options: CallOptions) !describe_service_job.DescribeServiceJobOutput {
        return describe_service_job.execute(self, allocator, input, options);
    }

    /// Provides a list of the first 100 `RUNNABLE` jobs associated to a single job
    /// queue.
    pub fn getJobQueueSnapshot(self: *Self, allocator: std.mem.Allocator, input: get_job_queue_snapshot.GetJobQueueSnapshotInput, options: CallOptions) !get_job_queue_snapshot.GetJobQueueSnapshotOutput {
        return get_job_queue_snapshot.execute(self, allocator, input, options);
    }

    /// Returns a list of Batch consumable resources.
    pub fn listConsumableResources(self: *Self, allocator: std.mem.Allocator, input: list_consumable_resources.ListConsumableResourcesInput, options: CallOptions) !list_consumable_resources.ListConsumableResourcesOutput {
        return list_consumable_resources.execute(self, allocator, input, options);
    }

    /// Returns a list of Batch jobs.
    ///
    /// You must specify only one of the following items:
    ///
    /// * A job queue ID to return a list of jobs in that job queue
    ///
    /// * A multi-node parallel job ID to return a list of nodes for that job
    ///
    /// * An array job ID to return a list of the children for that job
    ///
    /// You can filter the results by job status with the `jobStatus` parameter. If
    /// you
    /// don't specify a status, only `RUNNING` jobs are returned.
    pub fn listJobs(self: *Self, allocator: std.mem.Allocator, input: list_jobs.ListJobsInput, options: CallOptions) !list_jobs.ListJobsOutput {
        return list_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of Batch jobs that require a specific consumable resource.
    pub fn listJobsByConsumableResource(self: *Self, allocator: std.mem.Allocator, input: list_jobs_by_consumable_resource.ListJobsByConsumableResourceInput, options: CallOptions) !list_jobs_by_consumable_resource.ListJobsByConsumableResourceOutput {
        return list_jobs_by_consumable_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of Batch scheduling policies.
    pub fn listSchedulingPolicies(self: *Self, allocator: std.mem.Allocator, input: list_scheduling_policies.ListSchedulingPoliciesInput, options: CallOptions) !list_scheduling_policies.ListSchedulingPoliciesOutput {
        return list_scheduling_policies.execute(self, allocator, input, options);
    }

    /// Returns a list of service jobs for a specified job queue.
    pub fn listServiceJobs(self: *Self, allocator: std.mem.Allocator, input: list_service_jobs.ListServiceJobsInput, options: CallOptions) !list_service_jobs.ListServiceJobsOutput {
        return list_service_jobs.execute(self, allocator, input, options);
    }

    /// Lists the tags for an Batch resource. Batch resources that support tags are
    /// compute environments, jobs, job definitions, job queues,
    /// and scheduling policies. ARNs for child jobs of array and multi-node
    /// parallel (MNP) jobs aren't supported.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Registers an Batch job definition.
    pub fn registerJobDefinition(self: *Self, allocator: std.mem.Allocator, input: register_job_definition.RegisterJobDefinitionInput, options: CallOptions) !register_job_definition.RegisterJobDefinitionOutput {
        return register_job_definition.execute(self, allocator, input, options);
    }

    /// Submits an Batch job from a job definition. Parameters that are specified
    /// during SubmitJob override parameters defined in the job definition. vCPU and
    /// memory
    /// requirements that are specified in the `resourceRequirements` objects in the
    /// job
    /// definition are the exception. They can't be overridden this way using the
    /// `memory`
    /// and `vcpus` parameters. Rather, you must specify updates to job definition
    /// parameters in a `resourceRequirements` object that's included in the
    /// `containerOverrides` parameter.
    ///
    /// Job queues with a scheduling policy are limited to 500 active share
    /// identifiers at
    /// a time.
    ///
    /// Jobs that run on Fargate resources can't be guaranteed to run for more than
    /// 14 days.
    /// This is because, after 14 days, Fargate resources might become unavailable
    /// and job might be
    /// terminated.
    pub fn submitJob(self: *Self, allocator: std.mem.Allocator, input: submit_job.SubmitJobInput, options: CallOptions) !submit_job.SubmitJobOutput {
        return submit_job.execute(self, allocator, input, options);
    }

    /// Submits a service job to a specified job queue to run on SageMaker AI. A
    /// service job is a unit of work that you submit to Batch for execution on
    /// SageMaker AI.
    pub fn submitServiceJob(self: *Self, allocator: std.mem.Allocator, input: submit_service_job.SubmitServiceJobInput, options: CallOptions) !submit_service_job.SubmitServiceJobOutput {
        return submit_service_job.execute(self, allocator, input, options);
    }

    /// Associates the specified tags to a resource with the specified
    /// `resourceArn`.
    /// If existing tags on a resource aren't specified in the request parameters,
    /// they aren't
    /// changed. When a resource is deleted, the tags that are associated with that
    /// resource are
    /// deleted as well. Batch resources that support tags are compute environments,
    /// jobs, job definitions, job queues,
    /// and scheduling policies. ARNs for child jobs of array and multi-node
    /// parallel (MNP) jobs aren't supported.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Terminates a job in a job queue. Jobs that are in the `STARTING` or
    /// `RUNNING` state are terminated, which causes them to transition to
    /// `FAILED`. Jobs that have not progressed to the `STARTING` state are
    /// cancelled.
    pub fn terminateJob(self: *Self, allocator: std.mem.Allocator, input: terminate_job.TerminateJobInput, options: CallOptions) !terminate_job.TerminateJobOutput {
        return terminate_job.execute(self, allocator, input, options);
    }

    /// Terminates a service job in a job queue.
    pub fn terminateServiceJob(self: *Self, allocator: std.mem.Allocator, input: terminate_service_job.TerminateServiceJobInput, options: CallOptions) !terminate_service_job.TerminateServiceJobOutput {
        return terminate_service_job.execute(self, allocator, input, options);
    }

    /// Deletes specified tags from an Batch resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an Batch compute environment.
    pub fn updateComputeEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_compute_environment.UpdateComputeEnvironmentInput, options: CallOptions) !update_compute_environment.UpdateComputeEnvironmentOutput {
        return update_compute_environment.execute(self, allocator, input, options);
    }

    /// Updates a consumable resource.
    pub fn updateConsumableResource(self: *Self, allocator: std.mem.Allocator, input: update_consumable_resource.UpdateConsumableResourceInput, options: CallOptions) !update_consumable_resource.UpdateConsumableResourceOutput {
        return update_consumable_resource.execute(self, allocator, input, options);
    }

    /// Updates a job queue.
    pub fn updateJobQueue(self: *Self, allocator: std.mem.Allocator, input: update_job_queue.UpdateJobQueueInput, options: CallOptions) !update_job_queue.UpdateJobQueueOutput {
        return update_job_queue.execute(self, allocator, input, options);
    }

    /// Updates a scheduling policy.
    pub fn updateSchedulingPolicy(self: *Self, allocator: std.mem.Allocator, input: update_scheduling_policy.UpdateSchedulingPolicyInput, options: CallOptions) !update_scheduling_policy.UpdateSchedulingPolicyOutput {
        return update_scheduling_policy.execute(self, allocator, input, options);
    }

    /// Updates a service environment. You can update the state of a service
    /// environment from `ENABLED` to `DISABLED` to prevent new service jobs from
    /// being placed in the service environment.
    pub fn updateServiceEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_service_environment.UpdateServiceEnvironmentInput, options: CallOptions) !update_service_environment.UpdateServiceEnvironmentOutput {
        return update_service_environment.execute(self, allocator, input, options);
    }

    pub fn describeComputeEnvironmentsPaginator(self: *Self, params: describe_compute_environments.DescribeComputeEnvironmentsInput) paginator.DescribeComputeEnvironmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeJobDefinitionsPaginator(self: *Self, params: describe_job_definitions.DescribeJobDefinitionsInput) paginator.DescribeJobDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeJobQueuesPaginator(self: *Self, params: describe_job_queues.DescribeJobQueuesInput) paginator.DescribeJobQueuesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeServiceEnvironmentsPaginator(self: *Self, params: describe_service_environments.DescribeServiceEnvironmentsInput) paginator.DescribeServiceEnvironmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConsumableResourcesPaginator(self: *Self, params: list_consumable_resources.ListConsumableResourcesInput) paginator.ListConsumableResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobsPaginator(self: *Self, params: list_jobs.ListJobsInput) paginator.ListJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobsByConsumableResourcePaginator(self: *Self, params: list_jobs_by_consumable_resource.ListJobsByConsumableResourceInput) paginator.ListJobsByConsumableResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSchedulingPoliciesPaginator(self: *Self, params: list_scheduling_policies.ListSchedulingPoliciesInput) paginator.ListSchedulingPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServiceJobsPaginator(self: *Self, params: list_service_jobs.ListServiceJobsInput) paginator.ListServiceJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
