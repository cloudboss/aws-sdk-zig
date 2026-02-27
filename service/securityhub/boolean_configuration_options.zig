/// The options for customizing a security control parameter with a boolean. For
/// a boolean parameter, the options are
/// `true` and `false`.
pub const BooleanConfigurationOptions = struct {
    /// The Security Hub default value for a boolean parameter.
    default_value: ?bool,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
    };
};
