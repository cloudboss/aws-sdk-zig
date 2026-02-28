/// Provides details about an Elastic Graphics specification for an Amazon EC2
/// launch template.
pub const AwsEc2LaunchTemplateDataElasticGpuSpecificationSetDetails = struct {
    /// The type of Elastic Graphics accelerator.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .@"type" = "Type",
    };
};
