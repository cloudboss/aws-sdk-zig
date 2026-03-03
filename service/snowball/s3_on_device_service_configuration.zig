const StorageUnit = @import("storage_unit.zig").StorageUnit;

/// Amazon S3 compatible storage on Snow family devices configuration items.
pub const S3OnDeviceServiceConfiguration = struct {
    /// >Fault tolerance level of the cluster. This indicates the number of nodes
    /// that can go down without degrading the performance of the cluster. This
    /// additional input helps when the specified `StorageLimit` matches more than
    /// one Amazon S3 compatible storage on Snow family devices service
    /// configuration.
    fault_tolerance: ?i32 = null,

    /// Applicable when creating a cluster. Specifies how many nodes are needed for
    /// Amazon S3 compatible storage on Snow family devices. If specified, the other
    /// input can be omitted.
    service_size: ?i32 = null,

    /// If the specified storage limit value matches storage limit of one of the
    /// defined configurations, that configuration will be used.
    /// If the specified storage limit value does not match any defined
    /// configuration, the request will fail. If more than one configuration has
    /// the same storage limit as specified, the other input need to be provided.
    storage_limit: ?f64 = null,

    /// Storage unit. Currently the only supported unit is TB.
    storage_unit: ?StorageUnit = null,

    pub const json_field_names = .{
        .fault_tolerance = "FaultTolerance",
        .service_size = "ServiceSize",
        .storage_limit = "StorageLimit",
        .storage_unit = "StorageUnit",
    };
};
