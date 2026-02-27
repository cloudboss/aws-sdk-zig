const DynamicDefaultValue = @import("dynamic_default_value.zig").DynamicDefaultValue;

/// The default values of the `DecimalParameterDeclaration`.
pub const DecimalDefaultValues = struct {
    /// The dynamic value of the `DecimalDefaultValues`. Different defaults are
    /// displayed according to users, groups, and values mapping.
    dynamic_value: ?DynamicDefaultValue,

    /// The static values of the `DecimalDefaultValues`.
    static_values: ?[]const f64,

    pub const json_field_names = .{
        .dynamic_value = "DynamicValue",
        .static_values = "StaticValues",
    };
};
