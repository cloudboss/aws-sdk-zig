const MultiRegionKeyType = @import("multi_region_key_type.zig").MultiRegionKeyType;
const MultiRegionKey = @import("multi_region_key.zig").MultiRegionKey;

/// Describes the configuration of this multi-Region key. This field appears
/// only when the KMS
/// key is a primary or replica of a multi-Region key.
///
/// For more information about any listed KMS key, use the DescribeKey
/// operation.
pub const MultiRegionConfiguration = struct {
    /// Indicates whether the KMS key is a `PRIMARY` or `REPLICA`
    /// key.
    multi_region_key_type: ?MultiRegionKeyType,

    /// Displays the key ARN and Region of the primary key. This field includes the
    /// current KMS
    /// key if it is the primary key.
    primary_key: ?MultiRegionKey,

    /// displays the key ARNs and Regions of all replica keys. This field includes
    /// the current KMS
    /// key if it is a replica key.
    replica_keys: ?[]const MultiRegionKey,

    pub const json_field_names = .{
        .multi_region_key_type = "MultiRegionKeyType",
        .primary_key = "PrimaryKey",
        .replica_keys = "ReplicaKeys",
    };
};
