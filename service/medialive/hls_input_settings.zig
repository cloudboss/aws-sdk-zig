const HlsScte35SourceType = @import("hls_scte_35_source_type.zig").HlsScte35SourceType;

/// Hls Input Settings
pub const HlsInputSettings = struct {
    /// When specified the HLS stream with the m3u8 BANDWIDTH that most closely
    /// matches this value will be chosen, otherwise the highest bandwidth stream in
    /// the m3u8 will be chosen. The bitrate is specified in bits per second, as in
    /// an HLS manifest.
    bandwidth: ?i32,

    /// When specified, reading of the HLS input will begin this many buffer
    /// segments from the end (most recently written segment). When not specified,
    /// the HLS input will begin with the first segment specified in the m3u8.
    buffer_segments: ?i32,

    /// The number of consecutive times that attempts to read a manifest or segment
    /// must fail before the input is considered unavailable.
    retries: ?i32,

    /// The number of seconds between retries when an attempt to read a manifest or
    /// segment fails.
    retry_interval: ?i32,

    /// Identifies the source for the SCTE-35 messages that MediaLive will ingest.
    /// Messages can be ingested from the content segments (in the stream) or from
    /// tags in the playlist (the HLS manifest). MediaLive ignores SCTE-35
    /// information in the source that is not selected.
    scte_35_source: ?HlsScte35SourceType,

    pub const json_field_names = .{
        .bandwidth = "Bandwidth",
        .buffer_segments = "BufferSegments",
        .retries = "Retries",
        .retry_interval = "RetryInterval",
        .scte_35_source = "Scte35Source",
    };
};
