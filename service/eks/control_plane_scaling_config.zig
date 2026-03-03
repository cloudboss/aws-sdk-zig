const ProvisionedControlPlaneTier = @import("provisioned_control_plane_tier.zig").ProvisionedControlPlaneTier;

/// The control plane scaling tier configuration. For more information, see EKS
/// Provisioned Control Plane in the Amazon EKS User Guide.
pub const ControlPlaneScalingConfig = struct {
    /// The control plane scaling tier configuration. Available options are
    /// `standard`, `tier-xl`, `tier-2xl`, or `tier-4xl`. For more information, see
    /// EKS Provisioned Control Plane in the Amazon EKS User Guide.
    tier: ?ProvisionedControlPlaneTier = null,

    pub const json_field_names = .{
        .tier = "tier",
    };
};
