const SetDimension = @import("set_dimension.zig").SetDimension;
const GPSPointDimension = @import("gps_point_dimension.zig").GPSPointDimension;

/// Specifies geographical dimension settings for a segment.
pub const SegmentLocation = struct {
    /// The country or region code, in ISO 3166-1 alpha-2 format, for the segment.
    country: ?SetDimension = null,

    /// The GPS location and range for the segment.
    gps_point: ?GPSPointDimension = null,

    pub const json_field_names = .{
        .country = "Country",
        .gps_point = "GPSPoint",
    };
};
