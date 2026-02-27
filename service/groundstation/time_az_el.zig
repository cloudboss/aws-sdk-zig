/// Time-tagged azimuth elevation pointing data.
///
/// Specifies the antenna pointing direction at a specific time offset from the
/// segment's reference epoch.
pub const TimeAzEl = struct {
    /// Azimuth angle at the specified time.
    ///
    /// Valid ranges by unit:
    ///
    /// * `DEGREE_ANGLE`: -180 to 360 degrees, measured clockwise from true north
    /// * `RADIAN`: -π to 2π radians, measured clockwise from true north
    az: f64,

    /// Time offset in atomic seconds from the segment's reference epoch.
    ///
    /// All `dt` values within a segment must be in ascending order with no
    /// duplicates.
    ///
    /// `dt` values may be:
    ///
    /// * negative
    /// * expressed as fractions of a second
    /// * expressed in scientific notation
    dt: f64,

    /// Elevation angle at the specified time.
    ///
    /// Valid ranges by unit:
    ///
    /// * `DEGREE_ANGLE`: -90 to 90 degrees, where 0 is the horizon, 90 is zenith,
    ///   and negative values are below the horizon
    /// * `RADIAN`: -π/2 to π/2 radians, where 0 is the horizon, π/2 is zenith, and
    ///   negative values are below the horizon
    el: f64,

    pub const json_field_names = .{
        .az = "az",
        .dt = "dt",
        .el = "el",
    };
};
