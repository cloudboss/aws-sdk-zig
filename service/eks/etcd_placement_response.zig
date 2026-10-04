const SpreadLevel = @import("spread_level.zig").SpreadLevel;

/// The placement configuration for the etcd instances of your local Amazon EKS
/// cluster on an Amazon Web Services Outpost. For more information, see
/// [Capacity
/// considerations](https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-capacity-considerations.html) in the *Amazon EKS User Guide*.
pub const EtcdPlacementResponse = struct {
    /// The spread level used with the placement group for etcd instances on your
    /// local Amazon EKS cluster on Amazon Web Services Outposts.
    spread_level: ?SpreadLevel = null,

    pub const json_field_names = .{
        .spread_level = "spreadLevel",
    };
};
