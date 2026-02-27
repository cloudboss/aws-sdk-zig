const AzElSegmentsData = @import("az_el_segments_data.zig").AzElSegmentsData;

/// Azimuth elevation ephemeris data.
///
/// Use this ephemeris type to provide pointing angles directly, rather than
/// satellite orbital elements. Use this when you need precise antenna pointing
/// but have imprecise or unknown satellite trajectory information.
///
/// The azimuth elevation data specifies the antenna pointing direction at
/// specific times relative to a ground station location. AWS Ground Station
/// uses 4th order Lagrange interpolation to compute pointing angles between the
/// provided data points.
///
/// AWS Ground Station automatically filters interpolated pointing angles,
/// including only those that are above the site mask elevation of the specified
/// ground station.
///
/// For more detail about providing azimuth elevation ephemerides to AWS Ground
/// Station, see the [azimuth elevation ephemeris
/// section](https://docs.aws.amazon.com/ground-station/latest/ug/providing-azimuth-elevation-ephemeris-data.html) of the AWS Ground Station User Guide.
pub const AzElEphemeris = struct {
    /// Azimuth elevation segment data.
    ///
    /// You can provide data inline in the request or through an Amazon S3 object
    /// reference.
    data: AzElSegmentsData,

    /// The ground station name for which you're providing azimuth elevation data.
    ///
    /// This ephemeris is specific to this ground station and can't be used at other
    /// locations.
    ground_station: []const u8,

    pub const json_field_names = .{
        .data = "data",
        .ground_station = "groundStation",
    };
};
