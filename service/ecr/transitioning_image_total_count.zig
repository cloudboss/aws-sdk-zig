const LifecyclePolicyTargetStorageClass = @import("lifecycle_policy_target_storage_class.zig").LifecyclePolicyTargetStorageClass;

/// The total count of images transitioning to a storage class.
pub const TransitioningImageTotalCount = struct {
    /// The total number of images transitioning to the storage class.
    image_total_count: ?i32,

    /// The target storage class.
    target_storage_class: ?LifecyclePolicyTargetStorageClass,

    pub const json_field_names = .{
        .image_total_count = "imageTotalCount",
        .target_storage_class = "targetStorageClass",
    };
};
