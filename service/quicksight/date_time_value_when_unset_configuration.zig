const ValueWhenUnsetOption = @import("value_when_unset_option.zig").ValueWhenUnsetOption;

/// The configuration that defines the default value of a `DateTime` parameter
/// when a value has not been set.
pub const DateTimeValueWhenUnsetConfiguration = struct {
    /// A custom value that's used when the value of a parameter isn't set.
    custom_value: ?i64,

    /// The built-in options for default values. The value can be one of the
    /// following:
    ///
    /// * `RECOMMENDED`: The recommended value.
    ///
    /// * `NULL`: The `NULL` value.
    value_when_unset_option: ?ValueWhenUnsetOption,

    pub const json_field_names = .{
        .custom_value = "CustomValue",
        .value_when_unset_option = "ValueWhenUnsetOption",
    };
};
