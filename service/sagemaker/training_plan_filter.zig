const TrainingPlanFilterName = @import("training_plan_filter_name.zig").TrainingPlanFilterName;

/// A filter to apply when listing or searching for training plans.
///
/// For more information about how to reserve GPU capacity for your SageMaker
/// HyperPod clusters using Amazon SageMaker Training Plan, see `
/// [CreateTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrainingPlan.html) `.
pub const TrainingPlanFilter = struct {
    /// The name of the filter field (e.g., Status, InstanceType).
    name: TrainingPlanFilterName,

    /// The value to filter by for the specified field.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
