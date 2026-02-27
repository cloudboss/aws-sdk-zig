/// The Positioning object of the Sidewalk device.
pub const SidewalkPositioning = struct {
    /// The location destination name of the Sidewalk device.
    destination_name: ?[]const u8,

    pub const json_field_names = .{
        .destination_name = "DestinationName",
    };
};
