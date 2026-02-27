/// Content association data for a [step-by-step
/// guide](https://docs.aws.amazon.com/connect/latest/adminguide/step-by-step-guided-experiences.html).
pub const AmazonConnectGuideAssociationData = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Connect flow. Step-by-step
    /// guides are a type of flow.
    flow_id: ?[]const u8,

    pub const json_field_names = .{
        .flow_id = "flowId",
    };
};
