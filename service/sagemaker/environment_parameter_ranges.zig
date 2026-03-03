const CategoricalParameter = @import("categorical_parameter.zig").CategoricalParameter;

/// Specifies the range of environment parameters
pub const EnvironmentParameterRanges = struct {
    /// Specified a list of parameters for each category.
    categorical_parameter_ranges: ?[]const CategoricalParameter = null,

    pub const json_field_names = .{
        .categorical_parameter_ranges = "CategoricalParameterRanges",
    };
};
