const SidewalkPositioning = @import("sidewalk_positioning.zig").SidewalkPositioning;

/// Information about an import task created for an individual Sidewalk device.
pub const SidewalkSingleStartImportInfo = struct {
    /// The Positioning object of the Sidewalk device.
    positioning: ?SidewalkPositioning = null,

    /// The Sidewalk manufacturing serial number (SMSN) of the device added to the
    /// import
    /// task.
    sidewalk_manufacturing_sn: ?[]const u8 = null,

    pub const json_field_names = .{
        .positioning = "Positioning",
        .sidewalk_manufacturing_sn = "SidewalkManufacturingSn",
    };
};
