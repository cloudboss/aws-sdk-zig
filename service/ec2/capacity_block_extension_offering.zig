const CapacityReservationTenancy = @import("capacity_reservation_tenancy.zig").CapacityReservationTenancy;

/// The recommended Capacity Block extension that fits your search requirements.
pub const CapacityBlockExtensionOffering = struct {
    /// The Availability Zone of the Capacity Block that will be extended.
    availability_zone: ?[]const u8 = null,

    /// The Availability Zone ID of the Capacity Block that will be extended.
    availability_zone_id: ?[]const u8 = null,

    /// The amount of time of the Capacity Block extension offering in hours.
    capacity_block_extension_duration_hours: ?i32 = null,

    /// The date and time at which the Capacity Block extension expires. When a
    /// Capacity Block
    /// expires, the reserved capacity is released and you can no longer launch
    /// instances into
    /// it. The Capacity Block's state changes to `expired` when it reaches its end
    /// date
    capacity_block_extension_end_date: ?i64 = null,

    /// The ID of the Capacity Block extension offering.
    capacity_block_extension_offering_id: ?[]const u8 = null,

    /// The date and time at which the Capacity Block extension will start. This
    /// date is also
    /// the same as the end date of the Capacity Block that will be extended.
    capacity_block_extension_start_date: ?i64 = null,

    /// The currency of the payment for the Capacity Block extension offering.
    currency_code: ?[]const u8 = null,

    /// The number of instances in the Capacity Block extension offering.
    instance_count: ?i32 = null,

    /// The instance type of the Capacity Block that will be extended.
    instance_type: ?[]const u8 = null,

    /// The start date of the Capacity Block that will be extended.
    start_date: ?i64 = null,

    /// Indicates the tenancy of the Capacity Block extension offering. A Capacity
    /// Block can
    /// have one of the following tenancy settings:
    ///
    /// * `default` - The Capacity Block is created on hardware that is
    /// shared with other Amazon Web Services accounts.
    ///
    /// * `dedicated` - The Capacity Block is created on single-tenant
    /// hardware that is dedicated to a single Amazon Web Services account.
    tenancy: ?CapacityReservationTenancy = null,

    /// The total price of the Capacity Block extension offering, to be paid up
    /// front.
    upfront_fee: ?[]const u8 = null,
};
