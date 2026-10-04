const SpreadLevel = @import("spread_level.zig").SpreadLevel;

/// The placement configuration for the etcd instances of your local Amazon EKS
/// cluster on an Amazon Web Services Outpost. For more information, see
/// [Capacity
/// considerations](https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-capacity-considerations.html) in the *Amazon EKS User Guide*.
pub const EtcdPlacementRequest = struct {
    /// Optional parameter to specify the placement group spread level for etcd
    /// instances. If not provided, Amazon EKS will deploy etcd instances without a
    /// placement group.
    spread_level: ?SpreadLevel = null,

    pub const json_field_names = .{
        .spread_level = "spreadLevel",
    };
};
