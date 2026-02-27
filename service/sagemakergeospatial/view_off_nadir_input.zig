/// The input structure for specifying ViewOffNadir property filter.
/// ViewOffNadir refers to the angle from the sensor between
/// nadir (straight down) and the scene center. Measured in degrees (0-90).
pub const ViewOffNadirInput = struct {
    /// The minimum value for ViewOffNadir property filter.
    /// This filters items having ViewOffNadir greater than or equal to this value.
    lower_bound: f32,

    /// The maximum value for ViewOffNadir property filter.
    /// This filters items having ViewOffNadir lesser than or equal to this value.
    upper_bound: f32,

    pub const json_field_names = .{
        .lower_bound = "LowerBound",
        .upper_bound = "UpperBound",
    };
};
