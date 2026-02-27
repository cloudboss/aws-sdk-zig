const MssEncryption = @import("mss_encryption.zig").MssEncryption;
const StreamSelection = @import("stream_selection.zig").StreamSelection;

/// A Microsoft Smooth Streaming (MSS) packaging configuration.
pub const MssPackage = struct {
    encryption: ?MssEncryption,

    /// The time window (in seconds) contained in each manifest.
    manifest_window_seconds: ?i32,

    /// The duration (in seconds) of each segment.
    segment_duration_seconds: ?i32,

    stream_selection: ?StreamSelection,

    pub const json_field_names = .{
        .encryption = "Encryption",
        .manifest_window_seconds = "ManifestWindowSeconds",
        .segment_duration_seconds = "SegmentDurationSeconds",
        .stream_selection = "StreamSelection",
    };
};
