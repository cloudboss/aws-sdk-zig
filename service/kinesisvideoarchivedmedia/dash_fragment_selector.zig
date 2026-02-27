const DASHFragmentSelectorType = @import("dash_fragment_selector_type.zig").DASHFragmentSelectorType;
const DASHTimestampRange = @import("dash_timestamp_range.zig").DASHTimestampRange;

/// Contains the range of timestamps for the requested media, and the source of
/// the
/// timestamps.
pub const DASHFragmentSelector = struct {
    /// The source of the timestamps for the requested media.
    ///
    /// When `FragmentSelectorType` is set to `PRODUCER_TIMESTAMP` and
    /// GetDASHStreamingSessionURLInput$PlaybackMode is
    /// `ON_DEMAND` or `LIVE_REPLAY`, the first fragment ingested with
    /// a producer timestamp within the specified FragmentSelector$TimestampRange is
    /// included in the media playlist. In
    /// addition, the fragments with producer timestamps within the `TimestampRange`
    /// ingested immediately following the first fragment (up to the
    /// GetDASHStreamingSessionURLInput$MaxManifestFragmentResults value) are
    /// included.
    ///
    /// Fragments that have duplicate producer timestamps are deduplicated. This
    /// means that if
    /// producers are producing a stream of fragments with producer timestamps that
    /// are
    /// approximately equal to the true clock time, the MPEG-DASH manifest will
    /// contain all of
    /// the fragments within the requested timestamp range. If some fragments are
    /// ingested
    /// within the same time range and very different points in time, only the
    /// oldest ingested
    /// collection of fragments are returned.
    ///
    /// When `FragmentSelectorType` is set to `PRODUCER_TIMESTAMP` and
    /// GetDASHStreamingSessionURLInput$PlaybackMode is `LIVE`,
    /// the producer timestamps are used in the MP4 fragments and for deduplication.
    /// But the
    /// most recently ingested fragments based on server timestamps are included in
    /// the
    /// MPEG-DASH manifest. This means that even if fragments ingested in the past
    /// have producer
    /// timestamps with values now, they are not included in the HLS media playlist.
    ///
    /// The default is `SERVER_TIMESTAMP`.
    fragment_selector_type: ?DASHFragmentSelectorType,

    /// The start and end of the timestamp range for the requested media.
    ///
    /// This value should not be present if `PlaybackType` is
    /// `LIVE`.
    timestamp_range: ?DASHTimestampRange,

    pub const json_field_names = .{
        .fragment_selector_type = "FragmentSelectorType",
        .timestamp_range = "TimestampRange",
    };
};
