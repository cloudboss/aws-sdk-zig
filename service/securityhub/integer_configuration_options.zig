/// The options for customizing a security control parameter that is an integer.
pub const IntegerConfigurationOptions = struct {
    /// The Security Hub default value for a control parameter that is an integer.
    default_value: ?i32,

    /// The maximum valid value for a control parameter that is an integer.
    max: ?i32,

    /// The minimum valid value for a control parameter that is an integer.
    min: ?i32,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .max = "Max",
        .min = "Min",
    };
};
