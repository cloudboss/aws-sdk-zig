const DynamicDefaultValue = @import("dynamic_default_value.zig").DynamicDefaultValue;

/// The default values of the `StringParameterDeclaration`.
pub const StringDefaultValues = struct {
    /// The dynamic value of the `StringDefaultValues`. Different defaults displayed
    /// according to users, groups, and values mapping.
    dynamic_value: ?DynamicDefaultValue,

    /// The static values of the `DecimalDefaultValues`.
    static_values: ?[]const []const u8,

    pub const json_field_names = .{
        .dynamic_value = "DynamicValue",
        .static_values = "StaticValues",
    };
};
