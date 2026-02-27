const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const AvailableAdditionalStorageVolumesOption = @import("available_additional_storage_volumes_option.zig").AvailableAdditionalStorageVolumesOption;
const AvailableProcessorFeature = @import("available_processor_feature.zig").AvailableProcessorFeature;

/// Contains a list of available options for a DB instance.
///
/// This data type is used as a response element in the
/// `DescribeOrderableDBInstanceOptions` action.
pub const OrderableDBInstanceOption = struct {
    /// The Availability Zone group for a DB instance.
    availability_zone_group: ?[]const u8,

    /// A list of Availability Zones for a DB instance.
    availability_zones: ?[]const AvailabilityZone,

    /// The available options for additional storage volumes for the DB instance
    /// class.
    available_additional_storage_volumes_options: ?[]const AvailableAdditionalStorageVolumesOption,

    /// A list of the available processor features for the DB instance class of a DB
    /// instance.
    available_processor_features: ?[]const AvailableProcessorFeature,

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

    /// Maximum storage throughput for a DB instance.
    max_storage_throughput_per_db_instance: ?i32,

    /// Maximum storage throughput to provisioned IOPS ratio for a DB instance.
    max_storage_throughput_per_iops: ?f64,

    /// Minimum total provisioned IOPS for a DB instance.
    min_iops_per_db_instance: ?i32,

    /// Minimum provisioned IOPS per GiB for a DB instance.
    min_iops_per_gib: ?f64,

    /// Minimum storage size for a DB instance.
    min_storage_size: ?i32,

    /// Minimum storage throughput for a DB instance.
    min_storage_throughput_per_db_instance: ?i32,

    /// Minimum storage throughput to provisioned IOPS ratio for a DB instance.
    min_storage_throughput_per_iops: ?f64,

    /// Indicates whether a DB instance is Multi-AZ capable.
    multi_az_capable: ?bool,

    /// Indicates whether a DB instance supports RDS on Outposts.
    ///
    /// For more information about RDS on Outposts, see [Amazon RDS on Amazon Web
    /// Services
    /// Outposts](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-on-outposts.html) in the *Amazon RDS User Guide.*
    outpost_capable: ?bool,

    /// Indicates whether a DB instance can have a read replica.
    read_replica_capable: ?bool,

    /// The storage type for a DB instance.
    storage_type: ?[]const u8,

    /// The list of supported modes for Database Activity Streams. Aurora PostgreSQL
    /// returns the value `[sync, async]`. Aurora MySQL and RDS for Oracle return
    /// `[async]` only. If Database Activity Streams isn't supported, the return
    /// value is an empty list.
    supported_activity_stream_modes: ?[]const []const u8,

    /// A list of the supported DB engine modes.
    supported_engine_modes: ?[]const []const u8,

    /// The network types supported by the DB instance (`IPV4` or `DUAL`).
    ///
    /// A DB instance can support only the IPv4 protocol or the IPv4 and the IPv6
    /// protocols (`DUAL`).
    ///
    /// For more information, see [ Working with a DB instance in a
    /// VPC](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html) in the *Amazon RDS User Guide.*
    supported_network_types: ?[]const []const u8,

    /// Indicates whether the DB instance class supports additional storage volumes.
    supports_additional_storage_volumes: ?bool,

    /// Indicates whether DB instances can be configured as a Multi-AZ DB cluster.
    ///
    /// For more information on Multi-AZ DB clusters, see [ Multi-AZ deployments
    /// with two readable standby DB
    /// instances](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/multi-az-db-clusters-concepts.html) in the *Amazon RDS User Guide.*
    supports_clusters: ?bool,

    /// Indicates whether a DB instance supports using a dedicated log volume (DLV).
    supports_dedicated_log_volume: ?bool,

    /// Indicates whether a DB instance supports Enhanced Monitoring at intervals
    /// from 1 to 60 seconds.
    supports_enhanced_monitoring: ?bool,

    /// Indicates whether you can use Aurora global databases with a specific
    /// combination of other DB engine attributes.
    supports_global_databases: ?bool,

    /// Indicates whether a DB instance supports HTTP endpoints.
    supports_http_endpoint: ?bool,

    /// Indicates whether a DB instance supports IAM database authentication.
    supports_iam_database_authentication: ?bool,

    /// Indicates whether a DB instance supports provisioned IOPS.
    supports_iops: ?bool,

    /// Indicates whether a DB instance supports Kerberos Authentication.
    supports_kerberos_authentication: ?bool,

    /// Indicates whether a DB instance supports Performance Insights.
    supports_performance_insights: ?bool,

    /// Indicates whether Amazon RDS can automatically scale storage for DB
    /// instances that use the specified DB instance class.
    supports_storage_autoscaling: ?bool,

    /// Indicates whether a DB instance supports encrypted storage.
    supports_storage_encryption: ?bool,

    /// Indicates whether a DB instance supports storage throughput.
    supports_storage_throughput: ?bool,

    /// Indicates whether a DB instance is in a VPC.
    vpc: ?bool,
};
