/// Describes a resource group to which a Capacity Reservation has been added.
pub const CapacityReservationGroup = struct {
    /// The ARN of the resource group.
    group_arn: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the resource group.
    owner_id: ?[]const u8,
};
