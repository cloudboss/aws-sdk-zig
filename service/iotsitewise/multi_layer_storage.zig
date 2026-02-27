const CustomerManagedS3Storage = @import("customer_managed_s3_storage.zig").CustomerManagedS3Storage;

/// Contains information about the storage destination.
pub const MultiLayerStorage = struct {
    /// Contains information about a customer managed Amazon S3 bucket.
    customer_managed_s3_storage: CustomerManagedS3Storage,

    pub const json_field_names = .{
        .customer_managed_s3_storage = "customerManagedS3Storage",
    };
};
