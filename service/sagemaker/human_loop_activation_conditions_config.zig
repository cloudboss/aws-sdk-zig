/// Defines under what conditions SageMaker creates a human loop. Used within
/// [CreateFlowDefinition](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateFlowDefinition.html). See [HumanLoopActivationConditionsConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HumanLoopActivationConditionsConfig.html) for the required format of activation conditions.
pub const HumanLoopActivationConditionsConfig = struct {
    /// JSON expressing use-case specific conditions declaratively. If any condition
    /// is matched, atomic tasks are created against the configured work team. The
    /// set of conditions is different for Rekognition and Textract. For more
    /// information about how to structure the JSON, see [JSON Schema for Human Loop
    /// Activation Conditions in Amazon Augmented
    /// AI](https://docs.aws.amazon.com/sagemaker/latest/dg/a2i-human-fallback-conditions-json-schema.html) in the *Amazon SageMaker Developer Guide*.
    human_loop_activation_conditions: []const u8,

    pub const json_field_names = .{
        .human_loop_activation_conditions = "HumanLoopActivationConditions",
    };
};
