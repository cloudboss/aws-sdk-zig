const aws = @import("aws");

const FormInputBindingPropertiesValue = @import("form_input_binding_properties_value.zig").FormInputBindingPropertiesValue;
const ValueMapping = @import("value_mapping.zig").ValueMapping;

/// Represents the data binding configuration for a value map.
pub const ValueMappings = struct {
    /// The information to bind fields to data at runtime.
    binding_properties: ?[]const aws.map.MapEntry(FormInputBindingPropertiesValue) = null,

    /// The value and display value pairs.
    values: []const ValueMapping,

    pub const json_field_names = .{
        .binding_properties = "bindingProperties",
        .values = "values",
    };
};
