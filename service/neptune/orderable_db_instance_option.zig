const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;

/// Contains a list of available options for a DB instance.
///
/// This data type is used as a response element in the
/// DescribeOrderableDBInstanceOptions action.
pub const OrderableDBInstanceOption = struct {
    /// A list of Availability Zones for a DB instance.
    availability_zones: ?[]const AvailabilityZone,

    /// The DB instance class for a DB instance.
    db_instance_class: ?[]const u8,

    /// The engine type of a DB instance.
    engine: ?[]const u8,

    /// The engine version of a DB instance.
    engine_version: ?[]const u8,

    /// The license model for a DB instance.
    license_model: ?[]const u8,

    /// Maximum total provisioned IOPS for a DB instance.
    max_iops_per_db_instance: ?i32,

    /// Maximum provisioned IOPS per GiB for a DB instance.
    max_iops_per_gib: ?f64,

    /// Maximum storage size for a DB instance.
    max_storage_size: ?i32,

    /// Minimum total provisioned IOPS for a DB instance.
    min_iops_per_db_instance: ?i32,

    /// Minimum provisioned IOPS per GiB for a DB instance.
    min_iops_per_gib: ?f64,

    /// Minimum storage size for a DB instance.
    min_storage_size: ?i32,

    /// Indicates whether a DB instance is Multi-AZ capable.
    multi_az_capable: ?bool,

    /// Indicates whether a DB instance can have a Read Replica.
    read_replica_capable: ?bool,

    /// Not applicable. In Neptune the storage type is managed at the DB Cluster
    /// level.
    storage_type: ?[]const u8,

    /// Indicates whether a DB instance supports Enhanced Monitoring at intervals
    /// from 1 to 60
    /// seconds.
    supports_enhanced_monitoring: ?bool,

    /// A value that indicates whether you can use Neptune global databases with a
    /// specific combination of other DB engine attributes.
    supports_global_databases: ?bool,

    /// Indicates whether a DB instance supports IAM database authentication.
    supports_iam_database_authentication: ?bool,

    /// Indicates whether a DB instance supports provisioned IOPS.
    supports_iops: ?bool,

    /// *(Not supported by Neptune)*
    supports_performance_insights: ?bool,

    /// Indicates whether a DB instance supports encrypted storage.
    supports_storage_encryption: ?bool,

    /// Indicates whether a DB instance is in a VPC.
    vpc: ?bool,
};
