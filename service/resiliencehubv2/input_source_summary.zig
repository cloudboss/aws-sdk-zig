const EksSource = @import("eks_source.zig").EksSource;
const ResourceTag = @import("resource_tag.zig").ResourceTag;
const InputSourceType = @import("input_source_type.zig").InputSourceType;

/// Contains summary information about an input source for a service.
pub const InputSourceSummary = struct {
    cfn_stack_arn: ?[]const u8 = null,

    /// The timestamp when the input source was created.
    created_at: ?i64 = null,

    design_file_s3_url: ?[]const u8 = null,

    /// The Amazon EKS configuration, if this input source uses EKS.
    eks: ?EksSource = null,

    /// The unique identifier of the input source.
    input_source_id: []const u8,

    /// The resource tags used for discovery, if this input source uses tags.
    resource_tags: ?[]const ResourceTag = null,

    tf_state_file_url: ?[]const u8 = null,

    /// The type of the input source.
    type: ?InputSourceType = null,

    pub const json_field_names = .{
        .cfn_stack_arn = "cfnStackArn",
        .created_at = "createdAt",
        .design_file_s3_url = "designFileS3Url",
        .eks = "eks",
        .input_source_id = "inputSourceId",
        .resource_tags = "resourceTags",
        .tf_state_file_url = "tfStateFileUrl",
        .type = "type",
    };
};
