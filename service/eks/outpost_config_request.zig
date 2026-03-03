const ControlPlanePlacementRequest = @import("control_plane_placement_request.zig").ControlPlanePlacementRequest;

/// The configuration of your local Amazon EKS cluster on an Amazon Web Services
/// Outpost. Before creating a
/// cluster on an Outpost, review [Creating a local
/// cluster on an
/// Outpost](https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-local-cluster-create.html) in the *Amazon EKS User Guide*. This API isn't available for
/// Amazon EKS clusters on the Amazon Web Services cloud.
pub const OutpostConfigRequest = struct {
    /// The Amazon EC2 instance type that you want to use for your local Amazon EKS
    /// cluster on Outposts.
    /// Choose an instance type based on the number of nodes that your cluster will
    /// have. For
    /// more information, see [Capacity
    /// considerations](https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-capacity-considerations.html) in the *Amazon EKS User Guide*.
    ///
    /// The instance type that you specify is used for all Kubernetes control plane
    /// instances. The
    /// instance type can't be changed after cluster creation. The control plane is
    /// not
    /// automatically scaled by Amazon EKS.
    control_plane_instance_type: []const u8,

    /// An object representing the placement configuration for all the control plane
    /// instances
    /// of your local Amazon EKS cluster on an Amazon Web Services Outpost. For more
    /// information, see [Capacity
    /// considerations](https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-capacity-considerations.html) in the *Amazon EKS User Guide*.
    control_plane_placement: ?ControlPlanePlacementRequest = null,

    /// The ARN of the Outpost that you want to use for your local Amazon EKS
    /// cluster on
    /// Outposts. Only a single Outpost ARN is supported.
    outpost_arns: []const []const u8,

    pub const json_field_names = .{
        .control_plane_instance_type = "controlPlaneInstanceType",
        .control_plane_placement = "controlPlanePlacement",
        .outpost_arns = "outpostArns",
    };
};
