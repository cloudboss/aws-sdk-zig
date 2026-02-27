const DefaultEbsStorageSettings = @import("default_ebs_storage_settings.zig").DefaultEbsStorageSettings;

/// The default storage settings for a space.
pub const DefaultSpaceStorageSettings = struct {
    /// The default EBS storage settings for a space.
    default_ebs_storage_settings: ?DefaultEbsStorageSettings,

    pub const json_field_names = .{
        .default_ebs_storage_settings = "DefaultEbsStorageSettings",
    };
};
