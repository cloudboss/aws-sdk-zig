const SidewalkPositioning = @import("sidewalk_positioning.zig").SidewalkPositioning;

/// The Sidewalk-related object containing positioning information used to
/// configure Sidewalk devices during import.
pub const SidewalkListDevicesForImportInfo = struct {
    /// The Positioning object of the Sidewalk device.
    positioning: ?SidewalkPositioning = null,

    pub const json_field_names = .{
        .positioning = "Positioning",
    };
};
