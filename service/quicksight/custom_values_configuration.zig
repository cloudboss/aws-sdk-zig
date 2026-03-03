const CustomParameterValues = @import("custom_parameter_values.zig").CustomParameterValues;

/// The configuration of custom values for the destination parameter in
/// `DestinationParameterValueConfiguration`.
pub const CustomValuesConfiguration = struct {
    custom_values: CustomParameterValues,

    /// Includes the null value in custom action parameter values.
    include_null_value: ?bool = null,

    pub const json_field_names = .{
        .custom_values = "CustomValues",
        .include_null_value = "IncludeNullValue",
    };
};
