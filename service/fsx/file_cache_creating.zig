const FileCacheFailureDetails = @import("file_cache_failure_details.zig").FileCacheFailureDetails;
const FileCacheType = @import("file_cache_type.zig").FileCacheType;
const FileCacheLifecycle = @import("file_cache_lifecycle.zig").FileCacheLifecycle;
const FileCacheLustreConfiguration = @import("file_cache_lustre_configuration.zig").FileCacheLustreConfiguration;
const Tag = @import("tag.zig").Tag;

/// The response object for the Amazon File Cache resource being created in the
/// `CreateFileCache` operation.
pub const FileCacheCreating = struct {
    /// A boolean flag indicating whether tags for the cache should be copied to
    /// data repository associations.
    copy_tags_to_data_repository_associations: ?bool,

    creation_time: ?i64,

    /// A list of IDs of data repository associations that are associated with this
    /// cache.
    data_repository_association_ids: ?[]const []const u8,

    /// The Domain Name System (DNS) name for the cache.
    dns_name: ?[]const u8,

    /// A structure providing details of any failures that occurred in creating a
    /// cache.
    failure_details: ?FileCacheFailureDetails,

    /// The system-generated, unique ID of the cache.
    file_cache_id: ?[]const u8,

    /// The type of cache, which must be `LUSTRE`.
    file_cache_type: ?FileCacheType,

    /// The Lustre version of the cache, which must be `2.12`.
    file_cache_type_version: ?[]const u8,

    /// Specifies the ID of the Key Management Service (KMS) key to use for
    /// encrypting data on
    /// an Amazon File Cache. If a `KmsKeyId` isn't specified, the Amazon
    /// FSx-managed
    /// KMS key for your account is used. For more information,
    /// see
    /// [Encrypt](https://docs.aws.amazon.com/kms/latest/APIReference/API_Encrypt.html) in the
    /// *Key Management Service API Reference*.
    kms_key_id: ?[]const u8,

    /// The lifecycle status of the cache. The following are the possible values and
    /// what they mean:
    ///
    /// * `AVAILABLE` - The cache is in a healthy state, and is reachable and
    ///   available for use.
    ///
    /// * `CREATING` - The new cache is being created.
    ///
    /// * `DELETING` - An existing cache is being deleted.
    ///
    /// * `UPDATING` - The cache is undergoing a customer-initiated update.
    ///
    /// * `FAILED` - An existing cache has experienced an unrecoverable failure.
    /// When creating a new cache, the cache was unable to be created.
    lifecycle: ?FileCacheLifecycle,

    /// The configuration for the Amazon File Cache resource.
    lustre_configuration: ?FileCacheLustreConfiguration,

    network_interface_ids: ?[]const []const u8,

    owner_id: ?[]const u8,

    resource_arn: ?[]const u8,

    /// The storage capacity of the cache in gibibytes (GiB).
    storage_capacity: ?i32,

    subnet_ids: ?[]const []const u8,

    tags: ?[]const Tag,

    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .copy_tags_to_data_repository_associations = "CopyTagsToDataRepositoryAssociations",
        .creation_time = "CreationTime",
        .data_repository_association_ids = "DataRepositoryAssociationIds",
        .dns_name = "DNSName",
        .failure_details = "FailureDetails",
        .file_cache_id = "FileCacheId",
        .file_cache_type = "FileCacheType",
        .file_cache_type_version = "FileCacheTypeVersion",
        .kms_key_id = "KmsKeyId",
        .lifecycle = "Lifecycle",
        .lustre_configuration = "LustreConfiguration",
        .network_interface_ids = "NetworkInterfaceIds",
        .owner_id = "OwnerId",
        .resource_arn = "ResourceARN",
        .storage_capacity = "StorageCapacity",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
        .vpc_id = "VpcId",
    };
};
