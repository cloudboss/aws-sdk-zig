const FragmentSelectorType = @import("fragment_selector_type.zig").FragmentSelectorType;
const TimestampRange = @import("timestamp_range.zig").TimestampRange;

/// Describes the timestamp range and timestamp origin of a range of fragments.
///
/// Only fragments with a start timestamp greater than or equal to the given
/// start time
/// and less than or equal to the end time are returned. For example, if a
/// stream contains
/// fragments with the following start timestamps:
///
/// * 00:00:00
///
/// * 00:00:02
///
/// * 00:00:04
///
/// * 00:00:06
///
/// A fragment selector range with a start time of 00:00:01 and end time of
/// 00:00:04
/// would return the fragments with start times of 00:00:02 and 00:00:04.
pub const FragmentSelector = struct {
    /// The origin of the timestamps to use (Server or Producer).
    fragment_selector_type: FragmentSelectorType,

    /// The range of timestamps to return.
    timestamp_range: TimestampRange,

    pub const json_field_names = .{
        .fragment_selector_type = "FragmentSelectorType",
        .timestamp_range = "TimestampRange",
    };
};
