const FlowNodeInputCategory = @import("flow_node_input_category.zig").FlowNodeInputCategory;
const FlowNodeIODataType = @import("flow_node_io_data_type.zig").FlowNodeIODataType;

/// Contains configurations for an input in an Amazon Bedrock Flows node.
pub const FlowNodeInput = struct {
    /// Specifies how input data flows between iterations in a DoWhile loop.
    ///
    /// * `LoopCondition` - Controls whether the loop continues by evaluating
    ///   condition expressions against the input data. Use this category to define
    ///   the condition that determines if the loop should continue.
    /// * `ReturnValueToLoopStart` - Defines data to pass back to the start of the
    ///   loop's next iteration. Use this category for variables that you want to
    ///   update for each loop iteration.
    /// * `ExitLoop` - Defines the value that's available once the loop ends. Use
    ///   this category to expose loop results to nodes outside the loop.
    category: ?FlowNodeInputCategory,

    /// An expression that formats the input for the node. For an explanation of how
    /// to create expressions, see [Expressions in Prompt flows in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-expressions.html).
    expression: []const u8,

    /// Specifies a name for the input that you can reference.
    name: []const u8,

    /// Specifies the data type of the input. If the input doesn't match this type
    /// at runtime, a validation error will be thrown.
    type: FlowNodeIODataType,

    pub const json_field_names = .{
        .category = "category",
        .expression = "expression",
        .name = "name",
        .type = "type",
    };
};
