/// Provides information about the values of pending modifications to a
/// replication
/// instance. This data type is an object of the [
/// `ReplicationInstance`
/// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_ReplicationInstance.html) user-defined data type.
pub const ReplicationPendingModifiedValues = struct {
    /// The amount of storage (in gigabytes) that is allocated for the replication
    /// instance.
    allocated_storage: ?i32,

    /// The engine version number of the replication instance.
    engine_version: ?[]const u8,

    /// Specifies whether the replication instance is a Multi-AZ deployment. You
    /// can't set
    /// the `AvailabilityZone` parameter if the Multi-AZ parameter is set to
    /// `true`.
    multi_az: ?bool,

    /// The type of IP address protocol used by a replication instance, such as IPv4
    /// only or
    /// Dual-stack that supports both IPv4 and IPv6 addressing. IPv6 only is not yet
    /// supported.
    network_type: ?[]const u8,

    /// The compute and memory capacity of the replication instance as defined for
    /// the specified
    /// replication instance class.
    ///
    /// For more information on the settings and capacities for the available
    /// replication
    /// instance classes, see [ Selecting the right DMS replication instance for
    /// your
    /// migration](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReplicationInstance.html#CHAP_ReplicationInstance.InDepth).
    replication_instance_class: ?[]const u8,

    pub const json_field_names = .{
        .allocated_storage = "AllocatedStorage",
        .engine_version = "EngineVersion",
        .multi_az = "MultiAZ",
        .network_type = "NetworkType",
        .replication_instance_class = "ReplicationInstanceClass",
    };
};
