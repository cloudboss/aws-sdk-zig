/// * PSNR: Peak Signal-to-Noise Ratio * SSIM: Structural Similarity Index
///   Measure * MS_SSIM: Multi-Scale Similarity Index Measure * PSNR_HVS: Peak
///   Signal-to-Noise Ratio, Human Visual System * VMAF: Video Multi-Method
///   Assessment Fusion * QVBR: Quality-Defined Variable Bitrate. This option is
///   only available when your output uses the QVBR rate control mode. *
///   SHOT_CHANGE: Shot Changes
pub const FrameMetricType = enum {
    psnr,
    ssim,
    ms_ssim,
    psnr_hvs,
    vmaf,
    qvbr,
    shot_change,

    pub const json_field_names = .{
        .psnr = "PSNR",
        .ssim = "SSIM",
        .ms_ssim = "MS_SSIM",
        .psnr_hvs = "PSNR_HVS",
        .vmaf = "VMAF",
        .qvbr = "QVBR",
        .shot_change = "SHOT_CHANGE",
    };
};
