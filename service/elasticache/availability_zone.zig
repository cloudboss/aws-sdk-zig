/// Describes an Availability Zone in which the cluster is launched.
pub const AvailabilityZone = struct {
    /// The name of the Availability Zone.
    name: ?[]const u8 = null,
};
