const CustomerManagedDatastoreS3StorageSummary = @import("customer_managed_datastore_s3_storage_summary.zig").CustomerManagedDatastoreS3StorageSummary;
const DatastoreIotSiteWiseMultiLayerStorageSummary = @import("datastore_iot_site_wise_multi_layer_storage_summary.zig").DatastoreIotSiteWiseMultiLayerStorageSummary;
const ServiceManagedDatastoreS3StorageSummary = @import("service_managed_datastore_s3_storage_summary.zig").ServiceManagedDatastoreS3StorageSummary;

/// Contains information about your data store.
pub const DatastoreStorageSummary = struct {
    /// Used to store data in an Amazon S3 bucket managed by IoT Analytics.
    customer_managed_s3: ?CustomerManagedDatastoreS3StorageSummary,

    /// Used to store data used by IoT SiteWise in an Amazon S3 bucket that you
    /// manage.
    iot_site_wise_multi_layer_storage: ?DatastoreIotSiteWiseMultiLayerStorageSummary,

    /// Used to store data in an Amazon S3 bucket managed by IoT Analytics.
    service_managed_s3: ?ServiceManagedDatastoreS3StorageSummary,

    pub const json_field_names = .{
        .customer_managed_s3 = "customerManagedS3",
        .iot_site_wise_multi_layer_storage = "iotSiteWiseMultiLayerStorage",
        .service_managed_s3 = "serviceManagedS3",
    };
};
