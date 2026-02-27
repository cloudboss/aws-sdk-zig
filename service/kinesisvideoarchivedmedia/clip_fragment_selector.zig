const ClipFragmentSelectorType = @import("clip_fragment_selector_type.zig").ClipFragmentSelectorType;
const ClipTimestampRange = @import("clip_timestamp_range.zig").ClipTimestampRange;

/// Describes the timestamp range and timestamp origin of a range of fragments.
///
/// Fragments that have duplicate producer timestamps are deduplicated. This
/// means that if
/// producers are producing a stream of fragments with producer timestamps that
/// are
/// approximately equal to the true clock time, the clip will contain all of the
/// fragments
/// within the requested timestamp range. If some fragments are ingested within
/// the same
/// time range and very different points in time, only the oldest ingested
/// collection of
/// fragments are returned.
pub const ClipFragmentSelector = struct {
    /// The origin of the timestamps to use (Server or Producer).
    fragment_selector_type: ClipFragmentSelectorType,

    /// The range of timestamps to return.
    timestamp_range: ClipTimestampRange,

    pub const json_field_names = .{
        .fragment_selector_type = "FragmentSelectorType",
        .timestamp_range = "TimestampRange",
    };
};
