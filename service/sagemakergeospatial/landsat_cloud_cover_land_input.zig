/// The structure representing Land Cloud Cover property for Landsat data
/// collection.
pub const LandsatCloudCoverLandInput = struct {
    /// The minimum value for Land Cloud Cover property filter. This will filter
    /// items
    /// having Land Cloud Cover greater than or equal to this value.
    lower_bound: f32,

    /// The maximum value for Land Cloud Cover property filter.
    /// This will filter items having Land Cloud Cover less than or equal to this
    /// value.
    upper_bound: f32,

    pub const json_field_names = .{
        .lower_bound = "LowerBound",
        .upper_bound = "UpperBound",
    };
};
