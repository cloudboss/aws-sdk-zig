const CustomerManagedChannelS3StorageSummary = @import("customer_managed_channel_s3_storage_summary.zig").CustomerManagedChannelS3StorageSummary;
const ServiceManagedChannelS3StorageSummary = @import("service_managed_channel_s3_storage_summary.zig").ServiceManagedChannelS3StorageSummary;

/// Where channel data is stored.
pub const ChannelStorageSummary = struct {
    /// Used to store channel data in an S3 bucket that you manage.
    customer_managed_s3: ?CustomerManagedChannelS3StorageSummary,

    /// Used to store channel data in an S3 bucket managed by IoT Analytics.
    service_managed_s3: ?ServiceManagedChannelS3StorageSummary,

    pub const json_field_names = .{
        .customer_managed_s3 = "customerManagedS3",
        .service_managed_s3 = "serviceManagedS3",
    };
};
