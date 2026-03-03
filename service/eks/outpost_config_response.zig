const ControlPlanePlacementResponse = @import("control_plane_placement_response.zig").ControlPlanePlacementResponse;

/// An object representing the configuration of your local Amazon EKS cluster on
/// an Amazon Web Services
/// Outpost. This API isn't available for Amazon EKS clusters on the Amazon Web
/// Services cloud.
pub const OutpostConfigResponse = struct {
    /// The Amazon EC2 instance type used for the control plane. The instance type
    /// is the same for
    /// all control plane instances.
    control_plane_instance_type: []const u8,

    /// An object representing the placement configuration for all the control plane
    /// instances
    /// of your local Amazon EKS cluster on an Amazon Web Services Outpost. For more
    /// information, see [Capacity
    /// considerations](https://docs.aws.amazon.com/eks/latest/userguide/eks-outposts-capacity-considerations.html) in the *Amazon EKS User Guide*.
    control_plane_placement: ?ControlPlanePlacementResponse = null,

    /// The ARN of the Outpost that you specified for use with your local Amazon EKS
    /// cluster on
    /// Outposts.
    outpost_arns: []const []const u8,

    pub const json_field_names = .{
        .control_plane_instance_type = "controlPlaneInstanceType",
        .control_plane_placement = "controlPlanePlacement",
        .outpost_arns = "outpostArns",
    };
};
