/// Price range with a minimum and maximum value, if a range.
pub const RouteTollPriceValueRange = struct {
    /// Maximum price.
    max: f64,

    /// Minimum price.
    min: f64,

    pub const json_field_names = .{
        .max = "Max",
        .min = "Min",
    };
};
