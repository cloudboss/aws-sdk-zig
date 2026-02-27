const EbsStorageSettings = @import("ebs_storage_settings.zig").EbsStorageSettings;

/// The storage settings for a space.
pub const SpaceStorageSettings = struct {
    /// A collection of EBS storage settings for a space.
    ebs_storage_settings: ?EbsStorageSettings,

    pub const json_field_names = .{
        .ebs_storage_settings = "EbsStorageSettings",
    };
};
