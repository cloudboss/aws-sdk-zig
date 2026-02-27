const ArchiveOutputSettings = @import("archive_output_settings.zig").ArchiveOutputSettings;
const CmafIngestOutputSettings = @import("cmaf_ingest_output_settings.zig").CmafIngestOutputSettings;
const FrameCaptureOutputSettings = @import("frame_capture_output_settings.zig").FrameCaptureOutputSettings;
const HlsOutputSettings = @import("hls_output_settings.zig").HlsOutputSettings;
const MediaPackageOutputSettings = @import("media_package_output_settings.zig").MediaPackageOutputSettings;
const MsSmoothOutputSettings = @import("ms_smooth_output_settings.zig").MsSmoothOutputSettings;
const MultiplexOutputSettings = @import("multiplex_output_settings.zig").MultiplexOutputSettings;
const RtmpOutputSettings = @import("rtmp_output_settings.zig").RtmpOutputSettings;
const SrtOutputSettings = @import("srt_output_settings.zig").SrtOutputSettings;
const UdpOutputSettings = @import("udp_output_settings.zig").UdpOutputSettings;

/// Output Settings
pub const OutputSettings = struct {
    archive_output_settings: ?ArchiveOutputSettings,

    cmaf_ingest_output_settings: ?CmafIngestOutputSettings,

    frame_capture_output_settings: ?FrameCaptureOutputSettings,

    hls_output_settings: ?HlsOutputSettings,

    media_package_output_settings: ?MediaPackageOutputSettings,

    ms_smooth_output_settings: ?MsSmoothOutputSettings,

    multiplex_output_settings: ?MultiplexOutputSettings,

    rtmp_output_settings: ?RtmpOutputSettings,

    srt_output_settings: ?SrtOutputSettings,

    udp_output_settings: ?UdpOutputSettings,

    pub const json_field_names = .{
        .archive_output_settings = "ArchiveOutputSettings",
        .cmaf_ingest_output_settings = "CmafIngestOutputSettings",
        .frame_capture_output_settings = "FrameCaptureOutputSettings",
        .hls_output_settings = "HlsOutputSettings",
        .media_package_output_settings = "MediaPackageOutputSettings",
        .ms_smooth_output_settings = "MsSmoothOutputSettings",
        .multiplex_output_settings = "MultiplexOutputSettings",
        .rtmp_output_settings = "RtmpOutputSettings",
        .srt_output_settings = "SrtOutputSettings",
        .udp_output_settings = "UdpOutputSettings",
    };
};
