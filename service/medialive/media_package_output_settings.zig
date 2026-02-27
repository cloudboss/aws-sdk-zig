const MediaPackageV2DestinationSettings = @import("media_package_v2_destination_settings.zig").MediaPackageV2DestinationSettings;

/// Media Package Output Settings
pub const MediaPackageOutputSettings = struct {
    /// Optional settings for MediaPackage V2 destinations
    media_package_v2_destination_settings: ?MediaPackageV2DestinationSettings,

    pub const json_field_names = .{
        .media_package_v2_destination_settings = "MediaPackageV2DestinationSettings",
    };
};
