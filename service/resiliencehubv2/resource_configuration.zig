const EksSource = @import("eks_source.zig").EksSource;
const ResourceTag = @import("resource_tag.zig").ResourceTag;

/// Resource configuration for an input source. Provide exactly one field.
pub const ResourceConfiguration = union(enum) {
    cfn_stack_arn: ?[]const u8,
    design_file_s3_url: ?[]const u8,
    /// The Amazon EKS configuration for resource discovery.
    eks: ?EksSource,
    /// The resource tags for tag-based resource discovery.
    resource_tags: ?[]const ResourceTag,
    tf_state_file_url: ?[]const u8,

    pub const json_field_names = .{
        .cfn_stack_arn = "cfnStackArn",
        .design_file_s3_url = "designFileS3Url",
        .eks = "eks",
        .resource_tags = "resourceTags",
        .tf_state_file_url = "tfStateFileUrl",
    };
};
