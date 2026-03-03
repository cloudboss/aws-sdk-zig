/// A set of conditions for stopping a labeling job. If any of the conditions
/// are met, the job is automatically stopped. You can use these conditions to
/// control the cost of data labeling.
///
/// Labeling jobs fail after 30 days with an appropriate client error message.
pub const LabelingJobStoppingConditions = struct {
    /// The maximum number of objects that can be labeled by human workers.
    max_human_labeled_object_count: ?i32 = null,

    /// The maximum number of input data objects that should be labeled.
    max_percentage_of_input_dataset_labeled: ?i32 = null,

    pub const json_field_names = .{
        .max_human_labeled_object_count = "MaxHumanLabeledObjectCount",
        .max_percentage_of_input_dataset_labeled = "MaxPercentageOfInputDatasetLabeled",
    };
};
