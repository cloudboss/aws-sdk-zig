/// Contains `SageMakerFlowDefinition` object. The object is used to specify the
/// prompt dataset, task type, rating method and metric names.
pub const HumanWorkflowConfig = struct {
    /// The Amazon Resource Number (ARN) for the flow definition
    flow_definition_arn: []const u8,

    /// Instructions for the flow definition
    instructions: ?[]const u8 = null,

    pub const json_field_names = .{
        .flow_definition_arn = "flowDefinitionArn",
        .instructions = "instructions",
    };
};
