const DeviceSubsetType = @import("device_subset_type.zig").DeviceSubsetType;

/// Contains information about the configurations of selected devices.
pub const DeviceSelectionConfig = struct {
    /// A filter to select devices with names containing this name.
    device_name_contains: ?[]const u8 = null,

    /// List of devices chosen to deploy.
    device_names: ?[]const []const u8 = null,

    /// Type of device subsets to deploy to the current stage.
    device_subset_type: DeviceSubsetType,

    /// Percentage of devices in the fleet to deploy to the current stage.
    percentage: ?i32 = null,

    pub const json_field_names = .{
        .device_name_contains = "DeviceNameContains",
        .device_names = "DeviceNames",
        .device_subset_type = "DeviceSubsetType",
        .percentage = "Percentage",
    };
};
