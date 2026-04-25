/// Describes the sub-geography information for an Availability Zone or Local
/// Zone.
pub const AvailabilityZoneSubGeography = struct {
    /// The name of the sub-geography, for example, `Oregon.`
    name: ?[]const u8 = null,
};
