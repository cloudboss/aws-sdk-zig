const ManagedDraining = @import("managed_draining.zig").ManagedDraining;
const ManagedScaling = @import("managed_scaling.zig").ManagedScaling;
const ManagedTerminationProtection = @import("managed_termination_protection.zig").ManagedTerminationProtection;

/// The details of the Auto Scaling group capacity provider to update.
pub const AutoScalingGroupProviderUpdate = struct {
    /// The managed draining option for the Auto Scaling group capacity provider.
    /// When you enable this, Amazon ECS manages and gracefully drains the EC2
    /// container instances that are in the Auto Scaling group capacity provider.
    managed_draining: ?ManagedDraining = null,

    /// The managed scaling settings for the Auto Scaling group capacity provider.
    managed_scaling: ?ManagedScaling = null,

    /// The managed termination protection setting to use for the Auto Scaling group
    /// capacity provider. This determines whether the Auto Scaling group has
    /// managed termination protection.
    ///
    /// When using managed termination protection, managed scaling must also be used
    /// otherwise managed termination protection doesn't work.
    ///
    /// When managed termination protection is on, Amazon ECS prevents the Amazon
    /// EC2 instances in an Auto Scaling group that contain tasks from being
    /// terminated during a scale-in action. The Auto Scaling group and each
    /// instance in the Auto Scaling group must have instance protection from
    /// scale-in actions on. For more information, see [Instance
    /// Protection](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-instance-termination.html#instance-protection) in the *Auto Scaling User Guide*.
    ///
    /// When managed termination protection is off, your Amazon EC2 instances aren't
    /// protected from termination when the Auto Scaling group scales in.
    managed_termination_protection: ?ManagedTerminationProtection = null,

    pub const json_field_names = .{
        .managed_draining = "managedDraining",
        .managed_scaling = "managedScaling",
        .managed_termination_protection = "managedTerminationProtection",
    };
};
