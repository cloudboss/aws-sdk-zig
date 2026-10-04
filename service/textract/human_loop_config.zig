const HumanLoopDataAttributes = @import("human_loop_data_attributes.zig").HumanLoopDataAttributes;

/// Sets up the human review workflow the document will be sent to if one of the
/// conditions
/// is met. You can also set certain attributes of the image before review.
///
/// Amazon Textract uses Amazon Augmented AI (A2I) to run the human review
/// workflows that you specify in `HumanLoopConfig`. A2I entered
/// maintenance mode in July 2026 and no longer accepts new customers. If your
/// account is not an
/// existing A2I customer, requests fail with an
/// `InvalidParameterException`. For more information, see [AWS
/// service
/// availability](https://aws.amazon.com/about-aws/whats-new/2026/06/aws-service-availability/). If you're an existing A2I customer but receive
/// this error, contact AWS Support and request assistance from the A2I team.
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
