const CmafIngestAbWatermarkerIrdetoSettings = @import("cmaf_ingest_ab_watermarker_irdeto_settings.zig").CmafIngestAbWatermarkerIrdetoSettings;

/// A/B Watermarker settings for CMAF Ingest output groups.
pub const CmafIngestWatermarkingSettings = struct {
    cmaf_ingest_ab_watermarker_irdeto_settings: ?CmafIngestAbWatermarkerIrdetoSettings = null,

    pub const json_field_names = .{
        .cmaf_ingest_ab_watermarker_irdeto_settings = "CmafIngestAbWatermarkerIrdetoSettings",
    };
};
