const HumanLoopDataAttributes = @import("human_loop_data_attributes.zig").HumanLoopDataAttributes;

/// Sets up the human review workflow the document will be sent to if one of the
/// conditions
/// is met. You can also set certain attributes of the image before review.
pub const HumanLoopConfig = struct {
    /// Sets attributes of the input data.
    data_attributes: ?HumanLoopDataAttributes = null,

    /// The Amazon Resource Name (ARN) of the flow definition.
    flow_definition_arn: []const u8,

    /// The name of the human workflow used for this image. This should be kept
    /// unique within a
    /// region.
    human_loop_name: []const u8,

    pub const json_field_names = .{
        .data_attributes = "DataAttributes",
        .flow_definition_arn = "FlowDefinitionArn",
        .human_loop_name = "HumanLoopName",
    };
};
