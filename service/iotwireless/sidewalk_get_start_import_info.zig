const SidewalkPositioning = @import("sidewalk_positioning.zig").SidewalkPositioning;

/// Sidewalk-related information for devices in an import task that are being
/// onboarded.
pub const SidewalkGetStartImportInfo = struct {
    /// List of Sidewalk devices that are added to the import task.
    device_creation_file_list: ?[]const []const u8,

    /// The Positioning object of the Sidewalk device.
    positioning: ?SidewalkPositioning,

    /// The IAM role that allows AWS IoT Wireless to access the CSV file in the S3
    /// bucket.
    role: ?[]const u8,

    pub const json_field_names = .{
        .device_creation_file_list = "DeviceCreationFileList",
        .positioning = "Positioning",
        .role = "Role",
    };
};
