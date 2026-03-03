const FormInputValuePropertyBindingProperties = @import("form_input_value_property_binding_properties.zig").FormInputValuePropertyBindingProperties;

/// Describes the configuration for an input field on a form. Use
/// `FormInputValueProperty` to specify the values to render or bind by
/// default.
pub const FormInputValueProperty = struct {
    /// The information to bind fields to data at runtime.
    binding_properties: ?FormInputValuePropertyBindingProperties = null,

    /// A list of form properties to concatenate to create the value to assign to
    /// this field
    /// property.
    concat: ?[]const FormInputValueProperty = null,

    /// The value to assign to the input field.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .binding_properties = "bindingProperties",
        .concat = "concat",
        .value = "value",
    };
};
