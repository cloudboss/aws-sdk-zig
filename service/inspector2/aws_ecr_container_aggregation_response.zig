const SeverityCounts = @import("severity_counts.zig").SeverityCounts;

/// An aggregation of information about Amazon ECR containers.
pub const AwsEcrContainerAggregationResponse = struct {
    /// The Amazon Web Services account ID of the account that owns the container.
    account_id: ?[]const u8 = null,

    /// The architecture of the container.
    architecture: ?[]const u8 = null,

    /// The SHA value of the container image.
    image_sha: ?[]const u8 = null,

    /// The container image stags.
    image_tags: ?[]const []const u8 = null,

    /// The number of Amazon ECS tasks or Amazon EKS pods where the Amazon ECR
    /// container image is in use.
    in_use_count: ?i64 = null,

    /// The last time an Amazon ECR image was used in an Amazon ECS task or
    /// Amazon EKS pod.
    last_in_use_at: ?i64 = null,

    /// The container repository.
    repository: ?[]const u8 = null,

    /// The resource ID of the container.
    resource_id: []const u8,

    /// The number of finding by severity.
    severity_counts: ?SeverityCounts = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .architecture = "architecture",
        .image_sha = "imageSha",
        .image_tags = "imageTags",
        .in_use_count = "inUseCount",
        .last_in_use_at = "lastInUseAt",
        .repository = "repository",
        .resource_id = "resourceId",
        .severity_counts = "severityCounts",
    };
};
