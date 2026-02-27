const TrainingInstanceType = @import("training_instance_type.zig").TrainingInstanceType;

/// Defines an instance group for heterogeneous cluster training. When
/// requesting a training job using the
/// [CreateTrainingJob](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingJob.html) API, you can configure multiple instance groups .
pub const InstanceGroup = struct {
    /// Specifies the number of instances of the instance group.
    instance_count: i32,

    /// Specifies the name of the instance group.
    instance_group_name: []const u8,

    /// Specifies the instance type of the instance group.
    instance_type: TrainingInstanceType,

    pub const json_field_names = .{
        .instance_count = "InstanceCount",
        .instance_group_name = "InstanceGroupName",
        .instance_type = "InstanceType",
    };
};
