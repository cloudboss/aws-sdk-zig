const ValueWhenUnsetOption = @import("value_when_unset_option.zig").ValueWhenUnsetOption;

/// A parameter declaration for the `Integer` data type.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const IntegerValueWhenUnsetConfiguration = struct {
    /// A custom value that's used when the value of a parameter isn't set.
    custom_value: ?i64 = null,

    /// The built-in options for default values. The value can be one of the
    /// following:
    ///
    /// * `RECOMMENDED`: The recommended value.
    ///
    /// * `NULL`: The `NULL` value.
    value_when_unset_option: ?ValueWhenUnsetOption = null,

    pub const json_field_names = .{
        .custom_value = "CustomValue",
        .value_when_unset_option = "ValueWhenUnsetOption",
    };
};
