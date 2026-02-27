const IotSiteWiseCustomerManagedDatastoreS3Storage = @import("iot_site_wise_customer_managed_datastore_s3_storage.zig").IotSiteWiseCustomerManagedDatastoreS3Storage;

/// Used to store data used by IoT SiteWise in an Amazon S3 bucket that you
/// manage. You can't change the choice of Amazon S3 storage after your data
/// store is created.
pub const DatastoreIotSiteWiseMultiLayerStorage = struct {
    /// Used to store data used by IoT SiteWise in an Amazon S3 bucket that you
    /// manage.
    customer_managed_s3_storage: IotSiteWiseCustomerManagedDatastoreS3Storage,

    pub const json_field_names = .{
        .customer_managed_s3_storage = "customerManagedS3Storage",
    };
};
