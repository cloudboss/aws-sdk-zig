const SpreadLevel = @import("spread_level.zig").SpreadLevel;

/// The placement configuration for all the control plane instances of your
/// local Amazon EKS
/// cluster on an Amazon Web Services Outpost. For more information, see
/// [Capacity
/// considerations](https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-capacity-considerations.html) in the *Amazon EKS User Guide*.
pub const ControlPlanePlacementRequest = struct {
    /// The name of the placement group for the Kubernetes control plane instances.
    /// This setting
    /// can't be changed after cluster creation.
    group_name: ?[]const u8 = null,

    /// Optional parameter to specify the placement group spread level for control
    /// plane instances. If not provided, Amazon EKS will deploy control plane
    /// instances without a placement group.
    spread_level: ?SpreadLevel = null,

    pub const json_field_names = .{
        .group_name = "groupName",
        .spread_level = "spreadLevel",
    };
};
