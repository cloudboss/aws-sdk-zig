const ManagedDraining = @import("managed_draining.zig").ManagedDraining;
const ManagedScaling = @import("managed_scaling.zig").ManagedScaling;
const ManagedTerminationProtection = @import("managed_termination_protection.zig").ManagedTerminationProtection;

/// The details of the Auto Scaling group for the capacity provider.
pub const AutoScalingGroupProvider = struct {
    /// The Amazon Resource Name (ARN) that identifies the Auto Scaling group, or
    /// the Auto
    /// Scaling group name.
    auto_scaling_group_arn: []const u8,

    /// The managed draining option for the Auto Scaling group capacity provider.
    /// When you
    /// enable this, Amazon ECS manages and gracefully drains the EC2 container
    /// instances that
    /// are in the Auto Scaling group capacity provider.
    managed_draining: ?ManagedDraining,

    /// The managed scaling settings for the Auto Scaling group capacity provider.
    managed_scaling: ?ManagedScaling,

    /// The managed termination protection setting to use for the Auto Scaling group
    /// capacity
    /// provider. This determines whether the Auto Scaling group has managed
    /// termination
    /// protection. The default is off.
    ///
    /// When using managed termination protection, managed scaling must also be used
    /// otherwise managed termination protection doesn't work.
    ///
    /// When managed termination protection is on, Amazon ECS prevents the Amazon
    /// EC2
    /// instances in an Auto Scaling group that contain tasks from being terminated
    /// during a
    /// scale-in action. The Auto Scaling group and each instance in the Auto
    /// Scaling group must
    /// have instance protection from scale-in actions on as well. For more
    /// information, see
    /// [Instance
    /// Protection](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-instance-termination.html#instance-protection) in the *Auto Scaling User
    /// Guide*.
    ///
    /// When managed termination protection is off, your Amazon EC2 instances aren't
    /// protected
    /// from termination when the Auto Scaling group scales in.
    managed_termination_protection: ?ManagedTerminationProtection,

    pub const json_field_names = .{
        .auto_scaling_group_arn = "autoScalingGroupArn",
        .managed_draining = "managedDraining",
        .managed_scaling = "managedScaling",
        .managed_termination_protection = "managedTerminationProtection",
    };
};
