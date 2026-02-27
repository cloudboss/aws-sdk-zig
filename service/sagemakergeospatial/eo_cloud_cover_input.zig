/// The structure representing the EoCloudCover filter.
pub const EoCloudCoverInput = struct {
    /// Lower bound for EoCloudCover.
    lower_bound: f32,

    /// Upper bound for EoCloudCover.
    upper_bound: f32,

    pub const json_field_names = .{
        .lower_bound = "LowerBound",
        .upper_bound = "UpperBound",
    };
};
