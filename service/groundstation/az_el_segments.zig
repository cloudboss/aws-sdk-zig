const AngleUnits = @import("angle_units.zig").AngleUnits;
const AzElSegment = @import("az_el_segment.zig").AzElSegment;

/// Azimuth elevation segment collection.
///
/// Contains five or more time-ordered segments that define antenna pointing
/// angles over the ephemeris validity period.
pub const AzElSegments = struct {
    /// The unit of measure for azimuth and elevation angles. All angles in all
    /// segments must use the same unit.
    angle_unit: AngleUnits,

    /// List of azimuth elevation segments.
    ///
    /// Must contain between 1 and 100 segments. Segments must be in chronological
    /// order with no overlaps.
    az_el_segment_list: []const AzElSegment,

    pub const json_field_names = .{
        .angle_unit = "angleUnit",
        .az_el_segment_list = "azElSegmentList",
    };
};
