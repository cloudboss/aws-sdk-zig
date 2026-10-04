const TrainingInstanceType = @import("training_instance_type.zig").TrainingInstanceType;

/// A candidate instance type preference in an `InstancePreferences` list.
pub const InstancePreference = struct {
    /// The number of instances to launch if this instance type is selected. Specify
    /// the instance count for the training job in one of the following two ways:
    ///
    /// * **Per preference** – Set `InstanceCount` on every preference in the
    ///   `InstancePreferences` list and don't set `ResourceConfig$InstanceCount`.
    ///   Use this when each instance type needs a different number of instances to
    ///   deliver equivalent compute.
    /// * **One count for the job** – Set `ResourceConfig$InstanceCount` and omit it
    ///   from every preference. SageMaker applies this to all instance types in the
    ///   list.
    ///
    /// For example, in a list of five preferences, either all five specify
    /// `InstanceCount` or none of them do. SageMaker rejects requests that set
    /// `InstanceCount` on only some preferences, that set it both per preference
    /// and in `ResourceConfig`, or that omit it in both places.
    instance_count: ?i32 = null,

    /// The ML compute instance type. An instance type can appear only once in an
    /// `InstancePreferences` list.
    instance_type: TrainingInstanceType,

    /// The Amazon Resource Name (ARN) of a training plan to use if this instance
    /// type is selected. The plan's instance type must match `InstanceType`. A
    /// preference with a training plan uses that plan's reserved capacity; a
    /// preference without one uses on-demand capacity. Per-preference
    /// `TrainingPlanArns` is mutually exclusive with the job-level
    /// `TrainingPlanArn` in `ResourceConfig`.
    training_plan_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
        .training_plan_arns = "TrainingPlanArns",
    };
};
