const OutputLocationRef = @import("output_location_ref.zig").OutputLocationRef;
const MediaPackageV2GroupSettings = @import("media_package_v2_group_settings.zig").MediaPackageV2GroupSettings;

/// Media Package Group Settings
pub const MediaPackageGroupSettings = struct {
    /// MediaPackage channel destination.
    destination: OutputLocationRef,

    /// Parameters that apply only if the destination parameter (for the output
    /// group) specifies a channelGroup and channelName. Use of these two paramters
    /// indicates that the output group is for MediaPackage V2 (CMAF Ingest).
    mediapackage_v2_group_settings: ?MediaPackageV2GroupSettings,

    pub const json_field_names = .{
        .destination = "Destination",
        .mediapackage_v2_group_settings = "MediapackageV2GroupSettings",
    };
};
