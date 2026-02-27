/// Sidewalk object information for updating an import task.
pub const SidewalkUpdateImportInfo = struct {
    /// The CSV file contained in an S3 bucket that's used for appending devices to
    /// an
    /// existing import task.
    device_creation_file: ?[]const u8,

    pub const json_field_names = .{
        .device_creation_file = "DeviceCreationFile",
    };
};
