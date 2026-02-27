/// The numerical range value type to compare a command parameter value against.
pub const CommandParameterValueNumberRange = struct {
    /// The maximum value of a numerical range of a command parameter value.
    max: []const u8,

    /// The minimum value of a numerical range of a command parameter value.
    min: []const u8,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
