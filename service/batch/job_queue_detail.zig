const aws = @import("aws");

const ComputeEnvironmentOrder = @import("compute_environment_order.zig").ComputeEnvironmentOrder;
const JobQueueType = @import("job_queue_type.zig").JobQueueType;
const JobStateTimeLimitAction = @import("job_state_time_limit_action.zig").JobStateTimeLimitAction;
const ServiceEnvironmentOrder = @import("service_environment_order.zig").ServiceEnvironmentOrder;
const JQState = @import("jq_state.zig").JQState;
const JQStatus = @import("jq_status.zig").JQStatus;

/// An object that represents the details for an Batch job queue.
pub const JobQueueDetail = struct {
    /// The compute environments that are attached to the job queue and the order
    /// that job placement
    /// is preferred. Compute environments are selected for job placement in
    /// ascending order.
    compute_environment_order: []const ComputeEnvironmentOrder,

    /// The Amazon Resource Name (ARN) of the job queue.
    job_queue_arn: []const u8,

    /// The job queue name.
    job_queue_name: []const u8,

    /// The type of job queue. For service jobs that run on SageMaker Training, this
    /// value is `SAGEMAKER_TRAINING`. For regular container jobs, this value is
    /// `EKS`, `ECS`, or `ECS_FARGATE` depending on the compute environment.
    job_queue_type: ?JobQueueType,

    /// The set of actions that Batch perform on jobs that remain at the head of the
    /// job queue in the specified state longer than specified times. Batch will
    /// perform each action after `maxTimeSeconds` has passed.
    job_state_time_limit_actions: ?[]const JobStateTimeLimitAction,

    /// The priority of the job queue. Job queue priority determines the order
    /// that job queues are evaluated when multiple queues dispatch jobs within a
    /// shared compute environment. A higher value for `priority` indicates
    /// a higher priority. Queues are evaluated in cycles, in descending order by
    /// priority. For example, a job queue with a priority value of `10` is
    /// evaluated before a queue with a priority value of `1`. All of the
    /// compute environments must be either Amazon EC2 (`EC2` or `SPOT`)
    /// or Fargate (`FARGATE` or `FARGATE_SPOT`). Amazon EC2 and
    /// Fargate compute environments can't be mixed.
    ///
    /// Job queue priority doesn't guarantee that a particular job executes before
    /// a job in a lower priority queue. Jobs added to higher priority queues during
    /// the
    /// queue evaluation cycle might not be evaluated until the next cycle. A job is
    /// dispatched from a queue only if resources are available when the queue is
    /// evaluated.
    /// If there are insufficient resources available at that time, the cycle
    /// proceeds to the
    /// next queue. This means that jobs added to higher priority queues might have
    /// to wait
    /// for jobs in multiple lower priority queues to complete before they are
    /// dispatched.
    /// You can use job dependencies to control the order for jobs from queues with
    /// different
    /// priorities. For more information, see [Job
    /// Dependencies](https://docs.aws.amazon.com/batch/latest/userguide/job_dependencies.html)
    /// in the *Batch User Guide*.
    priority: i32,

    /// The Amazon Resource Name (ARN) of the scheduling policy. The format is
    /// `aws:*Partition*:batch:*Region*:*Account*:scheduling-policy/*Name*
    /// `.
    /// For example,
    /// `aws:aws:batch:us-west-2:123456789012:scheduling-policy/MySchedulingPolicy`.
    scheduling_policy_arn: ?[]const u8,

    /// The order of the service environment associated with the job queue. Job
    /// queues with a higher priority are evaluated first when associated with the
    /// same service environment.
    service_environment_order: ?[]const ServiceEnvironmentOrder,

    /// Describes the ability of the queue to accept new jobs. If the job queue
    /// state is
    /// `ENABLED`, it can accept jobs. If the job queue state is `DISABLED`, new
    /// jobs can't be added to the queue, but jobs already in the queue can finish.
    state: JQState,

    /// The status of the job queue (for example, `CREATING` or
    /// `VALID`).
    status: ?JQStatus,

    /// A short, human-readable string to provide additional details for the current
    /// status of the
    /// job queue.
    status_reason: ?[]const u8,

    /// The tags that are applied to the job queue. For more information, see
    /// [Tagging your Batch
    /// resources](https://docs.aws.amazon.com/batch/latest/userguide/using-tags.html) in
    /// *Batch User Guide*.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .compute_environment_order = "computeEnvironmentOrder",
        .job_queue_arn = "jobQueueArn",
        .job_queue_name = "jobQueueName",
        .job_queue_type = "jobQueueType",
        .job_state_time_limit_actions = "jobStateTimeLimitActions",
        .priority = "priority",
        .scheduling_policy_arn = "schedulingPolicyArn",
        .service_environment_order = "serviceEnvironmentOrder",
        .state = "state",
        .status = "status",
        .status_reason = "statusReason",
        .tags = "tags",
    };
};
