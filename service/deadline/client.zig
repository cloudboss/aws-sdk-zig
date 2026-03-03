const aws = @import("aws");
const std = @import("std");

const associate_member_to_farm = @import("associate_member_to_farm.zig");
const associate_member_to_fleet = @import("associate_member_to_fleet.zig");
const associate_member_to_job = @import("associate_member_to_job.zig");
const associate_member_to_queue = @import("associate_member_to_queue.zig");
const assume_fleet_role_for_read = @import("assume_fleet_role_for_read.zig");
const assume_fleet_role_for_worker = @import("assume_fleet_role_for_worker.zig");
const assume_queue_role_for_read = @import("assume_queue_role_for_read.zig");
const assume_queue_role_for_user = @import("assume_queue_role_for_user.zig");
const assume_queue_role_for_worker = @import("assume_queue_role_for_worker.zig");
const batch_get_job_entity = @import("batch_get_job_entity.zig");
const copy_job_template = @import("copy_job_template.zig");
const create_budget = @import("create_budget.zig");
const create_farm = @import("create_farm.zig");
const create_fleet = @import("create_fleet.zig");
const create_job = @import("create_job.zig");
const create_license_endpoint = @import("create_license_endpoint.zig");
const create_limit = @import("create_limit.zig");
const create_monitor = @import("create_monitor.zig");
const create_queue = @import("create_queue.zig");
const create_queue_environment = @import("create_queue_environment.zig");
const create_queue_fleet_association = @import("create_queue_fleet_association.zig");
const create_queue_limit_association = @import("create_queue_limit_association.zig");
const create_storage_profile = @import("create_storage_profile.zig");
const create_worker = @import("create_worker.zig");
const delete_budget = @import("delete_budget.zig");
const delete_farm = @import("delete_farm.zig");
const delete_fleet = @import("delete_fleet.zig");
const delete_license_endpoint = @import("delete_license_endpoint.zig");
const delete_limit = @import("delete_limit.zig");
const delete_metered_product = @import("delete_metered_product.zig");
const delete_monitor = @import("delete_monitor.zig");
const delete_queue = @import("delete_queue.zig");
const delete_queue_environment = @import("delete_queue_environment.zig");
const delete_queue_fleet_association = @import("delete_queue_fleet_association.zig");
const delete_queue_limit_association = @import("delete_queue_limit_association.zig");
const delete_storage_profile = @import("delete_storage_profile.zig");
const delete_worker = @import("delete_worker.zig");
const disassociate_member_from_farm = @import("disassociate_member_from_farm.zig");
const disassociate_member_from_fleet = @import("disassociate_member_from_fleet.zig");
const disassociate_member_from_job = @import("disassociate_member_from_job.zig");
const disassociate_member_from_queue = @import("disassociate_member_from_queue.zig");
const get_budget = @import("get_budget.zig");
const get_farm = @import("get_farm.zig");
const get_fleet = @import("get_fleet.zig");
const get_job = @import("get_job.zig");
const get_license_endpoint = @import("get_license_endpoint.zig");
const get_limit = @import("get_limit.zig");
const get_monitor = @import("get_monitor.zig");
const get_queue = @import("get_queue.zig");
const get_queue_environment = @import("get_queue_environment.zig");
const get_queue_fleet_association = @import("get_queue_fleet_association.zig");
const get_queue_limit_association = @import("get_queue_limit_association.zig");
const get_session = @import("get_session.zig");
const get_session_action = @import("get_session_action.zig");
const get_sessions_statistics_aggregation = @import("get_sessions_statistics_aggregation.zig");
const get_step = @import("get_step.zig");
const get_storage_profile = @import("get_storage_profile.zig");
const get_storage_profile_for_queue = @import("get_storage_profile_for_queue.zig");
const get_task = @import("get_task.zig");
const get_worker = @import("get_worker.zig");
const list_available_metered_products = @import("list_available_metered_products.zig");
const list_budgets = @import("list_budgets.zig");
const list_farm_members = @import("list_farm_members.zig");
const list_farms = @import("list_farms.zig");
const list_fleet_members = @import("list_fleet_members.zig");
const list_fleets = @import("list_fleets.zig");
const list_job_members = @import("list_job_members.zig");
const list_job_parameter_definitions = @import("list_job_parameter_definitions.zig");
const list_jobs = @import("list_jobs.zig");
const list_license_endpoints = @import("list_license_endpoints.zig");
const list_limits = @import("list_limits.zig");
const list_metered_products = @import("list_metered_products.zig");
const list_monitors = @import("list_monitors.zig");
const list_queue_environments = @import("list_queue_environments.zig");
const list_queue_fleet_associations = @import("list_queue_fleet_associations.zig");
const list_queue_limit_associations = @import("list_queue_limit_associations.zig");
const list_queue_members = @import("list_queue_members.zig");
const list_queues = @import("list_queues.zig");
const list_session_actions = @import("list_session_actions.zig");
const list_sessions = @import("list_sessions.zig");
const list_sessions_for_worker = @import("list_sessions_for_worker.zig");
const list_step_consumers = @import("list_step_consumers.zig");
const list_step_dependencies = @import("list_step_dependencies.zig");
const list_steps = @import("list_steps.zig");
const list_storage_profiles = @import("list_storage_profiles.zig");
const list_storage_profiles_for_queue = @import("list_storage_profiles_for_queue.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_tasks = @import("list_tasks.zig");
const list_workers = @import("list_workers.zig");
const put_metered_product = @import("put_metered_product.zig");
const search_jobs = @import("search_jobs.zig");
const search_steps = @import("search_steps.zig");
const search_tasks = @import("search_tasks.zig");
const search_workers = @import("search_workers.zig");
const start_sessions_statistics_aggregation = @import("start_sessions_statistics_aggregation.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_budget = @import("update_budget.zig");
const update_farm = @import("update_farm.zig");
const update_fleet = @import("update_fleet.zig");
const update_job = @import("update_job.zig");
const update_limit = @import("update_limit.zig");
const update_monitor = @import("update_monitor.zig");
const update_queue = @import("update_queue.zig");
const update_queue_environment = @import("update_queue_environment.zig");
const update_queue_fleet_association = @import("update_queue_fleet_association.zig");
const update_queue_limit_association = @import("update_queue_limit_association.zig");
const update_session = @import("update_session.zig");
const update_step = @import("update_step.zig");
const update_storage_profile = @import("update_storage_profile.zig");
const update_task = @import("update_task.zig");
const update_worker = @import("update_worker.zig");
const update_worker_schedule = @import("update_worker_schedule.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "deadline";

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

    /// Assigns a farm membership level to a member.
    pub fn associateMemberToFarm(self: *Self, allocator: std.mem.Allocator, input: associate_member_to_farm.AssociateMemberToFarmInput, options: CallOptions) !associate_member_to_farm.AssociateMemberToFarmOutput {
        return associate_member_to_farm.execute(self, allocator, input, options);
    }

    /// Assigns a fleet membership level to a member.
    pub fn associateMemberToFleet(self: *Self, allocator: std.mem.Allocator, input: associate_member_to_fleet.AssociateMemberToFleetInput, options: CallOptions) !associate_member_to_fleet.AssociateMemberToFleetOutput {
        return associate_member_to_fleet.execute(self, allocator, input, options);
    }

    /// Assigns a job membership level to a member
    pub fn associateMemberToJob(self: *Self, allocator: std.mem.Allocator, input: associate_member_to_job.AssociateMemberToJobInput, options: CallOptions) !associate_member_to_job.AssociateMemberToJobOutput {
        return associate_member_to_job.execute(self, allocator, input, options);
    }

    /// Assigns a queue membership level to a member
    pub fn associateMemberToQueue(self: *Self, allocator: std.mem.Allocator, input: associate_member_to_queue.AssociateMemberToQueueInput, options: CallOptions) !associate_member_to_queue.AssociateMemberToQueueOutput {
        return associate_member_to_queue.execute(self, allocator, input, options);
    }

    /// Get Amazon Web Services credentials from the fleet role. The IAM permissions
    /// of the credentials are scoped down to have read-only access.
    pub fn assumeFleetRoleForRead(self: *Self, allocator: std.mem.Allocator, input: assume_fleet_role_for_read.AssumeFleetRoleForReadInput, options: CallOptions) !assume_fleet_role_for_read.AssumeFleetRoleForReadOutput {
        return assume_fleet_role_for_read.execute(self, allocator, input, options);
    }

    /// Get credentials from the fleet role for a worker.
    pub fn assumeFleetRoleForWorker(self: *Self, allocator: std.mem.Allocator, input: assume_fleet_role_for_worker.AssumeFleetRoleForWorkerInput, options: CallOptions) !assume_fleet_role_for_worker.AssumeFleetRoleForWorkerOutput {
        return assume_fleet_role_for_worker.execute(self, allocator, input, options);
    }

    /// Gets Amazon Web Services credentials from the queue role. The IAM
    /// permissions of the credentials are scoped down to have read-only access.
    pub fn assumeQueueRoleForRead(self: *Self, allocator: std.mem.Allocator, input: assume_queue_role_for_read.AssumeQueueRoleForReadInput, options: CallOptions) !assume_queue_role_for_read.AssumeQueueRoleForReadOutput {
        return assume_queue_role_for_read.execute(self, allocator, input, options);
    }

    /// Allows a user to assume a role for a queue.
    pub fn assumeQueueRoleForUser(self: *Self, allocator: std.mem.Allocator, input: assume_queue_role_for_user.AssumeQueueRoleForUserInput, options: CallOptions) !assume_queue_role_for_user.AssumeQueueRoleForUserOutput {
        return assume_queue_role_for_user.execute(self, allocator, input, options);
    }

    /// Allows a worker to assume a queue role.
    pub fn assumeQueueRoleForWorker(self: *Self, allocator: std.mem.Allocator, input: assume_queue_role_for_worker.AssumeQueueRoleForWorkerInput, options: CallOptions) !assume_queue_role_for_worker.AssumeQueueRoleForWorkerOutput {
        return assume_queue_role_for_worker.execute(self, allocator, input, options);
    }

    /// Get batched job details for a worker.
    pub fn batchGetJobEntity(self: *Self, allocator: std.mem.Allocator, input: batch_get_job_entity.BatchGetJobEntityInput, options: CallOptions) !batch_get_job_entity.BatchGetJobEntityOutput {
        return batch_get_job_entity.execute(self, allocator, input, options);
    }

    /// Copies a job template to an Amazon S3 bucket.
    pub fn copyJobTemplate(self: *Self, allocator: std.mem.Allocator, input: copy_job_template.CopyJobTemplateInput, options: CallOptions) !copy_job_template.CopyJobTemplateOutput {
        return copy_job_template.execute(self, allocator, input, options);
    }

    /// Creates a budget to set spending thresholds for your rendering activity.
    pub fn createBudget(self: *Self, allocator: std.mem.Allocator, input: create_budget.CreateBudgetInput, options: CallOptions) !create_budget.CreateBudgetOutput {
        return create_budget.execute(self, allocator, input, options);
    }

    /// Creates a farm to allow space for queues and fleets. Farms are the space
    /// where the components of your renders gather and are pieced together in the
    /// cloud. Farms contain budgets and allow you to enforce permissions. Deadline
    /// Cloud farms are a useful container for large projects.
    pub fn createFarm(self: *Self, allocator: std.mem.Allocator, input: create_farm.CreateFarmInput, options: CallOptions) !create_farm.CreateFarmOutput {
        return create_farm.execute(self, allocator, input, options);
    }

    /// Creates a fleet. Fleets gather information relating to compute, or capacity,
    /// for renders within your farms. You can choose to manage your own capacity or
    /// opt to have fleets fully managed by Deadline Cloud.
    pub fn createFleet(self: *Self, allocator: std.mem.Allocator, input: create_fleet.CreateFleetInput, options: CallOptions) !create_fleet.CreateFleetOutput {
        return create_fleet.execute(self, allocator, input, options);
    }

    /// Creates a job. A job is a set of instructions that Deadline Cloud uses to
    /// schedule and run work on available workers. For more information, see
    /// [Deadline Cloud
    /// jobs](https://docs.aws.amazon.com/deadline-cloud/latest/userguide/deadline-cloud-jobs.html).
    pub fn createJob(self: *Self, allocator: std.mem.Allocator, input: create_job.CreateJobInput, options: CallOptions) !create_job.CreateJobOutput {
        return create_job.execute(self, allocator, input, options);
    }

    /// Creates a license endpoint to integrate your various licensed software used
    /// for rendering on Deadline Cloud.
    pub fn createLicenseEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_license_endpoint.CreateLicenseEndpointInput, options: CallOptions) !create_license_endpoint.CreateLicenseEndpointOutput {
        return create_license_endpoint.execute(self, allocator, input, options);
    }

    /// Creates a limit that manages the distribution of shared resources, such as
    /// floating licenses. A limit can throttle work assignments, help manage
    /// workloads, and track current usage. Before you use a limit, you must
    /// associate the limit with one or more queues.
    ///
    /// You must add the `amountRequirementName` to a step in a job template to
    /// declare the limit requirement.
    pub fn createLimit(self: *Self, allocator: std.mem.Allocator, input: create_limit.CreateLimitInput, options: CallOptions) !create_limit.CreateLimitOutput {
        return create_limit.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Web Services Deadline Cloud monitor that you can use to
    /// view your farms, queues, and fleets. After you submit a job, you can track
    /// the progress of the tasks and steps that make up the job, and then download
    /// the job's results.
    pub fn createMonitor(self: *Self, allocator: std.mem.Allocator, input: create_monitor.CreateMonitorInput, options: CallOptions) !create_monitor.CreateMonitorOutput {
        return create_monitor.execute(self, allocator, input, options);
    }

    /// Creates a queue to coordinate the order in which jobs run on a farm. A queue
    /// can also specify where to pull resources and indicate where to output
    /// completed jobs.
    pub fn createQueue(self: *Self, allocator: std.mem.Allocator, input: create_queue.CreateQueueInput, options: CallOptions) !create_queue.CreateQueueOutput {
        return create_queue.execute(self, allocator, input, options);
    }

    /// Creates an environment for a queue that defines how jobs in the queue run.
    pub fn createQueueEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_queue_environment.CreateQueueEnvironmentInput, options: CallOptions) !create_queue_environment.CreateQueueEnvironmentOutput {
        return create_queue_environment.execute(self, allocator, input, options);
    }

    /// Creates an association between a queue and a fleet.
    pub fn createQueueFleetAssociation(self: *Self, allocator: std.mem.Allocator, input: create_queue_fleet_association.CreateQueueFleetAssociationInput, options: CallOptions) !create_queue_fleet_association.CreateQueueFleetAssociationOutput {
        return create_queue_fleet_association.execute(self, allocator, input, options);
    }

    /// Associates a limit with a particular queue. After the limit is associated,
    /// all workers for jobs that specify the limit associated with the queue are
    /// subject to the limit. You can't associate two limits with the same
    /// `amountRequirementName` to the same queue.
    pub fn createQueueLimitAssociation(self: *Self, allocator: std.mem.Allocator, input: create_queue_limit_association.CreateQueueLimitAssociationInput, options: CallOptions) !create_queue_limit_association.CreateQueueLimitAssociationOutput {
        return create_queue_limit_association.execute(self, allocator, input, options);
    }

    /// Creates a storage profile that specifies the operating system, file type,
    /// and file location of resources used on a farm.
    pub fn createStorageProfile(self: *Self, allocator: std.mem.Allocator, input: create_storage_profile.CreateStorageProfileInput, options: CallOptions) !create_storage_profile.CreateStorageProfileOutput {
        return create_storage_profile.execute(self, allocator, input, options);
    }

    /// Creates a worker. A worker tells your instance how much processing power
    /// (vCPU), and memory (GiB) you’ll need to assemble the digital assets held
    /// within a particular instance. You can specify certain instance types to use,
    /// or let the worker know which instances types to exclude.
    ///
    /// Deadline Cloud limits the number of workers to less than or equal to the
    /// fleet's maximum worker count. The service maintains eventual consistency for
    /// the worker count. If you make multiple rapid calls to `CreateWorker` before
    /// the field updates, you might exceed your fleet's maximum worker count. For
    /// example, if your `maxWorkerCount` is 10 and you currently have 9 workers,
    /// making two quick `CreateWorker` calls might successfully create 2 workers
    /// instead of 1, resulting in 11 total workers.
    pub fn createWorker(self: *Self, allocator: std.mem.Allocator, input: create_worker.CreateWorkerInput, options: CallOptions) !create_worker.CreateWorkerOutput {
        return create_worker.execute(self, allocator, input, options);
    }

    /// Deletes a budget.
    pub fn deleteBudget(self: *Self, allocator: std.mem.Allocator, input: delete_budget.DeleteBudgetInput, options: CallOptions) !delete_budget.DeleteBudgetOutput {
        return delete_budget.execute(self, allocator, input, options);
    }

    /// Deletes a farm.
    pub fn deleteFarm(self: *Self, allocator: std.mem.Allocator, input: delete_farm.DeleteFarmInput, options: CallOptions) !delete_farm.DeleteFarmOutput {
        return delete_farm.execute(self, allocator, input, options);
    }

    /// Deletes a fleet.
    pub fn deleteFleet(self: *Self, allocator: std.mem.Allocator, input: delete_fleet.DeleteFleetInput, options: CallOptions) !delete_fleet.DeleteFleetOutput {
        return delete_fleet.execute(self, allocator, input, options);
    }

    /// Deletes a license endpoint.
    pub fn deleteLicenseEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_license_endpoint.DeleteLicenseEndpointInput, options: CallOptions) !delete_license_endpoint.DeleteLicenseEndpointOutput {
        return delete_license_endpoint.execute(self, allocator, input, options);
    }

    /// Removes a limit from the specified farm. Before you delete a limit you must
    /// use the `DeleteQueueLimitAssociation` operation to remove the association
    /// with any queues.
    pub fn deleteLimit(self: *Self, allocator: std.mem.Allocator, input: delete_limit.DeleteLimitInput, options: CallOptions) !delete_limit.DeleteLimitOutput {
        return delete_limit.execute(self, allocator, input, options);
    }

    /// Deletes a metered product.
    pub fn deleteMeteredProduct(self: *Self, allocator: std.mem.Allocator, input: delete_metered_product.DeleteMeteredProductInput, options: CallOptions) !delete_metered_product.DeleteMeteredProductOutput {
        return delete_metered_product.execute(self, allocator, input, options);
    }

    /// Removes a Deadline Cloud monitor. After you delete a monitor, you can create
    /// a new one and attach farms to the monitor.
    pub fn deleteMonitor(self: *Self, allocator: std.mem.Allocator, input: delete_monitor.DeleteMonitorInput, options: CallOptions) !delete_monitor.DeleteMonitorOutput {
        return delete_monitor.execute(self, allocator, input, options);
    }

    /// Deletes a queue.
    ///
    /// You can't recover the jobs in a queue if you delete the queue. Deleting the
    /// queue also deletes the jobs in that queue.
    pub fn deleteQueue(self: *Self, allocator: std.mem.Allocator, input: delete_queue.DeleteQueueInput, options: CallOptions) !delete_queue.DeleteQueueOutput {
        return delete_queue.execute(self, allocator, input, options);
    }

    /// Deletes a queue environment.
    pub fn deleteQueueEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_queue_environment.DeleteQueueEnvironmentInput, options: CallOptions) !delete_queue_environment.DeleteQueueEnvironmentOutput {
        return delete_queue_environment.execute(self, allocator, input, options);
    }

    /// Deletes a queue-fleet association.
    pub fn deleteQueueFleetAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_queue_fleet_association.DeleteQueueFleetAssociationInput, options: CallOptions) !delete_queue_fleet_association.DeleteQueueFleetAssociationOutput {
        return delete_queue_fleet_association.execute(self, allocator, input, options);
    }

    /// Removes the association between a queue and a limit. You must use the
    /// `UpdateQueueLimitAssociation` operation to set the status to
    /// `STOP_LIMIT_USAGE_AND_COMPLETE_TASKS` or
    /// `STOP_LIMIT_USAGE_AND_CANCEL_TASKS`. The status does not change immediately.
    /// Use the `GetQueueLimitAssociation` operation to see if the status changed to
    /// `STOPPED` before deleting the association.
    pub fn deleteQueueLimitAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_queue_limit_association.DeleteQueueLimitAssociationInput, options: CallOptions) !delete_queue_limit_association.DeleteQueueLimitAssociationOutput {
        return delete_queue_limit_association.execute(self, allocator, input, options);
    }

    /// Deletes a storage profile.
    pub fn deleteStorageProfile(self: *Self, allocator: std.mem.Allocator, input: delete_storage_profile.DeleteStorageProfileInput, options: CallOptions) !delete_storage_profile.DeleteStorageProfileOutput {
        return delete_storage_profile.execute(self, allocator, input, options);
    }

    /// Deletes a worker.
    pub fn deleteWorker(self: *Self, allocator: std.mem.Allocator, input: delete_worker.DeleteWorkerInput, options: CallOptions) !delete_worker.DeleteWorkerOutput {
        return delete_worker.execute(self, allocator, input, options);
    }

    /// Disassociates a member from a farm.
    pub fn disassociateMemberFromFarm(self: *Self, allocator: std.mem.Allocator, input: disassociate_member_from_farm.DisassociateMemberFromFarmInput, options: CallOptions) !disassociate_member_from_farm.DisassociateMemberFromFarmOutput {
        return disassociate_member_from_farm.execute(self, allocator, input, options);
    }

    /// Disassociates a member from a fleet.
    pub fn disassociateMemberFromFleet(self: *Self, allocator: std.mem.Allocator, input: disassociate_member_from_fleet.DisassociateMemberFromFleetInput, options: CallOptions) !disassociate_member_from_fleet.DisassociateMemberFromFleetOutput {
        return disassociate_member_from_fleet.execute(self, allocator, input, options);
    }

    /// Disassociates a member from a job.
    pub fn disassociateMemberFromJob(self: *Self, allocator: std.mem.Allocator, input: disassociate_member_from_job.DisassociateMemberFromJobInput, options: CallOptions) !disassociate_member_from_job.DisassociateMemberFromJobOutput {
        return disassociate_member_from_job.execute(self, allocator, input, options);
    }

    /// Disassociates a member from a queue.
    pub fn disassociateMemberFromQueue(self: *Self, allocator: std.mem.Allocator, input: disassociate_member_from_queue.DisassociateMemberFromQueueInput, options: CallOptions) !disassociate_member_from_queue.DisassociateMemberFromQueueOutput {
        return disassociate_member_from_queue.execute(self, allocator, input, options);
    }

    /// Get a budget.
    pub fn getBudget(self: *Self, allocator: std.mem.Allocator, input: get_budget.GetBudgetInput, options: CallOptions) !get_budget.GetBudgetOutput {
        return get_budget.execute(self, allocator, input, options);
    }

    /// Get a farm.
    pub fn getFarm(self: *Self, allocator: std.mem.Allocator, input: get_farm.GetFarmInput, options: CallOptions) !get_farm.GetFarmOutput {
        return get_farm.execute(self, allocator, input, options);
    }

    /// Get a fleet.
    pub fn getFleet(self: *Self, allocator: std.mem.Allocator, input: get_fleet.GetFleetInput, options: CallOptions) !get_fleet.GetFleetOutput {
        return get_fleet.execute(self, allocator, input, options);
    }

    /// Gets a Deadline Cloud job.
    pub fn getJob(self: *Self, allocator: std.mem.Allocator, input: get_job.GetJobInput, options: CallOptions) !get_job.GetJobOutput {
        return get_job.execute(self, allocator, input, options);
    }

    /// Gets a licence endpoint.
    pub fn getLicenseEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_license_endpoint.GetLicenseEndpointInput, options: CallOptions) !get_license_endpoint.GetLicenseEndpointOutput {
        return get_license_endpoint.execute(self, allocator, input, options);
    }

    /// Gets information about a specific limit.
    pub fn getLimit(self: *Self, allocator: std.mem.Allocator, input: get_limit.GetLimitInput, options: CallOptions) !get_limit.GetLimitOutput {
        return get_limit.execute(self, allocator, input, options);
    }

    /// Gets information about the specified monitor.
    pub fn getMonitor(self: *Self, allocator: std.mem.Allocator, input: get_monitor.GetMonitorInput, options: CallOptions) !get_monitor.GetMonitorOutput {
        return get_monitor.execute(self, allocator, input, options);
    }

    /// Gets a queue.
    pub fn getQueue(self: *Self, allocator: std.mem.Allocator, input: get_queue.GetQueueInput, options: CallOptions) !get_queue.GetQueueOutput {
        return get_queue.execute(self, allocator, input, options);
    }

    /// Gets a queue environment.
    pub fn getQueueEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_queue_environment.GetQueueEnvironmentInput, options: CallOptions) !get_queue_environment.GetQueueEnvironmentOutput {
        return get_queue_environment.execute(self, allocator, input, options);
    }

    /// Gets a queue-fleet association.
    pub fn getQueueFleetAssociation(self: *Self, allocator: std.mem.Allocator, input: get_queue_fleet_association.GetQueueFleetAssociationInput, options: CallOptions) !get_queue_fleet_association.GetQueueFleetAssociationOutput {
        return get_queue_fleet_association.execute(self, allocator, input, options);
    }

    /// Gets information about a specific association between a queue and a limit.
    pub fn getQueueLimitAssociation(self: *Self, allocator: std.mem.Allocator, input: get_queue_limit_association.GetQueueLimitAssociationInput, options: CallOptions) !get_queue_limit_association.GetQueueLimitAssociationOutput {
        return get_queue_limit_association.execute(self, allocator, input, options);
    }

    /// Gets a session.
    pub fn getSession(self: *Self, allocator: std.mem.Allocator, input: get_session.GetSessionInput, options: CallOptions) !get_session.GetSessionOutput {
        return get_session.execute(self, allocator, input, options);
    }

    /// Gets a session action for the job.
    pub fn getSessionAction(self: *Self, allocator: std.mem.Allocator, input: get_session_action.GetSessionActionInput, options: CallOptions) !get_session_action.GetSessionActionOutput {
        return get_session_action.execute(self, allocator, input, options);
    }

    /// Gets a set of statistics for queues or farms. Before you can call the
    /// `GetSessionStatisticsAggregation` operation, you must first call the
    /// `StartSessionsStatisticsAggregation` operation. Statistics are available for
    /// 1 hour after you call the `StartSessionsStatisticsAggregation` operation.
    pub fn getSessionsStatisticsAggregation(self: *Self, allocator: std.mem.Allocator, input: get_sessions_statistics_aggregation.GetSessionsStatisticsAggregationInput, options: CallOptions) !get_sessions_statistics_aggregation.GetSessionsStatisticsAggregationOutput {
        return get_sessions_statistics_aggregation.execute(self, allocator, input, options);
    }

    /// Gets a step.
    pub fn getStep(self: *Self, allocator: std.mem.Allocator, input: get_step.GetStepInput, options: CallOptions) !get_step.GetStepOutput {
        return get_step.execute(self, allocator, input, options);
    }

    /// Gets a storage profile.
    pub fn getStorageProfile(self: *Self, allocator: std.mem.Allocator, input: get_storage_profile.GetStorageProfileInput, options: CallOptions) !get_storage_profile.GetStorageProfileOutput {
        return get_storage_profile.execute(self, allocator, input, options);
    }

    /// Gets a storage profile for a queue.
    pub fn getStorageProfileForQueue(self: *Self, allocator: std.mem.Allocator, input: get_storage_profile_for_queue.GetStorageProfileForQueueInput, options: CallOptions) !get_storage_profile_for_queue.GetStorageProfileForQueueOutput {
        return get_storage_profile_for_queue.execute(self, allocator, input, options);
    }

    /// Gets a task.
    pub fn getTask(self: *Self, allocator: std.mem.Allocator, input: get_task.GetTaskInput, options: CallOptions) !get_task.GetTaskOutput {
        return get_task.execute(self, allocator, input, options);
    }

    /// Gets a worker.
    pub fn getWorker(self: *Self, allocator: std.mem.Allocator, input: get_worker.GetWorkerInput, options: CallOptions) !get_worker.GetWorkerOutput {
        return get_worker.execute(self, allocator, input, options);
    }

    /// A list of the available metered products.
    pub fn listAvailableMeteredProducts(self: *Self, allocator: std.mem.Allocator, input: list_available_metered_products.ListAvailableMeteredProductsInput, options: CallOptions) !list_available_metered_products.ListAvailableMeteredProductsOutput {
        return list_available_metered_products.execute(self, allocator, input, options);
    }

    /// A list of budgets in a farm.
    pub fn listBudgets(self: *Self, allocator: std.mem.Allocator, input: list_budgets.ListBudgetsInput, options: CallOptions) !list_budgets.ListBudgetsOutput {
        return list_budgets.execute(self, allocator, input, options);
    }

    /// Lists the members of a farm.
    pub fn listFarmMembers(self: *Self, allocator: std.mem.Allocator, input: list_farm_members.ListFarmMembersInput, options: CallOptions) !list_farm_members.ListFarmMembersOutput {
        return list_farm_members.execute(self, allocator, input, options);
    }

    /// Lists farms.
    pub fn listFarms(self: *Self, allocator: std.mem.Allocator, input: list_farms.ListFarmsInput, options: CallOptions) !list_farms.ListFarmsOutput {
        return list_farms.execute(self, allocator, input, options);
    }

    /// Lists fleet members.
    pub fn listFleetMembers(self: *Self, allocator: std.mem.Allocator, input: list_fleet_members.ListFleetMembersInput, options: CallOptions) !list_fleet_members.ListFleetMembersOutput {
        return list_fleet_members.execute(self, allocator, input, options);
    }

    /// Lists fleets.
    pub fn listFleets(self: *Self, allocator: std.mem.Allocator, input: list_fleets.ListFleetsInput, options: CallOptions) !list_fleets.ListFleetsOutput {
        return list_fleets.execute(self, allocator, input, options);
    }

    /// Lists members on a job.
    pub fn listJobMembers(self: *Self, allocator: std.mem.Allocator, input: list_job_members.ListJobMembersInput, options: CallOptions) !list_job_members.ListJobMembersOutput {
        return list_job_members.execute(self, allocator, input, options);
    }

    /// Lists parameter definitions of a job.
    pub fn listJobParameterDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_job_parameter_definitions.ListJobParameterDefinitionsInput, options: CallOptions) !list_job_parameter_definitions.ListJobParameterDefinitionsOutput {
        return list_job_parameter_definitions.execute(self, allocator, input, options);
    }

    /// Lists jobs.
    pub fn listJobs(self: *Self, allocator: std.mem.Allocator, input: list_jobs.ListJobsInput, options: CallOptions) !list_jobs.ListJobsOutput {
        return list_jobs.execute(self, allocator, input, options);
    }

    /// Lists license endpoints.
    pub fn listLicenseEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_license_endpoints.ListLicenseEndpointsInput, options: CallOptions) !list_license_endpoints.ListLicenseEndpointsOutput {
        return list_license_endpoints.execute(self, allocator, input, options);
    }

    /// Gets a list of limits defined in the specified farm.
    pub fn listLimits(self: *Self, allocator: std.mem.Allocator, input: list_limits.ListLimitsInput, options: CallOptions) !list_limits.ListLimitsOutput {
        return list_limits.execute(self, allocator, input, options);
    }

    /// Lists metered products.
    pub fn listMeteredProducts(self: *Self, allocator: std.mem.Allocator, input: list_metered_products.ListMeteredProductsInput, options: CallOptions) !list_metered_products.ListMeteredProductsOutput {
        return list_metered_products.execute(self, allocator, input, options);
    }

    /// Gets a list of your monitors in Deadline Cloud.
    pub fn listMonitors(self: *Self, allocator: std.mem.Allocator, input: list_monitors.ListMonitorsInput, options: CallOptions) !list_monitors.ListMonitorsOutput {
        return list_monitors.execute(self, allocator, input, options);
    }

    /// Lists queue environments.
    pub fn listQueueEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_queue_environments.ListQueueEnvironmentsInput, options: CallOptions) !list_queue_environments.ListQueueEnvironmentsOutput {
        return list_queue_environments.execute(self, allocator, input, options);
    }

    /// Lists queue-fleet associations.
    pub fn listQueueFleetAssociations(self: *Self, allocator: std.mem.Allocator, input: list_queue_fleet_associations.ListQueueFleetAssociationsInput, options: CallOptions) !list_queue_fleet_associations.ListQueueFleetAssociationsOutput {
        return list_queue_fleet_associations.execute(self, allocator, input, options);
    }

    /// Gets a list of the associations between queues and limits defined in a farm.
    pub fn listQueueLimitAssociations(self: *Self, allocator: std.mem.Allocator, input: list_queue_limit_associations.ListQueueLimitAssociationsInput, options: CallOptions) !list_queue_limit_associations.ListQueueLimitAssociationsOutput {
        return list_queue_limit_associations.execute(self, allocator, input, options);
    }

    /// Lists the members in a queue.
    pub fn listQueueMembers(self: *Self, allocator: std.mem.Allocator, input: list_queue_members.ListQueueMembersInput, options: CallOptions) !list_queue_members.ListQueueMembersOutput {
        return list_queue_members.execute(self, allocator, input, options);
    }

    /// Lists queues.
    pub fn listQueues(self: *Self, allocator: std.mem.Allocator, input: list_queues.ListQueuesInput, options: CallOptions) !list_queues.ListQueuesOutput {
        return list_queues.execute(self, allocator, input, options);
    }

    /// Lists session actions.
    pub fn listSessionActions(self: *Self, allocator: std.mem.Allocator, input: list_session_actions.ListSessionActionsInput, options: CallOptions) !list_session_actions.ListSessionActionsOutput {
        return list_session_actions.execute(self, allocator, input, options);
    }

    /// Lists sessions.
    pub fn listSessions(self: *Self, allocator: std.mem.Allocator, input: list_sessions.ListSessionsInput, options: CallOptions) !list_sessions.ListSessionsOutput {
        return list_sessions.execute(self, allocator, input, options);
    }

    /// Lists sessions for a worker.
    pub fn listSessionsForWorker(self: *Self, allocator: std.mem.Allocator, input: list_sessions_for_worker.ListSessionsForWorkerInput, options: CallOptions) !list_sessions_for_worker.ListSessionsForWorkerOutput {
        return list_sessions_for_worker.execute(self, allocator, input, options);
    }

    /// Lists step consumers.
    pub fn listStepConsumers(self: *Self, allocator: std.mem.Allocator, input: list_step_consumers.ListStepConsumersInput, options: CallOptions) !list_step_consumers.ListStepConsumersOutput {
        return list_step_consumers.execute(self, allocator, input, options);
    }

    /// Lists the dependencies for a step.
    pub fn listStepDependencies(self: *Self, allocator: std.mem.Allocator, input: list_step_dependencies.ListStepDependenciesInput, options: CallOptions) !list_step_dependencies.ListStepDependenciesOutput {
        return list_step_dependencies.execute(self, allocator, input, options);
    }

    /// Lists steps for a job.
    pub fn listSteps(self: *Self, allocator: std.mem.Allocator, input: list_steps.ListStepsInput, options: CallOptions) !list_steps.ListStepsOutput {
        return list_steps.execute(self, allocator, input, options);
    }

    /// Lists storage profiles.
    pub fn listStorageProfiles(self: *Self, allocator: std.mem.Allocator, input: list_storage_profiles.ListStorageProfilesInput, options: CallOptions) !list_storage_profiles.ListStorageProfilesOutput {
        return list_storage_profiles.execute(self, allocator, input, options);
    }

    /// Lists storage profiles for a queue.
    pub fn listStorageProfilesForQueue(self: *Self, allocator: std.mem.Allocator, input: list_storage_profiles_for_queue.ListStorageProfilesForQueueInput, options: CallOptions) !list_storage_profiles_for_queue.ListStorageProfilesForQueueOutput {
        return list_storage_profiles_for_queue.execute(self, allocator, input, options);
    }

    /// Lists tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists tasks for a job.
    pub fn listTasks(self: *Self, allocator: std.mem.Allocator, input: list_tasks.ListTasksInput, options: CallOptions) !list_tasks.ListTasksOutput {
        return list_tasks.execute(self, allocator, input, options);
    }

    /// Lists workers.
    pub fn listWorkers(self: *Self, allocator: std.mem.Allocator, input: list_workers.ListWorkersInput, options: CallOptions) !list_workers.ListWorkersOutput {
        return list_workers.execute(self, allocator, input, options);
    }

    /// Adds a metered product.
    pub fn putMeteredProduct(self: *Self, allocator: std.mem.Allocator, input: put_metered_product.PutMeteredProductInput, options: CallOptions) !put_metered_product.PutMeteredProductOutput {
        return put_metered_product.execute(self, allocator, input, options);
    }

    /// Searches for jobs.
    pub fn searchJobs(self: *Self, allocator: std.mem.Allocator, input: search_jobs.SearchJobsInput, options: CallOptions) !search_jobs.SearchJobsOutput {
        return search_jobs.execute(self, allocator, input, options);
    }

    /// Searches for steps.
    pub fn searchSteps(self: *Self, allocator: std.mem.Allocator, input: search_steps.SearchStepsInput, options: CallOptions) !search_steps.SearchStepsOutput {
        return search_steps.execute(self, allocator, input, options);
    }

    /// Searches for tasks.
    pub fn searchTasks(self: *Self, allocator: std.mem.Allocator, input: search_tasks.SearchTasksInput, options: CallOptions) !search_tasks.SearchTasksOutput {
        return search_tasks.execute(self, allocator, input, options);
    }

    /// Searches for workers.
    pub fn searchWorkers(self: *Self, allocator: std.mem.Allocator, input: search_workers.SearchWorkersInput, options: CallOptions) !search_workers.SearchWorkersOutput {
        return search_workers.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous request for getting aggregated statistics about
    /// queues and farms. Get the statistics using the
    /// `GetSessionsStatisticsAggregation` operation. You can only have one running
    /// aggregation for your Deadline Cloud farm. Call the
    /// `GetSessionsStatisticsAggregation` operation and check the `status` field to
    /// see if an aggregation is running. Statistics are available for 1 hour after
    /// you call the `StartSessionsStatisticsAggregation` operation.
    pub fn startSessionsStatisticsAggregation(self: *Self, allocator: std.mem.Allocator, input: start_sessions_statistics_aggregation.StartSessionsStatisticsAggregationInput, options: CallOptions) !start_sessions_statistics_aggregation.StartSessionsStatisticsAggregationOutput {
        return start_sessions_statistics_aggregation.execute(self, allocator, input, options);
    }

    /// Tags a resource using the resource's ARN and desired tags.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource using the resource's ARN and tag to remove.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a budget that sets spending thresholds for rendering activity.
    pub fn updateBudget(self: *Self, allocator: std.mem.Allocator, input: update_budget.UpdateBudgetInput, options: CallOptions) !update_budget.UpdateBudgetOutput {
        return update_budget.execute(self, allocator, input, options);
    }

    /// Updates a farm.
    pub fn updateFarm(self: *Self, allocator: std.mem.Allocator, input: update_farm.UpdateFarmInput, options: CallOptions) !update_farm.UpdateFarmOutput {
        return update_farm.execute(self, allocator, input, options);
    }

    /// Updates a fleet.
    pub fn updateFleet(self: *Self, allocator: std.mem.Allocator, input: update_fleet.UpdateFleetInput, options: CallOptions) !update_fleet.UpdateFleetOutput {
        return update_fleet.execute(self, allocator, input, options);
    }

    /// Updates a job.
    ///
    /// When you change the status of the job to `ARCHIVED`, the job can't be
    /// scheduled or archived.
    ///
    /// An archived jobs and its steps and tasks are deleted after 120 days. The job
    /// can't be recovered.
    pub fn updateJob(self: *Self, allocator: std.mem.Allocator, input: update_job.UpdateJobInput, options: CallOptions) !update_job.UpdateJobOutput {
        return update_job.execute(self, allocator, input, options);
    }

    /// Updates the properties of the specified limit.
    pub fn updateLimit(self: *Self, allocator: std.mem.Allocator, input: update_limit.UpdateLimitInput, options: CallOptions) !update_limit.UpdateLimitOutput {
        return update_limit.execute(self, allocator, input, options);
    }

    /// Modifies the settings for a Deadline Cloud monitor. You can modify one or
    /// all of the settings when you call `UpdateMonitor`.
    pub fn updateMonitor(self: *Self, allocator: std.mem.Allocator, input: update_monitor.UpdateMonitorInput, options: CallOptions) !update_monitor.UpdateMonitorOutput {
        return update_monitor.execute(self, allocator, input, options);
    }

    /// Updates a queue.
    pub fn updateQueue(self: *Self, allocator: std.mem.Allocator, input: update_queue.UpdateQueueInput, options: CallOptions) !update_queue.UpdateQueueOutput {
        return update_queue.execute(self, allocator, input, options);
    }

    /// Updates the queue environment.
    pub fn updateQueueEnvironment(self: *Self, allocator: std.mem.Allocator, input: update_queue_environment.UpdateQueueEnvironmentInput, options: CallOptions) !update_queue_environment.UpdateQueueEnvironmentOutput {
        return update_queue_environment.execute(self, allocator, input, options);
    }

    /// Updates a queue-fleet association.
    pub fn updateQueueFleetAssociation(self: *Self, allocator: std.mem.Allocator, input: update_queue_fleet_association.UpdateQueueFleetAssociationInput, options: CallOptions) !update_queue_fleet_association.UpdateQueueFleetAssociationOutput {
        return update_queue_fleet_association.execute(self, allocator, input, options);
    }

    /// Updates the status of the queue. If you set the status to one of the
    /// `STOP_LIMIT_USAGE*` values, there will be a delay before the status
    /// transitions to the `STOPPED` state.
    pub fn updateQueueLimitAssociation(self: *Self, allocator: std.mem.Allocator, input: update_queue_limit_association.UpdateQueueLimitAssociationInput, options: CallOptions) !update_queue_limit_association.UpdateQueueLimitAssociationOutput {
        return update_queue_limit_association.execute(self, allocator, input, options);
    }

    /// Updates a session.
    pub fn updateSession(self: *Self, allocator: std.mem.Allocator, input: update_session.UpdateSessionInput, options: CallOptions) !update_session.UpdateSessionOutput {
        return update_session.execute(self, allocator, input, options);
    }

    /// Updates a step.
    pub fn updateStep(self: *Self, allocator: std.mem.Allocator, input: update_step.UpdateStepInput, options: CallOptions) !update_step.UpdateStepOutput {
        return update_step.execute(self, allocator, input, options);
    }

    /// Updates a storage profile.
    pub fn updateStorageProfile(self: *Self, allocator: std.mem.Allocator, input: update_storage_profile.UpdateStorageProfileInput, options: CallOptions) !update_storage_profile.UpdateStorageProfileOutput {
        return update_storage_profile.execute(self, allocator, input, options);
    }

    /// Updates a task.
    pub fn updateTask(self: *Self, allocator: std.mem.Allocator, input: update_task.UpdateTaskInput, options: CallOptions) !update_task.UpdateTaskOutput {
        return update_task.execute(self, allocator, input, options);
    }

    /// Updates a worker.
    pub fn updateWorker(self: *Self, allocator: std.mem.Allocator, input: update_worker.UpdateWorkerInput, options: CallOptions) !update_worker.UpdateWorkerOutput {
        return update_worker.execute(self, allocator, input, options);
    }

    /// Updates the schedule for a worker.
    pub fn updateWorkerSchedule(self: *Self, allocator: std.mem.Allocator, input: update_worker_schedule.UpdateWorkerScheduleInput, options: CallOptions) !update_worker_schedule.UpdateWorkerScheduleOutput {
        return update_worker_schedule.execute(self, allocator, input, options);
    }

    pub fn getSessionsStatisticsAggregationPaginator(self: *Self, params: get_sessions_statistics_aggregation.GetSessionsStatisticsAggregationInput) paginator.GetSessionsStatisticsAggregationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAvailableMeteredProductsPaginator(self: *Self, params: list_available_metered_products.ListAvailableMeteredProductsInput) paginator.ListAvailableMeteredProductsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBudgetsPaginator(self: *Self, params: list_budgets.ListBudgetsInput) paginator.ListBudgetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFarmMembersPaginator(self: *Self, params: list_farm_members.ListFarmMembersInput) paginator.ListFarmMembersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFarmsPaginator(self: *Self, params: list_farms.ListFarmsInput) paginator.ListFarmsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFleetMembersPaginator(self: *Self, params: list_fleet_members.ListFleetMembersInput) paginator.ListFleetMembersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFleetsPaginator(self: *Self, params: list_fleets.ListFleetsInput) paginator.ListFleetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobMembersPaginator(self: *Self, params: list_job_members.ListJobMembersInput) paginator.ListJobMembersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listJobParameterDefinitionsPaginator(self: *Self, params: list_job_parameter_definitions.ListJobParameterDefinitionsInput) paginator.ListJobParameterDefinitionsPaginator {
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

    pub fn listLicenseEndpointsPaginator(self: *Self, params: list_license_endpoints.ListLicenseEndpointsInput) paginator.ListLicenseEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLimitsPaginator(self: *Self, params: list_limits.ListLimitsInput) paginator.ListLimitsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMeteredProductsPaginator(self: *Self, params: list_metered_products.ListMeteredProductsInput) paginator.ListMeteredProductsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMonitorsPaginator(self: *Self, params: list_monitors.ListMonitorsInput) paginator.ListMonitorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQueueEnvironmentsPaginator(self: *Self, params: list_queue_environments.ListQueueEnvironmentsInput) paginator.ListQueueEnvironmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQueueFleetAssociationsPaginator(self: *Self, params: list_queue_fleet_associations.ListQueueFleetAssociationsInput) paginator.ListQueueFleetAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQueueLimitAssociationsPaginator(self: *Self, params: list_queue_limit_associations.ListQueueLimitAssociationsInput) paginator.ListQueueLimitAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQueueMembersPaginator(self: *Self, params: list_queue_members.ListQueueMembersInput) paginator.ListQueueMembersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQueuesPaginator(self: *Self, params: list_queues.ListQueuesInput) paginator.ListQueuesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSessionActionsPaginator(self: *Self, params: list_session_actions.ListSessionActionsInput) paginator.ListSessionActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSessionsPaginator(self: *Self, params: list_sessions.ListSessionsInput) paginator.ListSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSessionsForWorkerPaginator(self: *Self, params: list_sessions_for_worker.ListSessionsForWorkerInput) paginator.ListSessionsForWorkerPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStepConsumersPaginator(self: *Self, params: list_step_consumers.ListStepConsumersInput) paginator.ListStepConsumersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStepDependenciesPaginator(self: *Self, params: list_step_dependencies.ListStepDependenciesInput) paginator.ListStepDependenciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStepsPaginator(self: *Self, params: list_steps.ListStepsInput) paginator.ListStepsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStorageProfilesPaginator(self: *Self, params: list_storage_profiles.ListStorageProfilesInput) paginator.ListStorageProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStorageProfilesForQueuePaginator(self: *Self, params: list_storage_profiles_for_queue.ListStorageProfilesForQueueInput) paginator.ListStorageProfilesForQueuePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTasksPaginator(self: *Self, params: list_tasks.ListTasksInput) paginator.ListTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkersPaginator(self: *Self, params: list_workers.ListWorkersInput) paginator.ListWorkersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilFleetActive(self: *Self, params: get_fleet.GetFleetInput) aws.waiter.WaiterError!void {
        var w = waiters.FleetActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilJobComplete(self: *Self, params: get_job.GetJobInput) aws.waiter.WaiterError!void {
        var w = waiters.JobCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilJobCreateComplete(self: *Self, params: get_job.GetJobInput) aws.waiter.WaiterError!void {
        var w = waiters.JobCreateCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilJobSucceeded(self: *Self, params: get_job.GetJobInput) aws.waiter.WaiterError!void {
        var w = waiters.JobSucceededWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilLicenseEndpointDeleted(self: *Self, params: get_license_endpoint.GetLicenseEndpointInput) aws.waiter.WaiterError!void {
        var w = waiters.LicenseEndpointDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilLicenseEndpointValid(self: *Self, params: get_license_endpoint.GetLicenseEndpointInput) aws.waiter.WaiterError!void {
        var w = waiters.LicenseEndpointValidWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilQueueFleetAssociationStopped(self: *Self, params: get_queue_fleet_association.GetQueueFleetAssociationInput) aws.waiter.WaiterError!void {
        var w = waiters.QueueFleetAssociationStoppedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilQueueLimitAssociationStopped(self: *Self, params: get_queue_limit_association.GetQueueLimitAssociationInput) aws.waiter.WaiterError!void {
        var w = waiters.QueueLimitAssociationStoppedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilQueueScheduling(self: *Self, params: get_queue.GetQueueInput) aws.waiter.WaiterError!void {
        var w = waiters.QueueSchedulingWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilQueueSchedulingBlocked(self: *Self, params: get_queue.GetQueueInput) aws.waiter.WaiterError!void {
        var w = waiters.QueueSchedulingBlockedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
