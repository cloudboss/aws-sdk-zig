const MediaPackageV2AbWatermarkerIrdetoSettings = @import("media_package_v2_ab_watermarker_irdeto_settings.zig").MediaPackageV2AbWatermarkerIrdetoSettings;

/// A/B Watermarker settings for MediaPackage V2 output groups.
pub const MediaPackageV2WatermarkingSettings = struct {
    media_package_v2_ab_watermarker_irdeto_settings: ?MediaPackageV2AbWatermarkerIrdetoSettings = null,

    pub const json_field_names = .{
        .media_package_v2_ab_watermarker_irdeto_settings = "MediaPackageV2AbWatermarkerIrdetoSettings",
    };
};
