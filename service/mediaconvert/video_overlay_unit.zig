/// Specify the Unit type to use when you enter a value for X position, Y
/// position, Width, or Height. You can choose Pixels or Percentage. Leave blank
/// to use the default value, Pixels.
pub const VideoOverlayUnit = enum {
    pixels,
    percentage,

    pub const json_field_names = .{
        .pixels = "PIXELS",
        .percentage = "PERCENTAGE",
    };
};
