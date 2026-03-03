/// An Object to define the minimum and maximum proficiency levels.
pub const Range = struct {
    /// The maximum proficiency level of the range.
    max_proficiency_level: ?f32 = null,

    /// The minimum proficiency level of the range.
    min_proficiency_level: ?f32 = null,

    pub const json_field_names = .{
        .max_proficiency_level = "MaxProficiencyLevel",
        .min_proficiency_level = "MinProficiencyLevel",
    };
};
