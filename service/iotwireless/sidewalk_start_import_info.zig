const SidewalkPositioning = @import("sidewalk_positioning.zig").SidewalkPositioning;

/// Information about an import task created for bulk provisioning.
pub const SidewalkStartImportInfo = struct {
    /// The CSV file contained in an S3 bucket that's used for adding devices to an
    /// import
    /// task.
    device_creation_file: ?[]const u8 = null,

    /// The Positioning object of the Sidewalk device.
    positioning: ?SidewalkPositioning = null,

    /// The IAM role that allows AWS IoT Wireless to access the CSV file in the S3
    /// bucket.
    role: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_creation_file = "DeviceCreationFile",
        .positioning = "Positioning",
        .role = "Role",
    };
};
