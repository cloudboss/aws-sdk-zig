/// Describes the placement for a Scheduled Instance.
pub const ScheduledInstancesPlacement = struct {
    /// The Availability Zone.
    availability_zone: ?[]const u8 = null,

    /// The name of the placement group.
    group_name: ?[]const u8 = null,
};
