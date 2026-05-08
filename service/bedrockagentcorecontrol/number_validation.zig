/// Validation for NUMBER fields.
pub const NumberValidation = struct {
    /// Maximum allowed value.
    max_value: ?f64 = null,

    /// Minimum allowed value.
    min_value: ?f64 = null,

    pub const json_field_names = .{
        .max_value = "maxValue",
        .min_value = "minValue",
    };
};
