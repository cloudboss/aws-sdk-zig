const LaunchTemplateSpecification = @import("launch_template_specification.zig").LaunchTemplateSpecification;
const LifecycleState = @import("lifecycle_state.zig").LifecycleState;

/// Describes an EC2 instance.
pub const Instance = struct {
    /// The Availability Zone in which the instance is running.
    availability_zone: []const u8,

    /// The last reported health status of the instance. `Healthy` means that the
    /// instance is healthy and should remain in service. `Unhealthy` means that the
    /// instance is unhealthy and that Amazon EC2 Auto Scaling should terminate and
    /// replace it.
    health_status: []const u8,

    /// The ID of the Amazon Machine Image (AMI) used for the instance's current
    /// root volume.
    /// This value reflects the most recent AMI applied to the instance, including
    /// updates made
    /// through root volume replacement operations.
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
    image_id: ?[]const u8,

    /// The ID of the instance.
    instance_id: []const u8,

    /// The instance type of the EC2 instance.
    instance_type: ?[]const u8,

    /// The launch configuration associated with the instance.
    launch_configuration_name: ?[]const u8,

    /// The launch template for the instance.
    launch_template: ?LaunchTemplateSpecification,

    /// A description of the current lifecycle state. The `Quarantined` state is
    /// not used. For more information, see [Amazon EC2 Auto Scaling instance
    /// lifecycle](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-lifecycle.html) in the *Amazon EC2 Auto Scaling User Guide*.
    lifecycle_state: LifecycleState,

    /// Indicates whether the instance is protected from termination by Amazon EC2
    /// Auto Scaling when scaling
    /// in.
    protected_from_scale_in: bool,

    /// The number of capacity units contributed by the instance based on its
    /// instance
    /// type.
    ///
    /// Valid Range: Minimum value of 1. Maximum value of 999.
    weighted_capacity: ?[]const u8,
};
