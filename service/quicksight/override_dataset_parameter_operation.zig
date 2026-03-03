const NewDefaultValues = @import("new_default_values.zig").NewDefaultValues;

/// A transform operation that overrides the dataset parameter values that are
/// defined in another dataset.
pub const OverrideDatasetParameterOperation = struct {
    /// The new default values for the parameter.
    new_default_values: ?NewDefaultValues = null,

    /// The new name for the parameter.
    new_parameter_name: ?[]const u8 = null,

    /// The name of the parameter to be overridden with different values.
    parameter_name: []const u8,

    pub const json_field_names = .{
        .new_default_values = "NewDefaultValues",
        .new_parameter_name = "NewParameterName",
        .parameter_name = "ParameterName",
    };
};
