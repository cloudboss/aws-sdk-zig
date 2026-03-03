/// Information on the Amazon ECR image metadata associated with a finding.
pub const EcrContainerImageMetadata = struct {
    /// The date an image was last pulled at.
    image_pulled_at: ?i64 = null,

    /// The number of Amazon ECS tasks or Amazon EKS pods where the Amazon ECR
    /// container image is in use.
    in_use_count: ?i64 = null,

    /// The last time an Amazon ECR image was used in an Amazon ECS task or
    /// Amazon EKS pod.
    last_in_use_at: ?i64 = null,

    /// Tags associated with the Amazon ECR image metadata.
    tags: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .image_pulled_at = "imagePulledAt",
        .in_use_count = "inUseCount",
        .last_in_use_at = "lastInUseAt",
        .tags = "tags",
    };
};
