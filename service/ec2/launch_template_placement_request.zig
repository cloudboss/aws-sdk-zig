const Tenancy = @import("tenancy.zig").Tenancy;

/// Describes the placement of an instance.
pub const LaunchTemplatePlacementRequest = struct {
    /// The affinity setting for an instance on a Dedicated Host.
    affinity: ?[]const u8,

    /// The Availability Zone for the instance.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` can be specified, but not
    /// both
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone for the instance.
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` can be specified, but not
    /// both
    availability_zone_id: ?[]const u8,

    /// The Group Id of a placement group. You must specify the Placement Group
    /// **Group Id** to launch an instance in a shared placement
    /// group.
    group_id: ?[]const u8,

    /// The name of the placement group for the instance.
    group_name: ?[]const u8,

    /// The ID of the Dedicated Host for the instance.
    host_id: ?[]const u8,

    /// The ARN of the host resource group in which to launch the instances. If you
    /// specify a
    /// host resource group ARN, omit the **Tenancy** parameter or
    /// set it to `host`.
    host_resource_group_arn: ?[]const u8,

    /// The number of the partition the instance should launch in. Valid only if the
    /// placement
    /// group strategy is set to `partition`.
    partition_number: ?i32,

    /// Reserved for future use.
    spread_domain: ?[]const u8,

    /// The tenancy of the instance. An instance with a tenancy of dedicated runs on
    /// single-tenant hardware.
    tenancy: ?Tenancy,
};
