/// Range of area under curve (auc) expected from the model. A range greater
/// than 0.1 indicates higher model uncertainity.
/// A range is the difference between upper and lower bound of auc.
pub const UncertaintyRange = struct {
    /// The lower bound value of the area under curve (auc).
    lower_bound_value: f32,

    /// The upper bound value of the area under curve (auc).
    upper_bound_value: f32,

    pub const json_field_names = .{
        .lower_bound_value = "lowerBoundValue",
        .upper_bound_value = "upperBoundValue",
    };
};
