const LaunchTemplateSpecification = @import("launch_template_specification.zig").LaunchTemplateSpecification;

/// Describes an EC2 instance associated with an Auto Scaling group.
pub const AutoScalingInstanceDetails = struct {
    /// The name of the Auto Scaling group for the instance.
    auto_scaling_group_name: []const u8,

    /// The Availability Zone for the instance.
    availability_zone: []const u8,

    /// The last reported health status of this instance. `Healthy` means that the
    /// instance is healthy and should remain in service. `Unhealthy` means that the
    /// instance is unhealthy and Amazon EC2 Auto Scaling should terminate and
    /// replace it.
    health_status: []const u8,

    /// The ID of the Amazon Machine Image (AMI) associated with the instance. This
    /// field shows the
    /// current AMI ID of the instance's root volume. It may differ from the
    /// original AMI used when
    /// the instance was first launched.
    ///
    /// This field appears for:
    ///
    /// * Instances with root volume replacements through Instance Refresh
    ///
    /// * Instances launched with AMI overrides
    ///
    /// This field won't appear for:
    ///
    /// * Existing instances launched from Launch Templates without overrides
    ///
    /// * Existing instances that didn’t have their root volume replaced through
    ///   Instance Refresh
    image_id: ?[]const u8 = null,

    /// The ID of the instance.
    instance_id: []const u8,

    /// The instance type of the EC2 instance.
    instance_type: ?[]const u8 = null,

    /// The launch configuration used to launch the instance. This value is not
    /// available if
    /// you attached the instance to the Auto Scaling group.
    launch_configuration_name: ?[]const u8 = null,

    /// The launch template for the instance.
    launch_template: ?LaunchTemplateSpecification = null,

    /// The lifecycle state for the instance. The `Quarantined` state is not used.
    /// For more information, see [Amazon EC2 Auto Scaling instance
    /// lifecycle](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-lifecycle.html) in the *Amazon EC2 Auto Scaling User Guide*.
    ///
    /// Valid values: `Pending` | `Pending:Wait` |
    /// `Pending:Proceed` | `Quarantined` | `InService` |
    /// `Terminating` | `Terminating:Wait` |
    /// `Terminating:Proceed` | `Terminating:Retained` | `Terminated` | `Detaching`
    /// | `Detached` | `EnteringStandby` | `Standby` |
    /// `Warmed:Pending` | `Warmed:Pending:Wait` |
    /// `Warmed:Pending:Proceed` | `Warmed:Pending:Retained` | `Warmed:Terminating`
    /// |
    /// `Warmed:Terminating:Wait` | `Warmed:Terminating:Proceed` |
    /// `Warmed:Terminating:Retained` |
    /// `Warmed:Terminated` | `Warmed:Stopped` |
    /// `Warmed:Running`
    lifecycle_state: []const u8,

    /// Indicates whether the instance is protected from termination by Amazon EC2
    /// Auto Scaling when scaling
    /// in.
    protected_from_scale_in: bool,

    /// The number of capacity units contributed by the instance based on its
    /// instance
    /// type.
    ///
    /// Valid Range: Minimum value of 1. Maximum value of 999.
    weighted_capacity: ?[]const u8 = null,
};
