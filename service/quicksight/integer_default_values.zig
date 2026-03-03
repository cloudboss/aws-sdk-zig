const DynamicDefaultValue = @import("dynamic_default_value.zig").DynamicDefaultValue;

/// The default values of the `IntegerParameterDeclaration`.
pub const IntegerDefaultValues = struct {
    /// The dynamic value of the `IntegerDefaultValues`. Different defaults are
    /// displayed according to users, groups, and values mapping.
    dynamic_value: ?DynamicDefaultValue = null,

    /// The static values of the `IntegerDefaultValues`.
    static_values: ?[]const i64 = null,

    pub const json_field_names = .{
        .dynamic_value = "DynamicValue",
        .static_values = "StaticValues",
    };
};
