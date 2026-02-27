/// Provides details for an Amazon Elastic Inference accelerator.
pub const AwsEc2LaunchTemplateDataElasticInferenceAcceleratorSetDetails = struct {
    /// The number of Elastic Inference accelerators to attach to the instance.
    count: ?i32,

    /// The type of Elastic Inference accelerator.
    type: ?[]const u8,

    pub const json_field_names = .{
        .count = "Count",
        .type = "Type",
    };
};
