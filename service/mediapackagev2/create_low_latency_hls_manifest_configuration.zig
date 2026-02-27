const FilterConfiguration = @import("filter_configuration.zig").FilterConfiguration;
const ScteHls = @import("scte_hls.zig").ScteHls;
const StartTag = @import("start_tag.zig").StartTag;

/// Create a low-latency HTTP live streaming (HLS) manifest configuration.
pub const CreateLowLatencyHlsManifestConfiguration = struct {
    /// A short string that's appended to the endpoint URL. The child manifest name
    /// creates a unique path to this endpoint. If you don't enter a value,
    /// MediaPackage uses the default manifest name, index, with an added suffix to
    /// distinguish it from the manifest name. The manifestName on the HLSManifest
    /// object overrides the manifestName you provided on the originEndpoint object.
    child_manifest_name: ?[]const u8,

    filter_configuration: ?FilterConfiguration,

    /// A short short string that's appended to the endpoint URL. The manifest name
    /// creates a unique path to this endpoint. If you don't enter a value,
    /// MediaPackage uses the default manifest name, index. MediaPackage
    /// automatically inserts the format extension, such as .m3u8. You can't use the
    /// same manifest name if you use HLS manifest and low-latency HLS manifest. The
    /// manifestName on the HLSManifest object overrides the manifestName you
    /// provided on the originEndpoint object.
    manifest_name: []const u8,

    /// The total duration (in seconds) of the manifest's content.
    manifest_window_seconds: ?i32,

    /// Inserts EXT-X-PROGRAM-DATE-TIME tags in the output manifest at the interval
    /// that you specify. If you don't enter an interval, EXT-X-PROGRAM-DATE-TIME
    /// tags aren't included in the manifest. The tags sync the stream to the wall
    /// clock so that viewers can seek to a specific time in the playback timeline
    /// on the player.
    ///
    /// Irrespective of this parameter, if any ID3Timed metadata is in the HLS
    /// input, it is passed through to the HLS output.
    program_date_time_interval_seconds: ?i32,

    scte_hls: ?ScteHls,

    start_tag: ?StartTag,

    /// When enabled, MediaPackage URL-encodes the query string for API requests for
    /// LL-HLS child manifests to comply with Amazon Web Services Signature Version
    /// 4 (SigV4) signature signing protocol. For more information, see [Amazon Web
    /// Services Signature Version 4 for API
    /// requests](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_sigv.html) in *Identity and Access Management User Guide*.
    url_encode_child_manifest: ?bool,

    pub const json_field_names = .{
        .child_manifest_name = "ChildManifestName",
        .filter_configuration = "FilterConfiguration",
        .manifest_name = "ManifestName",
        .manifest_window_seconds = "ManifestWindowSeconds",
        .program_date_time_interval_seconds = "ProgramDateTimeIntervalSeconds",
        .scte_hls = "ScteHls",
        .start_tag = "StartTag",
        .url_encode_child_manifest = "UrlEncodeChildManifest",
    };
};
