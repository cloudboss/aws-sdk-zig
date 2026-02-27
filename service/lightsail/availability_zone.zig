/// Describes an Availability Zone. This is returned only as part of a
/// `GetRegions`
/// request.
pub const AvailabilityZone = struct {
    /// The state of the Availability Zone.
    state: ?[]const u8,

    /// The name of the Availability Zone. The format is `us-east-2a`
    /// (case-sensitive).
    zone_name: ?[]const u8,

    pub const json_field_names = .{
        .state = "state",
        .zone_name = "zoneName",
    };
};
