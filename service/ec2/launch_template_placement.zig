const Tenancy = @import("tenancy.zig").Tenancy;

/// Describes the placement of an instance.
pub const LaunchTemplatePlacement = struct {
    /// The affinity setting for the instance on the Dedicated Host.
    affinity: ?[]const u8,

    /// The Availability Zone of the instance.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone of the instance.
    availability_zone_id: ?[]const u8,

    /// The Group ID of the placement group. You must specify the Placement Group
    /// **Group ID** to launch an instance in a shared placement
    /// group.
    group_id: ?[]const u8,

    /// The name of the placement group for the instance.
    group_name: ?[]const u8,

    /// The ID of the Dedicated Host for the instance.
    host_id: ?[]const u8,

    /// The ARN of the host resource group in which to launch the instances.
    host_resource_group_arn: ?[]const u8,

    /// The number of the partition the instance should launch in. Valid only if the
    /// placement
    /// group strategy is set to `partition`.
    partition_number: ?i32,

    /// Reserved for future use.
    spread_domain: ?[]const u8,

    /// The tenancy of the instance. An instance with a tenancy of `dedicated` runs
    /// on single-tenant hardware.
    tenancy: ?Tenancy,
};
