const CustomerManagedChannelS3Storage = @import("customer_managed_channel_s3_storage.zig").CustomerManagedChannelS3Storage;
const ServiceManagedChannelS3Storage = @import("service_managed_channel_s3_storage.zig").ServiceManagedChannelS3Storage;

/// Where channel data is stored. You may choose one of `serviceManagedS3`,
/// `customerManagedS3` storage. If not specified, the default is
/// `serviceManagedS3`. This can't be changed after creation of the channel.
pub const ChannelStorage = struct {
    /// Used to store channel data in an S3 bucket that you manage. If customer
    /// managed storage is
    /// selected, the `retentionPeriod` parameter is ignored. You can't change the
    /// choice
    /// of S3 storage after the data store is created.
    customer_managed_s3: ?CustomerManagedChannelS3Storage = null,

    /// Used to store channel data in an S3 bucket managed by IoT Analytics. You
    /// can't change the choice
    /// of S3 storage after the data store is created.
    service_managed_s3: ?ServiceManagedChannelS3Storage = null,

    pub const json_field_names = .{
        .customer_managed_s3 = "customerManagedS3",
        .service_managed_s3 = "serviceManagedS3",
    };
};
