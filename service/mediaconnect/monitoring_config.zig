const AudioMonitoringSetting = @import("audio_monitoring_setting.zig").AudioMonitoringSetting;
const ContentQualityAnalysisState = @import("content_quality_analysis_state.zig").ContentQualityAnalysisState;
const ThumbnailState = @import("thumbnail_state.zig").ThumbnailState;
const VideoMonitoringSetting = @import("video_monitoring_setting.zig").VideoMonitoringSetting;

/// The settings for source monitoring.
pub const MonitoringConfig = struct {
    /// Contains the settings for audio stream metrics monitoring.
    audio_monitoring_settings: ?[]const AudioMonitoringSetting,

    /// Indicates whether content quality analysis is enabled or disabled.
    content_quality_analysis_state: ?ContentQualityAnalysisState,

    /// Indicates whether thumbnails are enabled or disabled.
    thumbnail_state: ?ThumbnailState,

    /// Contains the settings for video stream metrics monitoring.
    video_monitoring_settings: ?[]const VideoMonitoringSetting,

    pub const json_field_names = .{
        .audio_monitoring_settings = "AudioMonitoringSettings",
        .content_quality_analysis_state = "ContentQualityAnalysisState",
        .thumbnail_state = "ThumbnailState",
        .video_monitoring_settings = "VideoMonitoringSettings",
    };
};
