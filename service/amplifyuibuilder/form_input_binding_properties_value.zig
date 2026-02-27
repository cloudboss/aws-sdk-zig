const FormInputBindingPropertiesValueProperties = @import("form_input_binding_properties_value_properties.zig").FormInputBindingPropertiesValueProperties;

/// Represents the data binding configuration for a form's input fields at
/// runtime.You can use
/// `FormInputBindingPropertiesValue` to add exposed properties to a form to
/// allow
/// different values to be entered when a form is reused in different places in
/// an app.
pub const FormInputBindingPropertiesValue = struct {
    /// Describes the properties to customize with data at runtime.
    binding_properties: ?FormInputBindingPropertiesValueProperties,

    /// The property type.
    type: ?[]const u8,

    pub const json_field_names = .{
        .binding_properties = "bindingProperties",
        .type = "type",
    };
};
