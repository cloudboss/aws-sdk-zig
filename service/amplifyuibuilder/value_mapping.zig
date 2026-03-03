const FormInputValueProperty = @import("form_input_value_property.zig").FormInputValueProperty;

/// Associates a complex object with a display value. Use `ValueMapping` to
/// store
/// how to represent complex objects when they are displayed.
pub const ValueMapping = struct {
    /// The value to display for the complex object.
    display_value: ?FormInputValueProperty = null,

    /// The complex object.
    value: FormInputValueProperty,

    pub const json_field_names = .{
        .display_value = "displayValue",
        .value = "value",
    };
};
