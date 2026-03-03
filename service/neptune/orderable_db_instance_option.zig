const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;

/// Contains a list of available options for a DB instance.
///
/// This data type is used as a response element in the
/// DescribeOrderableDBInstanceOptions action.
pub const OrderableDBInstanceOption = struct {
    /// A list of Availability Zones for a DB instance.
    availability_zones: ?[]const AvailabilityZone = null,

    /// The DB instance class for a DB instance.
    db_instance_class: ?[]const u8 = null,

    /// The engine type of a DB instance.
    engine: ?[]const u8 = null,

    /// The engine version of a DB instance.
    engine_version: ?[]const u8 = null,

    /// The license model for a DB instance.
    license_model: ?[]const u8 = null,

    /// Maximum total provisioned IOPS for a DB instance.
    max_iops_per_db_instance: ?i32 = null,

    /// Maximum provisioned IOPS per GiB for a DB instance.
    max_iops_per_gib: ?f64 = null,

    /// Maximum storage size for a DB instance.
    max_storage_size: ?i32 = null,

    /// Minimum total provisioned IOPS for a DB instance.
    min_iops_per_db_instance: ?i32 = null,

    /// Minimum provisioned IOPS per GiB for a DB instance.
    min_iops_per_gib: ?f64 = null,

    /// Minimum storage size for a DB instance.
    min_storage_size: ?i32 = null,

    /// Indicates whether a DB instance is Multi-AZ capable.
    multi_az_capable: ?bool = null,

    /// Indicates whether a DB instance can have a Read Replica.
    read_replica_capable: ?bool = null,

    /// Not applicable. In Neptune the storage type is managed at the DB Cluster
    /// level.
    storage_type: ?[]const u8 = null,

    /// Indicates whether a DB instance supports Enhanced Monitoring at intervals
    /// from 1 to 60
    /// seconds.
    supports_enhanced_monitoring: ?bool = null,

    /// A value that indicates whether you can use Neptune global databases with a
    /// specific combination of other DB engine attributes.
    supports_global_databases: ?bool = null,

    /// Indicates whether a DB instance supports IAM database authentication.
    supports_iam_database_authentication: ?bool = null,

    /// Indicates whether a DB instance supports provisioned IOPS.
    supports_iops: ?bool = null,

    /// *(Not supported by Neptune)*
    supports_performance_insights: ?bool = null,

    /// Indicates whether a DB instance supports encrypted storage.
    supports_storage_encryption: ?bool = null,

    /// Indicates whether a DB instance is in a VPC.
    vpc: ?bool = null,
};
