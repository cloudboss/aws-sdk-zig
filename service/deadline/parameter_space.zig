const StepParameter = @import("step_parameter.zig").StepParameter;

/// The details of a search for two or more step parameters.
pub const ParameterSpace = struct {
    /// The combination expression to use in the search.
    combination: ?[]const u8,

    /// The parameters to search for.
    parameters: []const StepParameter,

    pub const json_field_names = .{
        .combination = "combination",
        .parameters = "parameters",
    };
};
