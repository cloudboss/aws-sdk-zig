const InstanceType = @import("instance_type.zig").InstanceType;
const LaunchTemplateAndOverridesResponse = @import("launch_template_and_overrides_response.zig").LaunchTemplateAndOverridesResponse;
const InstanceLifecycle = @import("instance_lifecycle.zig").InstanceLifecycle;
const PlatformValues = @import("platform_values.zig").PlatformValues;

/// Describes the instances that were launched by the fleet.
pub const DescribeFleetsInstances = struct {
    /// The IDs of the instances.
    instance_ids: ?[]const []const u8 = null,

    /// The instance type.
    instance_type: ?InstanceType = null,

    /// The launch templates and overrides that were used for launching the
    /// instances. The
    /// values that you specify in the Overrides replace the values in the launch
    /// template.
    launch_template_and_overrides: ?LaunchTemplateAndOverridesResponse = null,

    /// Indicates if the instance that was launched is a Spot Instance or On-Demand
    /// Instance.
    lifecycle: ?InstanceLifecycle = null,

    /// The value is `windows` for Windows instances in an EC2 Fleet. Otherwise, the
    /// value is
    /// blank.
    platform: ?PlatformValues = null,
};
