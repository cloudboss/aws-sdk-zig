const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;

/// Describes an orderable cluster option.
pub const OrderableClusterOption = struct {
    /// A list of availability zones for the orderable cluster.
    availability_zones: ?[]const AvailabilityZone = null,

    /// The cluster type, for example `multi-node`.
    cluster_type: ?[]const u8 = null,

    /// The version of the orderable cluster.
    cluster_version: ?[]const u8 = null,

    /// The node type for the orderable cluster.
    node_type: ?[]const u8 = null,
};
