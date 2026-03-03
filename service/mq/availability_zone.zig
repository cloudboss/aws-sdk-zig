/// Name of the availability zone.
pub const AvailabilityZone = struct {
    /// Id for the availability zone.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};
