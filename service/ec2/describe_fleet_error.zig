const LaunchTemplateAndOverridesResponse = @import("launch_template_and_overrides_response.zig").LaunchTemplateAndOverridesResponse;
const InstanceLifecycle = @import("instance_lifecycle.zig").InstanceLifecycle;

/// Describes the instances that could not be launched by the fleet.
pub const DescribeFleetError = struct {
    /// The error code that indicates why the instance could not be launched. For
    /// more
    /// information about error codes, see [Error
    /// codes](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/errors-overview.html.html).
    error_code: ?[]const u8 = null,

    /// The error message that describes why the instance could not be launched. For
    /// more
    /// information about error messages, see [Error
    /// codes](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/errors-overview.html.html).
    error_message: ?[]const u8 = null,

    /// The launch templates and overrides that were used for launching the
    /// instances. The
    /// values that you specify in the Overrides replace the values in the launch
    /// template.
    launch_template_and_overrides: ?LaunchTemplateAndOverridesResponse = null,

    /// Indicates if the instance that could not be launched was a Spot, On-Demand,
    /// Capacity Block,
    /// or Interruptible Capacity Reservation instance.
    lifecycle: ?InstanceLifecycle = null,
};
