const Tenancy = @import("tenancy.zig").Tenancy;

/// Describes Spot Instance placement.
pub const SpotPlacement = struct {
    /// The Availability Zone. For example, `us-east-2a`.
    ///
    /// [Spot Fleet only] To specify multiple Availability Zones, separate them
    /// using commas;
    /// for example, "`us-east-2a`, `us-east-2b`".
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` must be
    /// specified in the request, but not both.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone. For example, `use2-az1`.
    ///
    /// [Spot Fleet only] To specify multiple Availability Zones, separate them
    /// using commas;
    /// for example, "`use2-az1`, `use2-bz1`".
    ///
    /// Either `AvailabilityZone` or `AvailabilityZoneId` must be
    /// specified in the request, but not both.
    availability_zone_id: ?[]const u8,

    /// The name of the placement group.
    group_name: ?[]const u8,

    /// The tenancy of the instance (if the instance is running in a VPC). An
    /// instance with a
    /// tenancy of `dedicated` runs on single-tenant hardware. The `host`
    /// tenancy is not supported for Spot Instances.
    tenancy: ?Tenancy,
};
