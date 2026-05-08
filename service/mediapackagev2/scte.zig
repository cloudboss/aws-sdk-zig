const CustomAdType = @import("custom_ad_type.zig").CustomAdType;
const ScteFilter = @import("scte_filter.zig").ScteFilter;
const ScteInSegments = @import("scte_in_segments.zig").ScteInSegments;

/// The SCTE configuration.
pub const Scte = struct {
    /// A list of additional non-Ad SCTE-35 event types to treat as advertisements.
    /// When configured, events matching these types produce ad markers (such as
    /// `SCTE35-OUT` and `SCTE35-IN` in HLS DATERANGE tags) in manifests.
    ///
    /// Valid values: `PROGRAM` | `CHAPTER` | `UNSCHEDULED_EVENT` |
    /// `ALTERNATE_CONTENT_OPPORTUNITY` | `NETWORK`
    ///
    /// If you don't specify any values, the default is empty (only default ad types
    /// are used).
    custom_ad_types: ?[]const CustomAdType = null,

    /// The SCTE-35 message types that you want to be treated as ad markers in the
    /// output.
    scte_filter: ?[]const ScteFilter = null,

    /// Controls whether SCTE-35 messages are included in segment files.
    ///
    /// * None – SCTE-35 messages are not included in segments (default)
    /// * All – SCTE-35 messages are embedded in segment data
    /// * MatchesFilter – SCTE-35 messages which match the ScteFilter are embedded
    ///   in segment data
    ///
    /// For DASH manifests, when set to `All` or `MatchesFilter`, an
    /// `InbandEventStream` tag signals that SCTE messages are present in segments.
    /// This setting works independently of manifest ad markers.
    scte_in_segments: ?ScteInSegments = null,

    pub const json_field_names = .{
        .custom_ad_types = "CustomAdTypes",
        .scte_filter = "ScteFilter",
        .scte_in_segments = "ScteInSegments",
    };
};
