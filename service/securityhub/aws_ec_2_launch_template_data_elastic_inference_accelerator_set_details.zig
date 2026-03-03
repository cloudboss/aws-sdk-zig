/// Provides details for an Amazon Elastic Inference accelerator.
pub const AwsEc2LaunchTemplateDataElasticInferenceAcceleratorSetDetails = struct {
    /// The number of Elastic Inference accelerators to attach to the instance.
    count: ?i32 = null,

    /// The type of Elastic Inference accelerator.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .count = "Count",
        .@"type" = "Type",
    };
};
