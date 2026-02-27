/// Contains Availability Zone information.
///
/// This data type is used as an element in the `OrderableDBInstanceOption` data
/// type.
pub const AvailabilityZone = struct {
    /// The name of the Availability Zone.
    name: ?[]const u8,
};
