const StorageClass = @import("storage_class.zig").StorageClass;

/// The configuration details for the storage class of tables or table buckets.
/// This allows you to optimize storage costs by selecting the appropriate
/// storage class based on your access patterns and performance requirements.
pub const StorageClassConfiguration = struct {
    /// The storage class for the table or table bucket. Valid values include
    /// storage classes optimized for different access patterns and cost profiles.
    storage_class: StorageClass,

    pub const json_field_names = .{
        .storage_class = "storageClass",
    };
};
