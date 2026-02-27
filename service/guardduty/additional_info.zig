/// Contains additional information about the detected threat.
pub const AdditionalInfo = struct {
    /// The device name of the EBS volume, if applicable.
    device_name: ?[]const u8,

    /// The version ID of the S3 object, if applicable.
    version_id: ?[]const u8,

    pub const json_field_names = .{
        .device_name = "DeviceName",
        .version_id = "VersionId",
    };
};
