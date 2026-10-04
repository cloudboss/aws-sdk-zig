const InstanceType = @import("instance_type.zig").InstanceType;
const LaunchTemplateAndOverridesResponse = @import("launch_template_and_overrides_response.zig").LaunchTemplateAndOverridesResponse;
const InstanceLifecycle = @import("instance_lifecycle.zig").InstanceLifecycle;
const PlatformValues = @import("platform_values.zig").PlatformValues;

/// Describes the instances that were launched by the fleet.
pub const CreateFleetInstance = struct {
    /// The name of the Availability Zone in which the instance was launched. For
    /// example,
    /// `us-east-2a`.
    ///
    /// Supported only for fleets of type `instant`.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone in which the instance was launched. For
    /// example,
    /// `use2-az1`.
    ///
    /// Supported only for fleets of type `instant`.
    availability_zone_id: ?[]const u8 = null,

    /// The IDs of the instances.
    instance_ids: ?[]const []const u8 = null,

    /// The instance type.
    instance_type: ?InstanceType = null,

    /// The launch templates and overrides that were used for launching the
    /// instances. The
    /// values that you specify in the Overrides replace the values in the launch
    /// template.
    launch_template_and_overrides: ?LaunchTemplateAndOverridesResponse = null,

    /// Indicates if the instance that was launched is a Spot, On-Demand, Capacity
    /// Block for ML,
    /// or interruptible Capacity Reservation instance.
    lifecycle: ?InstanceLifecycle = null,

    /// The value is `windows` for Windows instances in an EC2 Fleet. Otherwise, the
    /// value is
    /// blank.
    platform: ?PlatformValues = null,

    /// The ID of the subnet in which the instance was launched.
    ///
    /// Supported only for fleets of type `instant`.
    subnet_id: ?[]const u8 = null,
};
