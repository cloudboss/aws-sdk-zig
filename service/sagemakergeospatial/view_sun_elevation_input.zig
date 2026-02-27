/// The input structure for specifying ViewSunElevation angle property filter.
pub const ViewSunElevationInput = struct {
    /// The lower bound to view the sun elevation.
    lower_bound: f32,

    /// The upper bound to view the sun elevation.
    upper_bound: f32,

    pub const json_field_names = .{
        .lower_bound = "LowerBound",
        .upper_bound = "UpperBound",
    };
};
