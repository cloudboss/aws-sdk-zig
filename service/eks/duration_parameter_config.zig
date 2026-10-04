const DurationConstraints = @import("duration_constraints.zig").DurationConstraints;

/// A duration parameter configuration with default value and constraints.
pub const DurationParameterConfig = struct {
    /// The constraints for the duration parameter.
    constraints: ?DurationConstraints = null,

    /// The default value for the duration parameter.
    default_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .constraints = "constraints",
        .default_value = "defaultValue",
    };
};
