const NexGuardFileMarkerSettings = @import("nex_guard_file_marker_settings.zig").NexGuardFileMarkerSettings;

/// If you work with a third party video watermarking partner, use the group of
/// settings that correspond with your watermarking partner to include
/// watermarks in your output.
pub const PartnerWatermarking = struct {
    /// For forensic video watermarking, MediaConvert supports Nagra NexGuard File
    /// Marker watermarking. MediaConvert supports both PreRelease Content (NGPR/G2)
    /// and OTT Streaming workflows.
    nexguard_file_marker_settings: ?NexGuardFileMarkerSettings = null,

    pub const json_field_names = .{
        .nexguard_file_marker_settings = "NexguardFileMarkerSettings",
    };
};
