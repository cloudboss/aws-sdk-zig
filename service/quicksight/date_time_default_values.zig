const DynamicDefaultValue = @import("dynamic_default_value.zig").DynamicDefaultValue;
const RollingDateConfiguration = @import("rolling_date_configuration.zig").RollingDateConfiguration;

/// The default values of the `DateTimeParameterDeclaration`.
pub const DateTimeDefaultValues = struct {
    /// The dynamic value of the `DataTimeDefaultValues`. Different defaults are
    /// displayed according to users, groups, and values mapping.
    dynamic_value: ?DynamicDefaultValue,

    /// The rolling date of the `DataTimeDefaultValues`. The date is determined from
    /// the dataset based on input expression.
    rolling_date: ?RollingDateConfiguration,

    /// The static values of the `DataTimeDefaultValues`.
    static_values: ?[]const i64,

    pub const json_field_names = .{
        .dynamic_value = "DynamicValue",
        .rolling_date = "RollingDate",
        .static_values = "StaticValues",
    };
};
