const TimeAzEl = @import("time_az_el.zig").TimeAzEl;
const ISO8601TimeRange = @import("iso8601_time_range.zig").ISO8601TimeRange;

/// A time segment containing azimuth elevation pointing data.
///
/// Each segment defines a continuous time period with pointing angle data
/// points. AWS Ground Station uses 4th order Lagrange interpolation between the
/// provided points, so each segment must contain at least five data points.
pub const AzElSegment = struct {
    /// List of time-tagged azimuth elevation data points.
    ///
    /// Must contain at least five points to support 4th order Lagrange
    /// interpolation. Points must be in chronological order with no duplicates.
    az_el_list: []const TimeAzEl,

    /// The reference time for this segment in ISO 8601 format in Coordinated
    /// Universal Time (UTC).
    ///
    /// All time values within the segment's AzElSegment$azElList are specified as
    /// offsets in atomic seconds from this reference epoch.
    ///
    /// Example: `2024-01-15T12:00:00.000Z`
    reference_epoch: i64,

    /// The valid time range for this segment.
    ///
    /// Specifies the start and end timestamps in ISO 8601 format in Coordinated
    /// Universal Time (UTC). The segment's pointing data must cover this entire
    /// time range.
    valid_time_range: ISO8601TimeRange,

    pub const json_field_names = .{
        .az_el_list = "azElList",
        .reference_epoch = "referenceEpoch",
        .valid_time_range = "validTimeRange",
    };
};
