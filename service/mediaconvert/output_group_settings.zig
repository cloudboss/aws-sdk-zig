const CmafGroupSettings = @import("cmaf_group_settings.zig").CmafGroupSettings;
const DashIsoGroupSettings = @import("dash_iso_group_settings.zig").DashIsoGroupSettings;
const FileGroupSettings = @import("file_group_settings.zig").FileGroupSettings;
const HlsGroupSettings = @import("hls_group_settings.zig").HlsGroupSettings;
const MsSmoothGroupSettings = @import("ms_smooth_group_settings.zig").MsSmoothGroupSettings;
const FrameMetricType = @import("frame_metric_type.zig").FrameMetricType;
const OutputGroupType = @import("output_group_type.zig").OutputGroupType;

/// Output Group settings, including type
pub const OutputGroupSettings = struct {
    /// Settings related to your CMAF output package. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/outputs-file-ABR.html.
    cmaf_group_settings: ?CmafGroupSettings,

    /// Settings related to your DASH output package. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/outputs-file-ABR.html.
    dash_iso_group_settings: ?DashIsoGroupSettings,

    /// Settings related to your File output group. MediaConvert uses this group of
    /// settings to generate a single standalone file, rather than a streaming
    /// package.
    file_group_settings: ?FileGroupSettings,

    /// Settings related to your HLS output package. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/outputs-file-ABR.html.
    hls_group_settings: ?HlsGroupSettings,

    /// Settings related to your Microsoft Smooth Streaming output package. For more
    /// information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/outputs-file-ABR.html.
    ms_smooth_group_settings: ?MsSmoothGroupSettings,

    /// Optionally choose one or more per frame metric reports to generate along
    /// with your output. You can use these metrics to analyze your video output
    /// according to one or more commonly used image quality metrics. You can
    /// specify per frame metrics for output groups or for individual outputs. When
    /// you do, MediaConvert writes a CSV (Comma-Separated Values) file to your S3
    /// output destination, named after the output name and metric type. For
    /// example: videofile_PSNR.csv Jobs that generate per frame metrics will take
    /// longer to complete, depending on the resolution and complexity of your
    /// output. For example, some 4K jobs might take up to twice as long to
    /// complete. Note that when analyzing the video quality of your output, or when
    /// comparing the video quality of multiple different outputs, we generally also
    /// recommend a detailed visual review in a controlled environment. You can
    /// choose from the following per frame metrics: * PSNR: Peak Signal-to-Noise
    /// Ratio * SSIM: Structural Similarity Index Measure * MS_SSIM: Multi-Scale
    /// Similarity Index Measure * PSNR_HVS: Peak Signal-to-Noise Ratio, Human
    /// Visual System * VMAF: Video Multi-Method Assessment Fusion * QVBR:
    /// Quality-Defined Variable Bitrate. This option is only available when your
    /// output uses the QVBR rate control mode. * SHOT_CHANGE: Shot Changes
    per_frame_metrics: ?[]const FrameMetricType,

    /// Type of output group (File group, Apple HLS, DASH ISO, Microsoft Smooth
    /// Streaming, CMAF)
    @"type": ?OutputGroupType,

    pub const json_field_names = .{
        .cmaf_group_settings = "CmafGroupSettings",
        .dash_iso_group_settings = "DashIsoGroupSettings",
        .file_group_settings = "FileGroupSettings",
        .hls_group_settings = "HlsGroupSettings",
        .ms_smooth_group_settings = "MsSmoothGroupSettings",
        .per_frame_metrics = "PerFrameMetrics",
        .@"type" = "Type",
    };
};
