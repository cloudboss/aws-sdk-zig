/// The input structure for specifying ViewSunAzimuth property filter.
/// ViewSunAzimuth refers to the Sun azimuth angle.
/// From the scene center point on the ground,
/// this is the angle between truth north and the sun.
/// Measured clockwise in degrees (0-360).
pub const ViewSunAzimuthInput = struct {
    /// The minimum value for ViewSunAzimuth property filter.
    /// This filters items having ViewSunAzimuth greater than or equal to this
    /// value.
    lower_bound: f32,

    /// The maximum value for ViewSunAzimuth property filter.
    /// This filters items having ViewSunAzimuth lesser than or equal to this value.
    upper_bound: f32,

    pub const json_field_names = .{
        .lower_bound = "LowerBound",
        .upper_bound = "UpperBound",
    };
};
