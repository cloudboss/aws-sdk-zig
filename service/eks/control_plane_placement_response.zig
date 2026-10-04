const SpreadLevel = @import("spread_level.zig").SpreadLevel;

/// The placement configuration for all the control plane instances of your
/// local Amazon EKS
/// cluster on an Amazon Web Services Outpost. For more information, see
/// [Capacity
/// considerations](https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-capacity-considerations.html) in the *Amazon EKS User Guide*.
pub const ControlPlanePlacementResponse = struct {
    /// The name of the placement group for the Kubernetes control plane instances.
    group_name: ?[]const u8 = null,

    /// The spread level used with the placement group for control plane instances
    /// on your local Amazon EKS cluster on Amazon Web Services Outposts.
    spread_level: ?SpreadLevel = null,

    pub const json_field_names = .{
        .group_name = "groupName",
        .spread_level = "spreadLevel",
    };
};
