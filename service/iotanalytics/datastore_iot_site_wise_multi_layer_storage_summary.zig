const IotSiteWiseCustomerManagedDatastoreS3StorageSummary = @import("iot_site_wise_customer_managed_datastore_s3_storage_summary.zig").IotSiteWiseCustomerManagedDatastoreS3StorageSummary;

/// Contains information about the data store that you manage, which stores data
/// used by IoT SiteWise.
pub const DatastoreIotSiteWiseMultiLayerStorageSummary = struct {
    /// Used to store data used by IoT SiteWise in an Amazon S3 bucket that you
    /// manage.
    customer_managed_s3_storage: ?IotSiteWiseCustomerManagedDatastoreS3StorageSummary,

    pub const json_field_names = .{
        .customer_managed_s3_storage = "customerManagedS3Storage",
    };
};
