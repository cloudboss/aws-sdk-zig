const TargetGroupInfo = @import("target_group_info.zig").TargetGroupInfo;
const TargetLabel = @import("target_label.zig").TargetLabel;

/// Information about a set of Amazon ECS tasks in an CodeDeploy
/// deployment. An Amazon ECS task set includes details such as the desired
/// number
/// of tasks, how many tasks are running, and whether the task set serves
/// production
/// traffic. An CodeDeploy application that uses the Amazon ECS compute
/// platform deploys a containerized application in an Amazon ECS service as a
/// task
/// set.
pub const ECSTaskSet = struct {
    /// The number of tasks in a task set. During a deployment that uses the Amazon
    /// ECS compute type, CodeDeploy instructs Amazon ECS to create a new task set
    /// and
    /// uses this value to determine how many tasks to create. After the updated
    /// task set is
    /// created, CodeDeploy shifts traffic to the new task set.
    desired_count: i64 = 0,

    /// A unique ID of an `ECSTaskSet`.
    identifer: ?[]const u8,

    /// The number of tasks in the task set that are in the `PENDING` status
    /// during an Amazon ECS deployment. A task in the `PENDING` state is
    /// preparing to enter the `RUNNING` state. A task set enters the
    /// `PENDING` status when it launches for the first time, or when it is
    /// restarted after being in the `STOPPED` state.
    pending_count: i64 = 0,

    /// The number of tasks in the task set that are in the `RUNNING` status
    /// during an Amazon ECS deployment. A task in the `RUNNING` state is
    /// running and ready for use.
    running_count: i64 = 0,

    /// The status of the task set. There are three valid task set statuses:
    ///
    /// * `PRIMARY`: Indicates the task set is serving production traffic.
    ///
    /// * `ACTIVE`: Indicates the task set is not serving production traffic.
    ///
    /// * `DRAINING`: Indicates the tasks in the task set are being stopped and
    /// their corresponding targets are being deregistered from their target group.
    status: ?[]const u8,

    /// The target group associated with the task set. The target group is used by
    /// CodeDeploy to manage traffic to a task set.
    target_group: ?TargetGroupInfo,

    /// A label that identifies whether the ECS task set is an original target
    /// (`BLUE`) or a replacement target (`GREEN`).
    task_set_label: ?TargetLabel,

    /// The percentage of traffic served by this task set.
    traffic_weight: f64 = 0,

    pub const json_field_names = .{
        .desired_count = "desiredCount",
        .identifer = "identifer",
        .pending_count = "pendingCount",
        .running_count = "runningCount",
        .status = "status",
        .target_group = "targetGroup",
        .task_set_label = "taskSetLabel",
        .traffic_weight = "trafficWeight",
    };
};
