const CapacityReservationTenancy = @import("capacity_reservation_tenancy.zig").CapacityReservationTenancy;

/// The recommended Capacity Block that fits your search requirements.
pub const CapacityBlockOffering = struct {
    /// The Availability Zone of the Capacity Block offering.
    availability_zone: ?[]const u8 = null,

    /// The number of hours (in addition to `capacityBlockDurationMinutes`) for the
    /// duration of the Capacity Block reservation. For example, if a Capacity Block
    /// starts at
    /// **04:55** and ends at **11:30**, the hours field would be **6**.
    capacity_block_duration_hours: ?i32 = null,

    /// The number of minutes (in addition to `capacityBlockDurationHours`) for the
    /// duration of the Capacity Block reservation. For example, if a Capacity Block
    /// starts at
    /// **08:55** and ends at **11:30**, the minutes field would be **35**.
    capacity_block_duration_minutes: ?i32 = null,

    /// The ID of the Capacity Block offering.
    capacity_block_offering_id: ?[]const u8 = null,

    /// The currency of the payment for the Capacity Block.
    currency_code: ?[]const u8 = null,

    /// The end date of the Capacity Block offering.
    end_date: ?i64 = null,

    /// The number of instances in the Capacity Block offering.
    instance_count: ?i32 = null,

    /// The instance type of the Capacity Block offering.
    instance_type: ?[]const u8 = null,

    /// The start date of the Capacity Block offering.
    start_date: ?i64 = null,

    /// The tenancy of the Capacity Block.
    tenancy: ?CapacityReservationTenancy = null,

    /// The number of EC2 UltraServers in the offering.
    ultraserver_count: ?i32 = null,

    /// The EC2 UltraServer type of the Capacity Block offering.
    ultraserver_type: ?[]const u8 = null,

    /// The total price to be paid up front.
    upfront_fee: ?[]const u8 = null,

    /// The type of zone where the Capacity Block offering is available.
    zone_type: ?[]const u8 = null,
};
