const ReleaseStatusValues = @import("release_status_values.zig").ReleaseStatusValues;

/// In response to the `DescribeOrderableReplicationInstances` operation, this
/// object describes an available replication instance. This description
/// includes the
/// replication instance's type, engine version, and allocated storage.
pub const OrderableReplicationInstance = struct {
    /// List of Availability Zones for this replication instance.
    availability_zones: ?[]const []const u8,

    /// The default amount of storage (in gigabytes) that is allocated for the
    /// replication
    /// instance.
    default_allocated_storage: i32 = 0,

    /// The version of the replication engine.
    engine_version: ?[]const u8,

    /// The amount of storage (in gigabytes) that is allocated for the replication
    /// instance.
    included_allocated_storage: i32 = 0,

    /// The minimum amount of storage (in gigabytes) that can be allocated for the
    /// replication
    /// instance.
    max_allocated_storage: i32 = 0,

    /// The minimum amount of storage (in gigabytes) that can be allocated for the
    /// replication
    /// instance.
    min_allocated_storage: i32 = 0,

    /// The value returned when the specified `EngineVersion` of the replication
    /// instance is in Beta or test mode. This indicates some features might not
    /// work as
    /// expected.
    ///
    /// DMS supports the `ReleaseStatus` parameter in versions 3.1.4 and
    /// later.
    release_status: ?ReleaseStatusValues,

    /// The compute and memory capacity of the replication instance as defined for
    /// the specified
    /// replication instance class. For example to specify the instance class
    /// dms.c4.large, set
    /// this parameter to `"dms.c4.large"`.
    ///
    /// For more information on the settings and capacities for the available
    /// replication
    /// instance classes, see [ Selecting the right DMS replication instance for
    /// your
    /// migration](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReplicationInstance.html#CHAP_ReplicationInstance.InDepth).
    replication_instance_class: ?[]const u8,

    /// The type of storage used by the replication instance.
    storage_type: ?[]const u8,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .default_allocated_storage = "DefaultAllocatedStorage",
        .engine_version = "EngineVersion",
        .included_allocated_storage = "IncludedAllocatedStorage",
        .max_allocated_storage = "MaxAllocatedStorage",
        .min_allocated_storage = "MinAllocatedStorage",
        .release_status = "ReleaseStatus",
        .replication_instance_class = "ReplicationInstanceClass",
        .storage_type = "StorageType",
    };
};
