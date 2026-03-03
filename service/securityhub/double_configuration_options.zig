/// The options for customizing a security control parameter that is a double.
pub const DoubleConfigurationOptions = struct {
    /// The Security Hub default value for a control parameter that is a double.
    default_value: ?f64 = null,

    /// The maximum valid value for a control parameter that is a double.
    max: ?f64 = null,

    /// The minimum valid value for a control parameter that is a double.
    min: ?f64 = null,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .max = "Max",
        .min = "Min",
    };
};
