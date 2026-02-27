const CustomerManagedDatastoreS3Storage = @import("customer_managed_datastore_s3_storage.zig").CustomerManagedDatastoreS3Storage;
const DatastoreIotSiteWiseMultiLayerStorage = @import("datastore_iot_site_wise_multi_layer_storage.zig").DatastoreIotSiteWiseMultiLayerStorage;
const ServiceManagedDatastoreS3Storage = @import("service_managed_datastore_s3_storage.zig").ServiceManagedDatastoreS3Storage;

/// Where data in a data store is stored.. You can choose `serviceManagedS3`
/// storage, `customerManagedS3` storage, or `iotSiteWiseMultiLayerStorage`
/// storage. The default is `serviceManagedS3`. You can't change the choice of
/// Amazon S3 storage after your data store is created.
pub const DatastoreStorage = union(enum) {
    /// S3-customer-managed; When you choose customer-managed storage, the
    /// `retentionPeriod` parameter is ignored. You can't change the choice of
    /// Amazon S3 storage after your data store is created.
    customer_managed_s3: ?CustomerManagedDatastoreS3Storage,
    /// Used to store data used by IoT SiteWise in an Amazon S3 bucket that you
    /// manage. You can't change the choice of Amazon S3 storage after your data
    /// store is created.
    iot_site_wise_multi_layer_storage: ?DatastoreIotSiteWiseMultiLayerStorage,
    /// Used to store data in an Amazon S3 bucket managed by IoT Analytics. You
    /// can't change the choice of Amazon S3 storage after your data store is
    /// created.
    service_managed_s3: ?ServiceManagedDatastoreS3Storage,

    pub const json_field_names = .{
        .customer_managed_s3 = "customerManagedS3",
        .iot_site_wise_multi_layer_storage = "iotSiteWiseMultiLayerStorage",
        .service_managed_s3 = "serviceManagedS3",
    };
};
