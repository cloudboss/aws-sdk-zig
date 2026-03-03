const ArchiveGroupSettings = @import("archive_group_settings.zig").ArchiveGroupSettings;
const CmafIngestGroupSettings = @import("cmaf_ingest_group_settings.zig").CmafIngestGroupSettings;
const FrameCaptureGroupSettings = @import("frame_capture_group_settings.zig").FrameCaptureGroupSettings;
const HlsGroupSettings = @import("hls_group_settings.zig").HlsGroupSettings;
const MediaPackageGroupSettings = @import("media_package_group_settings.zig").MediaPackageGroupSettings;
const MsSmoothGroupSettings = @import("ms_smooth_group_settings.zig").MsSmoothGroupSettings;
const MultiplexGroupSettings = @import("multiplex_group_settings.zig").MultiplexGroupSettings;
const RtmpGroupSettings = @import("rtmp_group_settings.zig").RtmpGroupSettings;
const SrtGroupSettings = @import("srt_group_settings.zig").SrtGroupSettings;
const UdpGroupSettings = @import("udp_group_settings.zig").UdpGroupSettings;

/// Output Group Settings
pub const OutputGroupSettings = struct {
    archive_group_settings: ?ArchiveGroupSettings = null,

    cmaf_ingest_group_settings: ?CmafIngestGroupSettings = null,

    frame_capture_group_settings: ?FrameCaptureGroupSettings = null,

    hls_group_settings: ?HlsGroupSettings = null,

    media_package_group_settings: ?MediaPackageGroupSettings = null,

    ms_smooth_group_settings: ?MsSmoothGroupSettings = null,

    multiplex_group_settings: ?MultiplexGroupSettings = null,

    rtmp_group_settings: ?RtmpGroupSettings = null,

    srt_group_settings: ?SrtGroupSettings = null,

    udp_group_settings: ?UdpGroupSettings = null,

    pub const json_field_names = .{
        .archive_group_settings = "ArchiveGroupSettings",
        .cmaf_ingest_group_settings = "CmafIngestGroupSettings",
        .frame_capture_group_settings = "FrameCaptureGroupSettings",
        .hls_group_settings = "HlsGroupSettings",
        .media_package_group_settings = "MediaPackageGroupSettings",
        .ms_smooth_group_settings = "MsSmoothGroupSettings",
        .multiplex_group_settings = "MultiplexGroupSettings",
        .rtmp_group_settings = "RtmpGroupSettings",
        .srt_group_settings = "SrtGroupSettings",
        .udp_group_settings = "UdpGroupSettings",
    };
};
