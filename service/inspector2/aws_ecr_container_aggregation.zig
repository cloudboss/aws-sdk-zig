const StringFilter = @import("string_filter.zig").StringFilter;
const NumberFilter = @import("number_filter.zig").NumberFilter;
const DateFilter = @import("date_filter.zig").DateFilter;
const AwsEcrContainerSortBy = @import("aws_ecr_container_sort_by.zig").AwsEcrContainerSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// An aggregation of information about Amazon ECR containers.
pub const AwsEcrContainerAggregation = struct {
    /// The architecture of the containers.
    architectures: ?[]const StringFilter,

    /// The image SHA values.
    image_shas: ?[]const StringFilter,

    /// The image tags.
    image_tags: ?[]const StringFilter,

    /// The number of Amazon ECS tasks or Amazon EKS pods where the Amazon ECR
    /// container image is in use.
    in_use_count: ?[]const NumberFilter,

    /// The last time an Amazon ECR image was used in an Amazon ECS task or
    /// Amazon EKS pod.
    last_in_use_at: ?[]const DateFilter,

    /// The container repositories.
    repositories: ?[]const StringFilter,

    /// The container resource IDs.
    resource_ids: ?[]const StringFilter,

    /// The value to sort by.
    sort_by: ?AwsEcrContainerSortBy,

    /// The sort order (ascending or descending).
    sort_order: ?SortOrder,

    pub const json_field_names = .{
        .architectures = "architectures",
        .image_shas = "imageShas",
        .image_tags = "imageTags",
        .in_use_count = "inUseCount",
        .last_in_use_at = "lastInUseAt",
        .repositories = "repositories",
        .resource_ids = "resourceIds",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
