/// The options for customizing a security control parameter that is a list of
/// integers.
pub const IntegerListConfigurationOptions = struct {
    /// The Security Hub default value for a control parameter that is a list of
    /// integers.
    default_value: ?[]const i32 = null,

    /// The maximum valid value for a control parameter that is a list of integers.
    max: ?i32 = null,

    /// The maximum number of list items that an interger list control parameter can
    /// accept.
    max_items: ?i32 = null,

    /// The minimum valid value for a control parameter that is a list of integers.
    min: ?i32 = null,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .max = "Max",
        .max_items = "MaxItems",
        .min = "Min",
    };
};
