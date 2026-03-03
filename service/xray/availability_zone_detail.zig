/// A list of Availability Zones corresponding to the segments in a trace.
pub const AvailabilityZoneDetail = struct {
    /// The name of a corresponding Availability Zone.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};
