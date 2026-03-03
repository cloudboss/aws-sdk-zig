const InvalidParameterProblem = @import("invalid_parameter_problem.zig").InvalidParameterProblem;

/// Information about an invalid parameter.
pub const InvalidParameterDetail = struct {
    /// The reason the parameter is invalid.
    problem: ?InvalidParameterProblem = null,

    pub const json_field_names = .{
        .problem = "Problem",
    };
};
