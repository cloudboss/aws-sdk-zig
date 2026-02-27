/// An over-the-air update (OTA) job configuration.
pub const OTAJobConfig = struct {
    /// Whether to apply the update if it is a major version change.
    allow_major_version_update: bool = false,

    /// The target version of the device software.
    image_version: []const u8,

    pub const json_field_names = .{
        .allow_major_version_update = "AllowMajorVersionUpdate",
        .image_version = "ImageVersion",
    };
};
