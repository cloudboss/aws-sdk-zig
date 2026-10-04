const IntegerConstraints = @import("integer_constraints.zig").IntegerConstraints;

/// An integer parameter configuration with default value and constraints.
pub const IntegerParameterConfig = struct {
    /// The constraints for the integer parameter.
    constraints: ?IntegerConstraints = null,

    /// The default value for the integer parameter.
    default_value: ?i32 = null,

    pub const json_field_names = .{
        .constraints = "constraints",
        .default_value = "defaultValue",
    };
};
