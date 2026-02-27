const CidrCollectionChangeAction = @import("cidr_collection_change_action.zig").CidrCollectionChangeAction;

/// A complex type that contains information about the CIDR collection change.
pub const CidrCollectionChange = struct {
    /// CIDR collection change action.
    action: CidrCollectionChangeAction,

    /// List of CIDR blocks.
    cidr_list: []const []const u8,

    /// Name of the location that is associated with the CIDR collection.
    location_name: []const u8,
};
