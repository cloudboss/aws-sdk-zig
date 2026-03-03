const DoubleRange = @import("double_range.zig").DoubleRange;
const Range = @import("range.zig").Range;

/// Not applicable. In Neptune the storage type is managed at the DB Cluster
/// level.
pub const ValidStorageOptions = struct {
    /// Not applicable. In Neptune the storage type is managed at the DB Cluster
    /// level.
    iops_to_storage_ratio: ?[]const DoubleRange = null,

    /// Not applicable. In Neptune the storage type is managed at the DB Cluster
    /// level.
    provisioned_iops: ?[]const Range = null,

    /// Not applicable. In Neptune the storage type is managed at the DB Cluster
    /// level.
    storage_size: ?[]const Range = null,

    /// Not applicable. In Neptune the storage type is managed at the DB Cluster
    /// level.
    storage_type: ?[]const u8 = null,
};
