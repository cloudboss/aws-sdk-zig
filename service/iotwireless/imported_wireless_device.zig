const ImportedSidewalkDevice = @import("imported_sidewalk_device.zig").ImportedSidewalkDevice;

/// Information about a wireless device that has been added to an import task.
pub const ImportedWirelessDevice = struct {
    /// The Sidewalk-related information about a device that has been added to an
    /// import
    /// task.
    sidewalk: ?ImportedSidewalkDevice = null,

    pub const json_field_names = .{
        .sidewalk = "Sidewalk",
    };
};
